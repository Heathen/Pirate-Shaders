//===================================================================================================================
// AO Specific settings
uniform float DEPTH_AO_RADIUS <
	ui_label = "AO+IL+SC - Radius";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 200.0;
	> = 50.0;

uniform int DEPTH_AO_CURVE_MODE <
	ui_label = "AO - Curve Mode";
	ui_type = "combo";
	ui_items = "Linear\0Squared\0Log\0Sine\0";
	> = 1;
uniform float DEPTH_AO_CULL_HALO <
	ui_label = "AO - Cull Halo";
	ui_tooltip = "Try to keep as close to 0.0 as possible, only lift this up if there are bright lines around objects that have occlusion behind them.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 0.5;
	> = 0.0;
uniform float DEPTH_AO_STRENGTH <
	ui_label = "AO - Strength";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 30.0;
	> = 5.0;
uniform int DEPTH_AO_BLEND_MODE <
	ui_label = "AO - Blend Mode";
	ui_type = "combo";
	ui_items = "Subtract\0Multiply\0Color burn\0";
	> = 1;		
// Distance culling and farplane specific settings
uniform float DEPTH_AO_MANUAL_NEAR <
	ui_label = "AO + IL - Manual Z Depth - Near";
	ui_tooltip = "Increase this if nearby objects are casting black halos on far away objects.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 20.0;
	> = 1.0;
uniform float DEPTH_AO_MANUAL_FAR <
	ui_label = "AO + IL - Manual Z Depth - Far";
	ui_tooltip = "Same as above, but for far away objects.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1000.0;
	> = 500.0;
uniform float DEPTH_AO_MANUAL_CURVE <
	ui_label = "AO + IL - Manual Z Depth - Curve";
	ui_tooltip = "Controls the curve between near and far.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 2.0;
	> = 1.0;
#define DEPTH_AO_CULLING		1.0	//[0.0 to 2.0] (For automatic culling only) 1.0 - No effect, lower this if it's occluding things that shouldn't be occluded
// Global illumination specific things
uniform float DEPTH_AO_IL_STRENGTH <
	ui_label = "IL - Strength";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 30.0;
	> = 4.0;
uniform int DEPTH_AO_IL_CURVE_MODE <
	ui_label = "IL - Curve Mode";
	ui_type = "combo";
	ui_items = "Linear\0Squared\0Log\0Sine\0Mid Range Sine\0";
	> = 4;
uniform int DEPTH_AO_IL_BLEND_MODE <
	ui_label = "IL + SC - Blend Mode";
	ui_type = "combo";
	ui_items = "Linear\0Screen\0Soft Light\0Color Dodge\0Hybrid\0";
	> = 2;	

// Scatter light, needs IL
uniform float DEPTH_AO_SCATTER_THRESHOLD <
	ui_label = "Scatter - Threshold";
	ui_tooltip = "Only light values above this will cause scatter.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1.0;
	> = 0.85;
uniform float DEPTH_AO_SCATTER_STRENGTH <
	ui_label = "Scatter - Strength";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 30.0;
	> = 3.5;
uniform int DEPTH_AO_SCATTER_CURVE_MODE <
	ui_label = "Scatter - Curve Mode";
	ui_type = "combo";
	ui_items = "Linear\0Squared\0Log\0Sine\0Mid Range Sine\0";
	> = 0;

// Alchemy specific settings
uniform float DEPTH_AO_ALCHEMY_ANGLE <
	ui_label = "AO - Alchemy - Angle";
	ui_tooltip = "These two values are a pain to set, have to fiddle with really tiny values to get it to look good.";
	> = -0.0003;
uniform float DEPTH_AO_ALCHEMY_DISTANCE <
	ui_label = "AO - Alchemy - Distance";
	ui_tooltip = "Obviously the above deals with angle, this one with distance.";
	> = 0.00002;
uniform float DEPTH_AO_ALCHEMY_STRENGTH <
	ui_label = "AO - Alchemy - Strength";
	ui_tooltip = "Strength of the alchemy gatherer, very small values. Leave AO Strength at 1.0 if you're using alchemy and control it here.";
	> = 0.005;
// AO/GI Blur
uniform float DEPTH_AO_BLUR_RADIUS <
	ui_label = "Blur - Radius";
	ui_tooltip = "Radius of the blur.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 2.0;
	> = 1.0;
uniform float DEPTH_AO_BLUR_NOISE <
	ui_label = "Blur - Noise";
	ui_tooltip = "Controls how much noise should remain after the blur.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1.0;
	> = 0.0;	
