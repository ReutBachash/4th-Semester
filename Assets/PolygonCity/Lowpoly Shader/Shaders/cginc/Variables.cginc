#ifndef AMAZING_ASSETS_LOWPOLY_SHADER_VARIABLES_CGINC
#define AMAZING_ASSETS_LOWPOLY_SHADER_VARIABLES_CGINC


uniform float _Lowpoly_ScriptTime;

fixed4 _Color;
UNITY_DECLARE_TEX2D(_MainTex); float4 _MainTex_ST; float2 _MainTex_Scroll;
float _Cutoff;
half _Glossiness;
half _Metallic;
int _Lowpoly_SmoothnessSource;
int _Lowpoly_TransparentFade;
int _Lowpoly_UseVertexColor;



#if defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_ADDITIVE) || defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_MULTIPLY) || defined(_LOWPOLY_SECONDARYTEXTUREBLENDMODE_ALPHA_BLEND)
	UNITY_DECLARE_TEX2D_NOSAMPLER(_Lowpoly_SecondaryTex); float4 _Lowpoly_SecondaryTex_ST; float2 _Lowpoly_SecondaryTex_Scroll;

	fixed4 _Lowpoly_SecondaryColor;

	int _Lowpoly_SecondaryTextureBlendMode;
	int _Lowpoly_SecondaryTex_InvertAlpha;
#endif


#if defined(_LOWPOLY_DISPLACEMODE_PARAMETRIC)

	float _Lowpoly_DisplaceDirection;
	float _Lowpoly_DisplaceSpeed;
	float _Lowpoly_DisplaceAmplitude;
	float _Lowpoly_DisplaceFrequency;
	float _Lowpoly_DisplaceNoiseCoef;

	float _Lowpoly_DisplaceScriptSynchronize;

#elif defined(_LOWPOLY_DISPLACEMODE_ONE_TEXTURE)
	
	UNITY_DECLARE_TEX2D(_Lowpoly_DisplaceMap); float4 _Lowpoly_DisplaceMap_ST; float2 _Lowpoly_DisplaceMap_Scroll;
	int _Lowpoly_DisplaceMapChannel;
	float _Lowpoly_DisplaceMapStrength;

#elif defined(_LOWPOLY_DISPLACEMODE_TWO_TEXTURES)

	UNITY_DECLARE_TEX2D(_Lowpoly_DisplaceMap); float4 _Lowpoly_DisplaceMap_ST; float2 _Lowpoly_DisplaceMap_Scroll;
	int _Lowpoly_DisplaceMapChannel;
	float _Lowpoly_DisplaceMapStrength;

	UNITY_DECLARE_TEX2D_NOSAMPLER(_Lowpoly_DisplaceSecondaryMap); float4 _Lowpoly_DisplaceSecondaryMap_ST; float2 _Lowpoly_DisplaceSecondaryMap_Scroll;
	int _Lowpoly_DisplaceSecondaryMapChannel;
	float _Lowpoly_DisplaceSecondaryMapStrength;

	int _Lowpoly_DisplaceMapsBlendMode;

#endif


#if defined(_LOWPOLY_WIREFRAMEMODE_ADDITIVE) || defined(_LOWPOLY_WIREFRAMEMODE_MULTIPLY)
	float _Lowpoly_WireframeThickness;
	float _Lowpoly_WireframeSmoothness;
	float _Lowpoly_WireframeDiameter;
	fixed4 _Lowpoly_WireframeColor;
	float _Lowpoly_WireframeColorEmission;
#endif


       	 
#if defined(LOWPOLOY_USING_DIFFUSE_MAPS)

	fixed4 _Lowpoly_DiffuseColor;

	UNITY_DECLARE_TEX2D(_Lowpoly_DiffuseMap); float4 _Lowpoly_DiffuseMap_ST; float2 _Lowpoly_DiffuseMap_Scroll;

	int _Lowpoly_DiffuseBlendMode;
	float _Lowpoly_DiffuseBlendAlphaPremultiply;
	float _Lowpoly_DiffuseBlendStrength;

	#if defined(_NORMALMAP)
		UNITY_DECLARE_TEX2D(_Lowpoly_BumpMap); float4 _Lowpoly_BumpMap_ST; float2 _Lowpoly_BumpMap_Scroll;
		float _Lowpoly_BumpMapStrength;
	#endif
#endif



#endif
 