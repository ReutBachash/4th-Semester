#ifndef AMAZING_ASSETS_LOWPOLY_SHADER_CORE_CGINC
#define AMAZING_ASSETS_LOWPOLY_SHADER_CORE_CGINC

#include "Variables.cginc"
#include "Geometry.cginc"


#ifndef UNITY_SAMPLE_TEX2D_LOD
#define UNITY_SAMPLE_TEX2D_LOD(tex,coord,lod) tex.SampleLevel (sampler##tex,coord, lod)
#endif

#ifndef UNITY_SAMPLE_TEX2D_SAMPLER_LOD
#define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex, samplertex, coord, lod) tex.SampleLevel (sampler##samplertex, coord, lod)
#endif

#define TRANSFORM_TEX_LOWPOLY(uv,tex) (uv.xy * tex##_ST.xy + tex##_ST.zw + tex##_Scroll.xy * _Time.x)



float4 SetupLowpolyColor(float2 uv, float4 vertexColor)
{
	#if defined(_LOWPOLY_SAMPLETYPE_MIDDLE_UV)	

		return vertexColor;		//Texture samples are calculated per-pixel

	#else
		#if defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_ADDITIVE)
			fixed4 c1 = UNITY_SAMPLE_TEX2D_LOD(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex), 0) * _Color;
			fixed4 c2 = UNITY_SAMPLE_TEX2D_SAMPLER_LOD(_Lowpoly_SecondaryTex, _MainTex, TRANSFORM_TEX_LOWPOLY(uv, _Lowpoly_SecondaryTex), 0) * _Lowpoly_SecondaryColor;
	
			fixed4 c = c1 + c2;
		#elif defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_MULTIPLY)
			fixed4 c1 = UNITY_SAMPLE_TEX2D_LOD(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex), 0) * _Color;
			fixed4 c2 = UNITY_SAMPLE_TEX2D_SAMPLER_LOD(_Lowpoly_SecondaryTex, _MainTex, TRANSFORM_TEX_LOWPOLY(uv, _Lowpoly_SecondaryTex), 0) * _Lowpoly_SecondaryColor;
	
			fixed4 c = c1 * c2;
		#elif defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_ALPHA_BLEND)
			fixed4 c1 = UNITY_SAMPLE_TEX2D_LOD(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex), 0);
			fixed4 c2 = UNITY_SAMPLE_TEX2D_SAMPLER_LOD(_Lowpoly_SecondaryTex, _MainTex, TRANSFORM_TEX_LOWPOLY(uv, _Lowpoly_SecondaryTex), 0);
	
			fixed4 c = lerp(c1 * _Color, c2 * _Lowpoly_SecondaryColor, _Lowpoly_SecondaryTex_InvertAlpha > 0.5 ? (1 - c2.a) : c2.a);
		#else
			fixed4 c = UNITY_SAMPLE_TEX2D_LOD(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex), 0) * _Color;
		#endif  

		c = _Lowpoly_UseVertexColor > 0.5 ? (c * vertexColor) : c;
	
		return saturate(c);

	#endif
}

float4 SetupLowpolyColorButForPixelShader(float2 uv, float4 vertexColor)
{
	#if defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_ADDITIVE)
		fixed4 c1 = UNITY_SAMPLE_TEX2D(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex)) * _Color;
		fixed4 c2 = UNITY_SAMPLE_TEX2D_SAMPLER(_Lowpoly_SecondaryTex, _MainTex, TRANSFORM_TEX_LOWPOLY(uv, _Lowpoly_SecondaryTex)) * _Lowpoly_SecondaryColor;
	
		fixed4 c = c1 + c2;
	#elif defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_MULTIPLY)
		fixed4 c1 = UNITY_SAMPLE_TEX2D(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex)) * _Color;
		fixed4 c2 = UNITY_SAMPLE_TEX2D_SAMPLER(_Lowpoly_SecondaryTex, _MainTex, TRANSFORM_TEX_LOWPOLY(uv, _Lowpoly_SecondaryTex)) * _Lowpoly_SecondaryColor;
	
		fixed4 c = c1 * c2;
	#elif defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_ALPHA_BLEND)
		fixed4 c1 = UNITY_SAMPLE_TEX2D(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex));
		fixed4 c2 = UNITY_SAMPLE_TEX2D_SAMPLER(_Lowpoly_SecondaryTex, _MainTex, TRANSFORM_TEX_LOWPOLY(uv, _Lowpoly_SecondaryTex));
	
		fixed4 c = lerp(c1 * _Color, c2 * _Lowpoly_SecondaryColor, _Lowpoly_SecondaryTex_InvertAlpha > 0.5 ? (1 - c2.a) : c2.a);
	#else
		fixed4 c = UNITY_SAMPLE_TEX2D(_MainTex, TRANSFORM_TEX_LOWPOLY(uv, _MainTex)) * _Color;
	#endif  

	c = _Lowpoly_UseVertexColor > 0.5 ? (c * vertexColor) : c;
	
	return saturate(c);
}

