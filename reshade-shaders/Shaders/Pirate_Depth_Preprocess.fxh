//===================================================================================================================
uniform bool DEPTH_INVERT <
	ui_label = "Depth - Invert";
	> = false;
uniform bool DEPTH_INVERT_Y <
	ui_label = "Depth - Invert Up/down";
	ui_tooltip = "Inverts Y, happens on Unity games.";
	> = false;
uniform bool DEPTH_USE_FARPLANE <
	ui_label = "Depth - Use Farplane / Logarithm";
	> = false;
uniform float DEPTH_FARPLANE <
	ui_label = "Depth - Farplane";
	ui_tooltip = "Controls the depth curve. 1.0 is the same as turning farplane off. Some games like GTAV use numbers under 1.0.";
	> = 200.0;
uniform bool DEPTH_DEBUG <
	ui_label = "Depth - Debug";
	ui_tooltip = "Shows depth, you want close objects to be black and far objects to be white for things to work properly.";
	> = false;
//===================================================================================================================
texture2D	texDepth : DEPTH;
sampler2D	SamplerDepth {Texture = texDepth; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};

texture2D	TexNormalDepth {Width = BUFFER_WIDTH * DEPTH_TEXTURE_QUALITY; Height = BUFFER_HEIGHT * DEPTH_TEXTURE_QUALITY; Format = RGBA16; MipLevels = DEPTH_AO_MIPLEVELS;};
sampler2D	SamplerND {Texture = TexNormalDepth; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
//===================================================================================================================
float GetDepth(float2 coords)
{
	if (DEPTH_INVERT_Y) coords.y = 1.0 - coords.y;
	float depth = tex2D(SamplerDepth, coords.xy).x;
	if (DEPTH_USE_FARPLANE)	depth /= DEPTH_FARPLANE - depth * DEPTH_FARPLANE + depth;
	if (DEPTH_INVERT) depth = 1.0 - depth;
	return saturate(depth);
}

float3 GetEyePosition(float2 coords)
{
	// Copied from Master Effects
	float EyeDepth = GetDepth(coords.xy); 
	return float3((coords.xy * 2.0 - 1.0)*EyeDepth,EyeDepth);
}

float4 GetNormalDepth(float2 coords)
{
#if DEPTH_AO_USE_ALCHEMY
#define NORMAL_MODE 0
#else
#define NORMAL_MODE 1
#endif
#if NORMAL_MODE
	// Copied from Master Effects
	float3 centerPos = GetEyePosition(coords.xy);
	float3 ddx1 = GetEyePosition(coords.xy + float2(PixelSize.x, 0)) - centerPos;
	float3 ddx2 = centerPos - GetEyePosition(coords.xy + float2(-PixelSize.x, 0));

	float3 ddy1 = GetEyePosition(coords.xy + float2(0, PixelSize.y)) - centerPos;
	float3 ddy2 = centerPos - GetEyePosition(coords.xy + float2(0, -PixelSize.y));

	ddx1 = lerp(ddx1, ddx2, abs(ddx1.z) > abs(ddx2.z));
	ddy1 = lerp(ddy1, ddy2, abs(ddy1.z) > abs(ddy2.z));

	float3 normal = cross(ddy1, ddx1);
	normal = (normalize(normal) + 1.0) * 0.5;
	
	return float4(normal, GetDepth(coords));
#else
	// Wrote this first, but with my gatherer, this actually causes halos, but works so much better
	// than the method above for the Alchemy gatherer, so I kept it for when alchemy is being used.
	const float2 offsety = float2(0.0, PixelSize.y * 1);
  	const float2 offsetx = float2(PixelSize.x * 1, 0.0);
	
	float pointdepth = GetDepth(coords);
  
  	float depthy = GetDepth(coords + offsety);
  	float depthx = GetDepth(coords + offsetx);
  
  	float3 p1 = float3(offsety * depthy, depthy - pointdepth);
  	float3 p2 = float3(offsetx * depthx, depthx - pointdepth);
  
  	float3 normal = cross(p1, p2);
	normal = (normalize(normal) + 1.0) * 0.5;
  
  	return float4(normal, pointdepth);
#endif
}
//===================================================================================================================
float4 PS_DepthPrePass(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
	return GetNormalDepth(texcoord);
}
//===================================================================================================================
technique Pirate_DepthPreProcess
{
	pass DepthPre
	{
		VertexShader = VS_PostProcess;
		PixelShader  = PS_DepthPrePass;
		RenderTarget = TexNormalDepth;
	}
}