uniform float DEPTH_AO_BLUR_WEIGHT <
	ui_label = "Blur - Directional Weight";
	ui_tooltip = "When blur is set to weighted, it controls how much normals matter for the blur.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1.0;
	> = 1.0;	

// Quality and Debug stuff
uniform int DEPTH_AO_DEBUG <
	ui_label = "Debug - AO/IL/Scatter";
	ui_type = "combo";
	ui_items = "None\0AO\0IL + Scatter\0Both\0";
	> = 0;
uniform float DEPTH_AO_DEBUG_IMAGE <
	ui_label = "Debug - Image";
	ui_tooltip = "In debug mode, the higher this value the more the background is shown.";
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1.0;
	> = 0.1;
//===================================================================================================================
texture2D	TexColorLOD {Width = BUFFER_WIDTH * DEPTH_COLOR_TEXTUE_QUALITY; Height = BUFFER_HEIGHT * DEPTH_COLOR_TEXTUE_QUALITY; Format = RGBA8;}; //MipLevels = DEPTH_AO_MIPLEVELS;
sampler2D	SamplerColorLOD {Texture = TexColorLOD; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};

texture2D	TexAOIL {Width = BUFFER_WIDTH * DEPTH_AO_TEXTURE_QUALITY; Height = BUFFER_HEIGHT * DEPTH_AO_TEXTURE_QUALITY; Format = RGBA8;};
sampler2D	SamplerAOIL {Texture = TexAOIL; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
texture2D	TexAOIL2 {Width = BUFFER_WIDTH * DEPTH_AO_TEXTURE_QUALITY; Height = BUFFER_HEIGHT * DEPTH_AO_TEXTURE_QUALITY; Format = RGBA8;};
sampler2D	SamplerAOIL2 {Texture = TexAOIL2; MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR; AddressU = Clamp; AddressV = Clamp;};
//===================================================================================================================
#define pi 3.14159265359f
#define threepitwo 4.71238898038f

float GetRandom(float2 co){ // From http://stackoverflow.com/questions/4200224/random-noise-functions-for-glsl
	return frac(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
}
float GetRandomT(float2 co){
	return frac(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453 + Timer * 0.0002);
}
float2 RandomRotate(float2 coords) {
	return normalize(float2(coords.x * sin(GetRandom(coords.y)), coords.y * cos(GetRandom(coords.x))));
}
float2 Rotate45(float2 coords) {
	#define sincos45 0.70710678118
	float x = coords.x * sincos45;
	float y = coords.y * sincos45;
	return float2(x - y, x + y);
}
float2 Rotate90(float2 coords){
	return float2(-coords.y, coords.x);
}
float2 GetRandomVector(float2 coords) {
	return normalize(float2(GetRandom(coords)*2-1, GetRandom(1.42 * coords)*2-1));
}

// Cumulative method, mainly based on http://john-chapman-graphics.blogspot.com.br/2013/01/ssao-tutorial.html
// But instead of making a hemisphere of points, I first check if my points are on the right side of the
// sphere, then check if the distance of that point to the centre of the hemisphere is less than the maximum radius.
//
// Alternatively, there is the alchemy gatherer, based on http://graphics.cs.williams.edu/papers/AlchemyHPG11/VV11AlchemyAO.pdf
// As both methods are really similar.
//
// Might do an horizon method later, but that would require pretty much a full rewrite and I think the noise from
// gatherers is more pleasing.
float4 GetAO(float2 coords)
{
	float4 pointnd = tex2D(SamplerND, coords);
	[branch] if (pointnd.w > DEPTH_AO_FADE_END) discard; // Bye bye pixels
	pointnd.xyz = (pointnd.xyz * 2.0) - 1.0;
	pointnd.z = min(pointnd.z, 0.0) - DEPTH_AO_CULL_HALO;
	pointnd.xyz = normalize(pointnd.xyz);
	float3 pointeyevector = float3((coords * 2.0 - 1.0) * pointnd.w, pointnd.w);
	
	float occlusion;
	float occlusionlow;
	float3 ilum;
	float3 scatter;
	float fade = smoothstep(DEPTH_AO_FADE_END - DEPTH_AO_FADE_START, 0.0, pointnd.w - DEPTH_AO_FADE_START);
	float zoomfactor = pow((1.0 - pointnd.w) * fade, 2); // Not being used right now. Could use later to compress taps that are far in the distance.
	zoomfactor = max(zoomfactor, 0.5);
	float3 tapeyevector;
	
	#if DEPTH_AO_USE_MANUAL_RADIUS
	// I don't have a projection matrix available, that I know of. When you have to use FARPLANE you get non-linear
	// depth, so this is to guesstimate the radius of the distance culling hemisphere.
	// Might even be useful on linear depth, who knows. Depends how you set it up.
	const float averagepixel = (PixelSize.x + PixelSize.y) / 2;
	float hemiradius = lerp(averagepixel * DEPTH_AO_MANUAL_NEAR, averagepixel * DEPTH_AO_MANUAL_FAR, pow(pointnd.w, DEPTH_AO_MANUAL_CURVE));
	#else
	const float hemiradius = ((PixelSize.x + PixelSize.y) / 2) * DEPTH_AO_RADIUS * DEPTH_AO_CULLING;
	#endif
	const float2 pixelradius = DEPTH_AO_RADIUS * PixelSize;
	
	#if DEPTH_AO_LOOP_FIX
	int depth_passes = DEPTH_AO_PASSES + DEPTH_AO_MIN_PASSES;
	#else
	int depth_passes = ceil(smoothstep(DEPTH_AO_FADE_END, 0.0, pointnd.w) * DEPTH_AO_PASSES) + DEPTH_AO_MIN_PASSES;
	#endif
	
	#if DEPTH_AO_TAP_MODE
	const float passdiv = 8 * float(depth_passes);
	#else
	const float passdiv = 4 * float(depth_passes);
	#endif
	
	float2 randomvector = GetRandomVector(coords);

	for(int p=0; p < depth_passes; p++)
	{
		int miplevel = floor(smoothstep(0.0, depth_passes, p) * DEPTH_AO_MIPLEVELS);
		
		#if DEPTH_AO_TAP_MODE
		for(int i=0; i < 8; i++)
		{
			randomvector = Rotate45(randomvector);
		#else
		for(int i=0; i < 4; i++)
		{
			randomvector = Rotate90(randomvector);
		#endif
			#if DEPTH_AO_USE_TIMED_NOISE
			float2 tapcoords = coords + pixelradius * randomvector * zoomfactor * (0.5 + GetRandomT(coords)) * (p + 1) / depth_passes;
			#else
			float2 tapcoords = coords + pixelradius * randomvector * zoomfactor * (p + 1) / depth_passes;
			#endif
			
			float4 tapnd = tex2Dlod(SamplerND, float4(tapcoords, 0, miplevel));
			tapnd.rgb = tapnd.rgb * 2.0 - 1.0;
			tapeyevector = float3(((tapcoords) * 2.0 - 1.0) * tapnd.w, tapnd.w);
			float3 tapvector = tapeyevector - pointeyevector;
			#if DEPTH_AO_USE_ALCHEMY
			// Alchemy is actually faster than the method I used, that's why I added this as an optional.
			// By not normalizing the tapvector and not sqrting the distance, their integral takes
			// less computation to give a very similar result.
			// The only bad side of alchemy is that its settings are very sensitive and a bitch to adjust.
			float gatherer = max(0.0, dot(pointnd.xyz, tapvector)) + DEPTH_AO_ALCHEMY_ANGLE;
			gatherer = gatherer / (dot(tapvector, tapvector) + DEPTH_AO_ALCHEMY_DISTANCE);
			#else
			// My method basically checks if the point is inside the hemisphere and weights it by distance.
			// Sadly it's causing some halos with my normal set up, so I used Marty's for this instead.
			// Figures out, he gathers the AO pretty much the same way in his MXAO.
			float distance = length(tapvector);
			float distculling = smoothstep(hemiradius, 0.0, distance);
			float gatherer = saturate(dot(pointnd.xyz, tapvector/distance)) * distculling;
			#endif

			#if DEPTH_AO_ENABLE
			occlusion += gatherer;
			#endif
			
			#if DEPTH_AO_IL_ENABLE || DEPTH_AO_USE_SCATTER
			float3 coltap = tex2Dlod(SamplerColorLOD, float4(tapcoords, 0, 0)).rgb;
			#endif
			
			#if DEPTH_AO_IL_ENABLE
			#if DEPTH_AO_USE_ALCHEMY
			float distance = length(tapvector);
			#endif
			// GI gatherer is slightly different from AO. Here is an explanation for the curious people.
			// point = center of the hemisphere, tap = point being tested
			// gatherer = how perpendicular center and tap are * how much tap is facing the center, culling taps facing away * how close tap is to the center
			// This gives an alright value to tell if two surfaces would have diffuse light bouncing from one another.
			gatherer = (1.0 - dot(pointnd.xyz, tapnd.xyz)) * max(0.0, -dot(tapvector/distance, tapnd.xyz)) * smoothstep(hemiradius, 0.0, distance);
			ilum += coltap * gatherer;
			#endif
			
			#if DEPTH_AO_USE_SCATTER
			float2 fogc = (tapcoords * 2.0 - 1.0) - (coords * 2.0 - 1.0);
			float fogfactor = -min(0.0, dot(fogc, tapnd.xy));
			scatter += (max(max(coltap.r, coltap.g), coltap.b) > DEPTH_AO_SCATTER_THRESHOLD) * coltap * fogfactor;
			#endif
	
		}
	}
	
	#if DEPTH_AO_IL_ENABLE
	ilum /= passdiv;
	#else
	ilum = 0.0;
	#endif
	#if DEPTH_AO_USE_SCATTER
	scatter /= passdiv;
	#endif
	#if DEPTH_AO_USE_ALCHEMY
	occlusion = (2 * DEPTH_AO_ALCHEMY_STRENGTH / passdiv) * occlusion;
	#else
	occlusion /= passdiv;
	#endif
	

	//if (DEPTH_AO_CURVE_MODE == 0) // Linear
		// Do Nothing
	if (DEPTH_AO_CURVE_MODE == 1) // Squared
		occlusion = pow(occlusion, 2);
	else if (DEPTH_AO_CURVE_MODE == 2) // Logarithm
		occlusion = log10(occlusion * 10.0);
	else if (DEPTH_AO_CURVE_MODE == 3) // Sine
		occlusion = (sin(threepitwo + occlusion * pi) + 1) / 2;
	occlusion = saturate(occlusion * DEPTH_AO_STRENGTH);

	#if DEPTH_AO_IL_ENABLE
	//if (DEPTH_AO_IL_CURVE_MODE == 0) // Linear
		//Do Nothing
	if (DEPTH_AO_IL_CURVE_MODE == 1) // Squared
		ilum = pow(ilum, 2);
	else if (DEPTH_AO_IL_CURVE_MODE == 2) // Logarithm
		ilum = log10(ilum * 10.0);
	else if (DEPTH_AO_IL_CURVE_MODE == 3) // Sine
		ilum = (sin(threepitwo + ilum * pi) + 1) / 2;
	else if (DEPTH_AO_IL_CURVE_MODE == 4) // Mid range Sine
		ilum = sin(ilum * pi);
	ilum = saturate(ilum * DEPTH_AO_IL_STRENGTH);
	#endif

	#if DEPTH_AO_USE_SCATTER
	//if (DEPTH_AO_IL_CURVE_MODE == 0) // Linear
		//Do Nothing
	if (DEPTH_AO_SCATTER_CURVE_MODE == 1) // Squared
		scatter = pow(scatter, 2);
	else if (DEPTH_AO_SCATTER_CURVE_MODE == 2) // Logarithm
		scatter = saturate(log10(scatter * 10.0));
	else if (DEPTH_AO_SCATTER_CURVE_MODE == 3) // Sine
		scatter = (sin(threepitwo + scatter * pi) + 1) / 2;
	else if (DEPTH_AO_SCATTER_CURVE_MODE == 4) // Mid range Sine
		scatter = sin(scatter * pi);
	scatter = saturate(scatter * DEPTH_AO_SCATTER_STRENGTH * 10.0);
	#endif

	ilum += scatter;
	return fade * float4(ilum, occlusion);
}

/*float4 AOBlur(float2 coords)
{
	const float2 offset[8]=
	{
		float2(1.0, 1.0),
		float2(1.0, -1.0),
		float2(-1.0, 1.0),
		float2(-1.0, -1.0),
		float2(0.0, 1.0),
		float2(0.0, -1.0),
		float2(1.0, 0.0),
		float2(-1.0, 0.0)
	};
	
	float4 tap = tex2D(SamplerAOIL, coords);
	float4 ret;
	
	for(int p=0; p < DEPTH_AO_BLUR_TAPS; p++)
	{
		ret += tap;
		for(int i=0; i < 8; i++)
		{
			ret += tex2D(SamplerAOIL, coords + offset[i] * (p + 1) * (PixelSize / DEPTH_AO_TEXTURE_QUALITY) * DEPTH_AO_BLUR_RADIUS);
		}
	}
	
	ret /= 8 * DEPTH_AO_BLUR_TAPS;
	//ret = max(tap, ret); // This can be uncommented in order to keep the noise.
	ret = lerp(ret, tap, tap);
	return ret;
}*/
//===================================================================================================================
float4 PS_GenAO(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
	return GetAO(texcoord);
}

float4 PS_ColorLOD(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
	return tex2D(SamplerColor, texcoord);
}

float4 PS_BlurX(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
	#if (DEPTH_AO_BLUR_MODE == 1) // Weighted
	float3 pointnd = tex2D(SamplerND, texcoord).xyz;
	pointnd = normalize(pointnd * 2.0 - 1.0);
	#elif (DEPTH_AO_BLUR_MODE == 2) // Directional
	float3 pointnd = tex2D(SamplerND, texcoord).xyz;
	pointnd = (pointnd * 2.0) - 1.0;
	float2 c = normalize(pointnd.xy);
	#endif

	if (dot(pointnd, pointnd) == 0) pointnd = float3(0.0, 0.0, 1.0);
	float4 ret = tex2D(SamplerAOIL, texcoord);
	float4 tap = ret;

	
	float w;
	
	for(int i=1; i <= DEPTH_AO_BLUR_TAPS; i++)
	{
		#if (DEPTH_AO_BLUR_MODE == 1) // Weighted
		float2 tapcoord = float2(i * PixelSize.x * DEPTH_AO_BLUR_RADIUS, 0.0);
		w += abs(dot(pointnd, (tex2D(SamplerND, texcoord + tapcoord).xyz * 2.0 - 1.0)));
		w += abs(dot(pointnd, (tex2D(SamplerND, texcoord - tapcoord).xyz * 2.0 - 1.0)));
		ret += tex2D(SamplerAOIL, texcoord + tapcoord);
		ret += tex2D(SamplerAOIL, texcoord - tapcoord);
		#elif (DEPTH_AO_BLUR_MODE == 2) // Directional
		float2 tapcoord = float2(i * c * PixelSize * DEPTH_AO_BLUR_RADIUS);
		ret += tex2D(SamplerAOIL, texcoord + tapcoord);
		ret += tex2D(SamplerAOIL, texcoord - tapcoord);
		#else
		float2 tapcoord = float2(i * PixelSize.x * DEPTH_AO_BLUR_RADIUS, 0.0);
		ret += tex2D(SamplerAOIL, texcoord + tapcoord);
		ret += tex2D(SamplerAOIL, texcoord - tapcoord);
		#endif
	}
	
	ret /= DEPTH_AO_BLUR_TAPS * 2 + 1;

	w /= DEPTH_AO_BLUR_TAPS * 2 + 1;
	w = lerp(1.0, w, DEPTH_AO_BLUR_WEIGHT);
	ret = lerp(tap, ret, w);

	ret = lerp(ret, tap, tap * DEPTH_AO_BLUR_NOISE);
	//ret = max(tap, ret);
	return ret;
}

float4 PS_BlurY(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
	#if (DEPTH_AO_BLUR_MODE == 1) // Weighted
	float3 pointnd = tex2D(SamplerND, texcoord).xyz;
	pointnd = (pointnd * 2.0) - 1.0;
	#elif (DEPTH_AO_BLUR_MODE == 2) // Directional
	float3 pointnd = tex2D(SamplerND, texcoord).xyz;
	pointnd = (pointnd * 2.0) - 1.0;
	float2 c = Rotate90(normalize(pointnd.xy));
	#endif
	
	float4 ret = tex2D(SamplerAOIL2, texcoord);
	float4 tap = ret;
	float w;
	
	for(int i=1; i <= DEPTH_AO_BLUR_TAPS; i++)
	{
		#if (DEPTH_AO_BLUR_MODE == 1) // Weighted
		float2 tapcoord = float2(0.0, i * PixelSize.y * DEPTH_AO_BLUR_RADIUS);
		w += abs(dot(pointnd, (tex2D(SamplerND, texcoord + tapcoord).xyz * 2.0 - 1.0)));
		w += abs(dot(pointnd, (tex2D(SamplerND, texcoord - tapcoord).xyz * 2.0 - 1.0)));
		ret += tex2D(SamplerAOIL2, texcoord + tapcoord);
		ret += tex2D(SamplerAOIL2, texcoord - tapcoord);
		#elif (DEPTH_AO_BLUR_MODE == 2) // Directional
		float2 tapcoord = float2(i * c * PixelSize * DEPTH_AO_BLUR_RADIUS);
		ret += tex2D(SamplerAOIL2, texcoord + tapcoord);
		ret += tex2D(SamplerAOIL2, texcoord - tapcoord);
		#else
		float2 tapcoord = float2(0.0, i * PixelSize.y * DEPTH_AO_BLUR_RADIUS);
		ret += tex2D(SamplerAOIL2, texcoord + tapcoord);
		ret += tex2D(SamplerAOIL2, texcoord - tapcoord);
		#endif
	}
	
	ret /= DEPTH_AO_BLUR_TAPS * 2 + 1;

	w /= DEPTH_AO_BLUR_TAPS * 2 + 1;
	w = lerp(1.0, w, DEPTH_AO_BLUR_WEIGHT);
	ret = lerp(tap, ret, w);
	
	ret = lerp(ret, tap, tap * DEPTH_AO_BLUR_NOISE);
	//ret = max(tap, ret);
	//return float4((pointnd + 1.0) / 2.0, 1.0);
	return ret;
}

float4 PS_AOCombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD) : COLOR
{
	float4 ret = tex2D(SamplerColor, texcoord);
	
	if (DEPTH_DEBUG) {
		ret.rgb = tex2D(SamplerND, texcoord).w;
		ret.w = 1.0;
		return ret;
	}

	float4 aoil = tex2D(SamplerAOIL, texcoord);

	float ao = aoil.w;

	// Not entirely happy with this. Might switch to something hybrid like I did with GI.
	//ret.rgb *= lerp(1.0, 1.0 - ao, 1.0 - dot(ret.rgb, 0.3333));
	//ret.rgb -= ao * 0.25;
	if (DEPTH_AO_BLEND_MODE == 0) //Subtract
		ret.rgb = saturate(ret.rgb - ao);
	if (DEPTH_AO_BLEND_MODE == 1) //Multiply
		ret.rgb *= 1.0 - ao;
	if (DEPTH_AO_BLEND_MODE == 2) //Color burn
		ret.rgb = BlendColorBurn(ret.rgb, 1.0 - ao);

	float3 il = aoil.rgb;
	
	if (DEPTH_AO_IL_BLEND_MODE == 0) // Linear
		ret.rgb += il;
	else if (DEPTH_AO_IL_BLEND_MODE == 1) // Screen
		ret.rgb = BlendScreen(ret.rgb, il);
	else if (DEPTH_AO_IL_BLEND_MODE == 2) // Soft Light
		ret.rgb = BlendSoftLight(ret.rgb, 0.5 + il);
	else if (DEPTH_AO_IL_BLEND_MODE == 3) // Color Dodge
		ret.rgb = BlendColorDodge(ret.rgb, il);
	else // Hybrid based on point brightness
		ret.rgb = lerp(ret.rgb + il, ret.rgb * (1.0 + il), dot(ret.rgb, 0.3333));

	if (DEPTH_AO_DEBUG == 1)
		ret.rgb = 0.75 + (ret.rgb * DEPTH_AO_DEBUG_IMAGE) - ao;
	else if (DEPTH_AO_DEBUG == 2)
		ret.rgb = ret.rgb * DEPTH_AO_DEBUG_IMAGE + il;
	else if (DEPTH_AO_DEBUG == 3)
		ret.rgb = 0.5 + ret.rgb * DEPTH_AO_DEBUG_IMAGE + il - ao * 0.3;

	return saturate(ret);
}

//===================================================================================================================
technique Pirate_SSAO
{
	pass ColorPre
	{
		VertexShader = VS_PostProcess;
		PixelShader  = PS_ColorLOD;
		RenderTarget = TexColorLOD;
	}
	pass AOPre
	{
		VertexShader = VS_PostProcess;
		PixelShader  = PS_GenAO;
		RenderTarget = TexAOIL;
	}
	#if DEPTH_AO_USE_BLUR
	pass BlurX
	{
		VertexShader = VS_PostProcess;
		PixelShader  = PS_BlurX;
		RenderTarget = TexAOIL2;
	}
	pass BlurY
	{
		VertexShader = VS_PostProcess;
		PixelShader  = PS_BlurY;
		RenderTarget = TexAOIL;
	}
	#endif
	pass AOFinal
	{
		VertexShader = VS_PostProcess;
		PixelShader  = PS_AOCombine;
	}
}