#if defined(LOWPOLOY_USING_DIFFUSE_MAPS)
float4 BlendDiffuseAndLowpolyColors(float4 srcColor, float4 overlayColor)
{
	float4 finalColor = srcColor;


	#if defined(_LOWPOLY_DIFFUSEBLENDMODE_ADDITIVE)
		finalColor = saturate(srcColor + overlayColor);
	#elif defined(_LOWPOLY_DIFFUSEBLENDMODE_MULTIPLY)
		finalColor = saturate(srcColor * overlayColor);
	#elif defined(_LOWPOLY_DIFFUSEBLENDMODE_ALPHA_BLEND)
		finalColor = saturate(lerp(srcColor, overlayColor, overlayColor.a));
	#elif defined(_LOWPOLY_DIFFUSEBLENDMODE_COLOR_BURN)
		finalColor = saturate(1.0 - (1.0 - srcColor) / overlayColor);
	#elif defined(_LOWPOLY_DIFFUSEBLENDMODE_LINEAR_BURN)
		finalColor = saturate(overlayColor + srcColor - 1.0);
	#elif defined(_LOWPOLY_DIFFUSEBLENDMODE_SCREEN)
		finalColor = saturate(1.0 - (1.0 - overlayColor) * (1.0 - srcColor));
	#elif defined(_LOWPOLY_DIFFUSEBLENDMODE_OVERLAY)
		finalColor = saturate(lerp((1.0 - (1.0 - 2.0f * (srcColor - 0.5)) * (1.0 - overlayColor)), (2.0f * srcColor * overlayColor), step(srcColor, 0.5)));
	#elif defined(_LOWPOLY_DIFFUSEBLENDMODE_HARD_LIGHT)
		finalColor = saturate(lerp((1.0 - (1.0 - 2.0f * (overlayColor - 0.5)) * (1.0 - srcColor)), (2.0f * overlayColor * srcColor), step(overlayColor, 0.5)));
	#endif


	finalColor = _Lowpoly_DiffuseBlendAlphaPremultiply ? lerp(srcColor, finalColor, overlayColor.a) : finalColor;

	return lerp(srcColor, finalColor, _Lowpoly_DiffuseBlendStrength);

	return finalColor;
}
#endif

float4 SetupLowpolyVertexDisplace(appdata_full v)
{
	#if defined(_LOWPOLY_DISPLACEMODE_PARAMETRIC)
		
		float3 worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)).xyz;
		float3 worldNormal = UnityObjectToWorldNormal(v.normal);

	    float s, c;
	    sincos((_Lowpoly_DisplaceDirection - 45) * 0.0174533, s, c);
		float2 dir = mul(float2x2(c, -s, s, c), worldPos.xz);

		float n = frac(sin(dot(worldPos.xzz, float3(12.9898, 78.233, 63.9137))));
	    n *= _Lowpoly_DisplaceNoiseCoef;

	    float displace =  (_Lowpoly_DisplaceAmplitude * (n + 1)) * sin(dot(dir, _Lowpoly_DisplaceFrequency) + lerp(_Time.x, _Lowpoly_ScriptTime, _Lowpoly_DisplaceScriptSynchronize) * _Lowpoly_DisplaceSpeed + n);
	    
		return mul(unity_WorldToObject, float4(worldPos + worldNormal * displace, 1));

	#elif defined(_LOWPOLY_DISPLACEMODE_ONE_TEXTURE)

		float4 displaceMap = UNITY_SAMPLE_TEX2D_LOD(_Lowpoly_DisplaceMap, TRANSFORM_TEX_LOWPOLY(v.texcoord.xy, _Lowpoly_DisplaceMap), 0);
		v.vertex.xyz += v.normal * displaceMap[_Lowpoly_DisplaceMapChannel] * _Lowpoly_DisplaceMapStrength;

		return v.vertex;

	#elif defined(_LOWPOLY_DISPLACEMODE_TWO_TEXTURES)
		
		float4 displaceMap1 = UNITY_SAMPLE_TEX2D_LOD(_Lowpoly_DisplaceMap, TRANSFORM_TEX_LOWPOLY(v.texcoord.xy, _Lowpoly_DisplaceMap), 0);
		float4 displaceMap2 = UNITY_SAMPLE_TEX2D_SAMPLER_LOD(_Lowpoly_DisplaceSecondaryMap, _Lowpoly_DisplaceMap, TRANSFORM_TEX_LOWPOLY(v.texcoord.xy, _Lowpoly_DisplaceSecondaryMap), 0);

		float d1 = displaceMap1[_Lowpoly_DisplaceMapChannel] * _Lowpoly_DisplaceMapStrength;
		float d2 = displaceMap2[_Lowpoly_DisplaceSecondaryMapChannel] * _Lowpoly_DisplaceSecondaryMapStrength;

		v.vertex.xyz += v.normal * lerp(d1 + d2, d1 * d2, _Lowpoly_DisplaceMapsBlendMode);

		return v.vertex;

	#else

		return v.vertex;

	#endif
}


#if defined(_LOWPOLY_WIREFRAMEMODE_ADDITIVE) || defined(_LOWPOLY_WIREFRAMEMODE_MULTIPLY)
float ReadWireframe(float3 mass)
{
	float3 fw = abs(ddx(mass)) + abs(ddy(mass));
	float3 s = fw * (1 + _Lowpoly_WireframeSmoothness * 10) + 1e-6;
	float3 l = mass - _Lowpoly_WireframeThickness.xxx;


	float3 a1 = smoothstep(0, s, l);	
	float w1 = min(min(a1.x, a1.y), a1.z);	
	
	float3 a2 = l / s;
	float w2 = smoothstep(0.0, 1.0, min(a2.x, min(a2.y, a2.z)) + 0.5);


    return 1 - saturate(lerp(w2, w1, _Lowpoly_WireframeDiameter));
}
#endif

#endif
