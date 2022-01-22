Shader "Amazing Assets/Lowpoly Shader/Lit"
{
    Properties
    { 
//[HideInInspector][CurvedWorldBendSettings] _CurvedWorldBendSettings("0|1|1", Vector) = (0, 0, 0, 0)


        [HideInInspector][MaterialEnum(Front,2,Back,1,Both,0)] _Lowpoly_Cull("Face Cull", Int) = 0
        [HideInInspector][KeywordEnum(None, Lowpoly Color Alpha, Diffuse Texture Alpha)] _Lowpoly_AlphaTest ("Aplha Test", Float) = 0
        [HideInInspector][Enum(Lowpoly Alpha, 0, Diffuse Alpha, 1)] _Lowpoly_TransparentFade ("Transparent Fade", Float) = 0

        [HideInInspector] _Color ("Color", Color) = (1,1,1,1)
        [HideInInspector][LowpolyShaderToggleFloat] _Lowpoly_UseVertexColor("Use Vertex Color", int) = 0

        [HideInInspector] _MainTex ("MainTex", 2D) = "white" {}
        [HideInInspector][LowpolyShaderUVScroll] _MainTex_Scroll ("Scroll", Vector) = (0, 0, 0, 0)
        [HideInInspector][KeywordEnum(None, Additive, Multiply, Alpha Blend)] _Lowpoly_SecondaryTextureBlendMode ("Blend Mode", Float) = 0
        [HideInInspector] _Lowpoly_SecondaryTex ("SecondaryTex", 2D) = "white" {}
        [HideInInspector] _Lowpoly_SecondaryColor ("Secondary Color", Color) = (1, 1, 1, 1)
        [HideInInspector][LowpolyShaderUVScroll] _Lowpoly_SecondaryTex_Scroll ("Scroll", Vector) = (0, 0, 0, 0)
        [HideInInspector][LowpolyShaderToggleFloat] _Lowpoly_SecondaryTex_InvertAlpha("SecondaryTex Invert Alpha", int) = 0
        [HideInInspector] _Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5
         
        [HideInInspector] [KeywordEnum(None, Parametric, One Texture, Two Textures)] _Lowpoly_DisplaceMode ("Displace Mode", Float) = 0
        [HideInInspector][LowpolyShaderToggleFloat] _Lowpoly_DisplaceScriptSynchronize("Displace Script Synchronize", Float) = 0
        [HideInInspector] _Lowpoly_DisplaceDirection("Displace Direction", Range(0, 360)) = 45
		[HideInInspector] _Lowpoly_DisplaceSpeed("Displace Speed", Float) = 20
		[HideInInspector] _Lowpoly_DisplaceAmplitude("Displace Amplitude", Float) = 0.5
		[HideInInspector] _Lowpoly_DisplaceFrequency("Displace Frequency", Float) = 0.2
		[HideInInspector] _Lowpoly_DisplaceNoiseCoef("Displace Noise Coef", Float) = -0.5    

         
        [HideInInspector] _Lowpoly_DisplaceMap ("Displace Map", 2D) = "black" {}
        [HideInInspector][LowpolyShaderUVScroll] _Lowpoly_DisplaceMap_Scroll ("Scroll", Vector) = (0, 0, 0, 0)
        [HideInInspector][Enum(Red, 0, Green, 1, Blue, 2, Alpha, 3)] _Lowpoly_DisplaceMapChannel ("Displace Channel", int) = 0
        [HideInInspector] _Lowpoly_DisplaceMapStrength("Displace Strength", float) = 1
        [HideInInspector] _Lowpoly_DisplaceSecondaryMap ("Displace Secondary Map", 2D) = "black" {}
        [HideInInspector][LowpolyShaderUVScroll] _Lowpoly_DisplaceSecondaryMap_Scroll ("Scroll", Vector) = (0, 0, 0, 0)
        [HideInInspector][Enum(Red, 0, Green, 1, Blue, 2, Alpha, 3)] _Lowpoly_DisplaceSecondaryMapChannel ("Displace Channel", int) = 0
        [HideInInspector] _Lowpoly_DisplaceSecondaryMapStrength("Displace Strength", float) = 1
        [HideInInspector][Enum(Additive, 0, Multiply, 1)] _Lowpoly_DisplaceMapsBlendMode ("Blend Mode", Float) = 1

        [HideInInspector][KeywordEnum(Average Color, Middle UV, First Index)] _Lowpoly_SampleType("Sample Type", Float) = 0
        [HideInInspector][Toggle(_LOWPOLY_FLAT_NORMALS)] _Lowpoly_FlatNormals("Flat Normals", Float) = 0
        [HideInInspector][Toggle(_LOWPOLY_FLAT_LIGHTMAPS)] _Lowpoly_FlatLightMaps("Flat Lightmaps", Float) = 0


        [HideInInspector] _Lowpoly_DiffuseColor ("Color", Color) = (1,1,1,1)
        [HideInInspector] _Glossiness ("Smoothness", Range(0,1)) = 0.5
        [HideInInspector] _Metallic ("Metallic", Range(0,1)) = 0.0
        [HideInInspector][Enum(None, 0, Lowpoly Color Alpha, 1, Diffuse Texture Alpha, 2)] _Lowpoly_SmoothnessSource ("Smoothness Source", int) = 0

        [HideInInspector][KeywordEnum(None, Additive, Multiply, Alpha Blend, Color Burn, Linear Burn, Screen, Overlay, Hard Light)] _Lowpoly_DiffuseBlendMode ("Diffuse Blend Mode", Float) = 0
        [HideInInspector] _Lowpoly_DiffuseBlendStrength ("Blend Strength", Range(0, 1)) = 1
        [HideInInspector][LowpolyShaderToggleFloat] _Lowpoly_DiffuseBlendAlphaPremultiply ("Alpha Premultiply", float) = 0

        [HideInInspector] _Lowpoly_DiffuseMap("Diffuse Map", 2D) = "black"{}
        [HideInInspector][LowpolyShaderUVScroll] _Lowpoly_DiffuseMap_Scroll ("Scroll", Vector) = (0, 0, 0, 0)

        [HideInInspector] _Lowpoly_BumpMap("Bump Map", 2D) = "bump"{}
        [HideInInspector][LowpolyShaderUVScroll] _Lowpoly_BumpMap_Scroll ("Scroll", Vector) = (0, 0, 0, 0)
        [HideInInspector] _Lowpoly_BumpMapStrength("Strength", float) = 1

        
        //Wireframe
        [HideInInspector] _Lowpoly_WireframeThickness("Thickness", Range(0, 1)) = 0.01
		[HideInInspector] _Lowpoly_WireframeSmoothness("Smoothness", Range(0, 1)) = 0	
        [HideInInspector] _Lowpoly_WireframeDiameter("Diameter", Range(0, 1)) = 1
        [HideInInspector][Toggle(_LOWPOLY_WIREFRAME_NORMALIZE_EDGES)] _Lowpoly_WireframeNormalizeEdges ("Normalize Edges", Float) = 0
        [HideInInspector]_Lowpoly_WireframeColor("Color", Color) = (1, 0, 0, 1)
        [HideInInspector]_Lowpoly_WireframeColorEmission("Emission", float) = 0
        [HideInInspector][KeywordEnum(None, Additive, Multiply)] _Lowpoly_WireframeMode("Mode", int) = 0  
        [HideInInspector][Toggle(_LOWPOLY_WIREFRAME_TRY_QUADS)] _Lowpoly_WireframeTryQuads("Try Quads", Float) = 0
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Cull[_Lowpoly_Cull]  



        	

	// ---- forward rendering base pass:
	Pass 
    {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma geometry geom
#pragma fragment frag_surf
#pragma multi_compile_instancing
#pragma multi_compile_fog
#pragma multi_compile_fwdbase
#include "HLSLSupport.cginc"
#define UNITY_INSTANCED_LOD_FADE
#define UNITY_INSTANCED_SH
#define UNITY_INSTANCED_LIGHTMAPSTS
#include "UnityShaderVariables.cginc"
#include "UnityShaderUtilities.cginc"

#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))



// vertex-to-fragment interpolation data
// no lightmaps:
#ifndef LIGHTMAP_ON
// half-precision fragment shader registers:
#ifdef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
#define FOG_COMBINED_WITH_TSPACE
struct v2f_surf {
  UNITY_POSITION(pos);
  float4 texcoord : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed4 color : COLOR0;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD4; // SH
  #endif
  UNITY_LIGHTING_COORDS(5,6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO

  //Lowpoly
  float3 wireframe : TEXCOORD8;
};
#endif
// high-precision fragment shader registers:
#ifndef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
struct v2f_surf {
  UNITY_POSITION(pos);
  float4 texcoord : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed4 color : COLOR0;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD4; // SH
  #endif
  UNITY_FOG_COORDS(5)
  UNITY_SHADOW_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO

  //Lowpoly
  float3 wireframe : TEXCOORD8;
};
#endif
#endif
// with lightmaps:
#ifdef LIGHTMAP_ON
// half-precision fragment shader registers:
#ifdef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
#define FOG_COMBINED_WITH_TSPACE
struct v2f_surf {
  UNITY_POSITION(pos);
  float4 texcoord : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed4 color : COLOR0;
  float4 lmap : TEXCOORD4;
  UNITY_LIGHTING_COORDS(5,6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO

  //Lowpoly
  float3 wireframe : TEXCOORD8;
};
#endif
// high-precision fragment shader registers:
#ifndef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
struct v2f_surf {
  UNITY_POSITION(pos);
  float4 texcoord : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed4 color : COLOR0;
  float4 lmap : TEXCOORD4;
  UNITY_FOG_COORDS(5)
  UNITY_SHADOW_COORDS(6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO

  //Lowpoly
  float3 wireframe : TEXCOORD8;

};
#endif
#endif



//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"

#pragma shader_feature_local _ _LOWPOLY_ALPHATEST_LOWPOLY_COLOR_ALPHA _LOWPOLY_ALPHATEST_DIFFUSE_TEXTURE_ALPHA

#pragma shader_feature_local _LOWPOLY_SAMPLETYPE_AVERAGE_COLOR _LOWPOLY_SAMPLETYPE_MIDDLE_UV _LOWPOLY_SAMPLETYPE_FIRST_INDEX
#pragma shader_feature_local _LOWPOLY_FLAT_NORMALS
#pragma shader_feature_local _LOWPOLY_FLAT_LIGHTMAPS
#pragma shader_feature_local _ _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ADDITIVE _LOWPOLY_SECONDARYTEXTUREBLENDMODE_MULTIPLY _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ALPHA_BLEND
#pragma shader_feature_local _ _LOWPOLY_DISPLACEMODE_PARAMETRIC _LOWPOLY_DISPLACEMODE_ONE_TEXTURE _LOWPOLY_DISPLACEMODE_TWO_TEXTURES
#pragma shader_feature_local _ _LOWPOLY_WIREFRAMEMODE_ADDITIVE _LOWPOLY_WIREFRAMEMODE_MULTIPLY
#pragma shader_feature_local _LOWPOLY_WIREFRAME_TRY_QUADS
#pragma shader_feature_local _LOWPOLY_WIREFRAME_NORMALIZE_EDGES
#pragma shader_feature_local _ _LOWPOLY_DIFFUSEBLENDMODE_ADDITIVE _LOWPOLY_DIFFUSEBLENDMODE_MULTIPLY _LOWPOLY_DIFFUSEBLENDMODE_ALPHA_BLEND _LOWPOLY_DIFFUSEBLENDMODE_COLOR_BURN _LOWPOLY_DIFFUSEBLENDMODE_LINEAR_BURN _LOWPOLY_DIFFUSEBLENDMODE_SCREEN _LOWPOLY_DIFFUSEBLENDMODE_OVERLAY _LOWPOLY_DIFFUSEBLENDMODE_HARD_LIGHT
#pragma shader_feature_local _NORMALMAP

#include "Lit.cginc"


// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


  //Lowpoly
  v.vertex = SetupLowpolyVertexDisplace(v);

  //Curved World
  #if defined(CURVEDWORLD_IS_INSTALLED) && !defined(CURVEDWORLD_DISABLED_ON)
      #ifdef CURVEDWORLD_NORMAL_TRANSFORMATION_ON
          CURVEDWORLD_TRANSFORM_VERTEX_AND_NORMAL(v.vertex, v.normal, v.tangent)
      #else
          CURVEDWORLD_TRANSFORM_VERTEX(v.vertex)
      #endif
  #endif


  o.pos = UnityObjectToClipPos(v.vertex);
  o.texcoord = v.texcoord;
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  float3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  o.color = v.color;
  #ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifndef LIGHTMAP_ON
    #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // !LIGHTMAP_ON

  UNITY_TRANSFER_LIGHTING(o,v.texcoord1.xy); // pass shadow and, possibly, light cookie coordinates to pixel shader
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_TRANSFER_FOG_COMBINED_WITH_TSPACE(o,o.pos); // pass fog coordinates to pixel shader
  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
    UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS(o,o.pos); // pass fog coordinates to pixel shader
  #else
    UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  #endif


  //Lowpoly
  o.color = SetupLowpolyColor(v.texcoord.xy, v.color);


  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);

  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
    UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
  #else
    UNITY_EXTRACT_FOG(IN);
  #endif
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_RECONSTRUCT_TBN(IN);
  #else
    UNITY_EXTRACT_TBN(IN);
  #endif


  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = fixed3(0,0,1);

  // call surface function
  surf (IN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  float3 worldN;
  worldN.x = dot(_unity_tbn_0, o.Normal);
  worldN.y = dot(_unity_tbn_1, o.Normal);
  worldN.z = dot(_unity_tbn_2, o.Normal);
  worldN = normalize(worldN);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  gi.light.color = _LightColor0.rgb;
  gi.light.dir = lightDir;
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #ifdef UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  c.rgb += o.Emission;
  UNITY_APPLY_FOG(_unity_fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


ENDCG

}

	// ---- forward rendering additive lights pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
        ZWrite Off Blend One One

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma geometry geom 
#pragma fragment frag_surf
#pragma multi_compile_instancing
#pragma multi_compile_fog
#pragma skip_variants INSTANCING_ON
#pragma multi_compile_fwdadd_fullshadows
#include "HLSLSupport.cginc"
#define UNITY_INSTANCED_LOD_FADE
#define UNITY_INSTANCED_SH
#define UNITY_INSTANCED_LIGHTMAPSTS
#include "UnityShaderVariables.cginc"
#include "UnityShaderUtilities.cginc"

#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
     

// vertex-to-fragment interpolation data
struct v2f_surf {
  UNITY_POSITION(pos);
  float4 texcoord : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed4 color : COLOR0;
  UNITY_LIGHTING_COORDS(5,6)
  UNITY_FOG_COORDS(7)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO

  //Lowpoly
  float3 wireframe : TEXCOORD8;
};



//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"

#pragma shader_feature_local _ _LOWPOLY_ALPHATEST_LOWPOLY_COLOR_ALPHA _LOWPOLY_ALPHATEST_DIFFUSE_TEXTURE_ALPHA

#pragma shader_feature_local _LOWPOLY_SAMPLETYPE_AVERAGE_COLOR _LOWPOLY_SAMPLETYPE_MIDDLE_UV _LOWPOLY_SAMPLETYPE_FIRST_INDEX
#pragma shader_feature_local _LOWPOLY_FLAT_NORMALS
#pragma shader_feature_local _LOWPOLY_FLAT_LIGHTMAPS
#pragma shader_feature_local _ _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ADDITIVE _LOWPOLY_SECONDARYTEXTUREBLENDMODE_MULTIPLY _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ALPHA_BLEND
#pragma shader_feature_local _ _LOWPOLY_DISPLACEMODE_PARAMETRIC _LOWPOLY_DISPLACEMODE_ONE_TEXTURE _LOWPOLY_DISPLACEMODE_TWO_TEXTURES
#pragma shader_feature_local _ _LOWPOLY_WIREFRAMEMODE_ADDITIVE _LOWPOLY_WIREFRAMEMODE_MULTIPLY
#pragma shader_feature_local _LOWPOLY_WIREFRAME_TRY_QUADS
#pragma shader_feature_local _LOWPOLY_WIREFRAME_NORMALIZE_EDGES
#pragma shader_feature_local _ _LOWPOLY_DIFFUSEBLENDMODE_ADDITIVE _LOWPOLY_DIFFUSEBLENDMODE_MULTIPLY _LOWPOLY_DIFFUSEBLENDMODE_ALPHA_BLEND _LOWPOLY_DIFFUSEBLENDMODE_COLOR_BURN _LOWPOLY_DIFFUSEBLENDMODE_LINEAR_BURN _LOWPOLY_DIFFUSEBLENDMODE_SCREEN _LOWPOLY_DIFFUSEBLENDMODE_OVERLAY _LOWPOLY_DIFFUSEBLENDMODE_HARD_LIGHT
#pragma shader_feature_local _NORMALMAP

#include "Lit.cginc"


// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


  //Lowpoly
  v.vertex = SetupLowpolyVertexDisplace(v);

  //Curved World
  #if defined(CURVEDWORLD_IS_INSTALLED) && !defined(CURVEDWORLD_DISABLED_ON)
      #ifdef CURVEDWORLD_NORMAL_TRANSFORMATION_ON
          CURVEDWORLD_TRANSFORM_VERTEX_AND_NORMAL(v.vertex, v.normal, v.tangent)
      #else
          CURVEDWORLD_TRANSFORM_VERTEX(v.vertex)
      #endif
  #endif



  o.pos = UnityObjectToClipPos(v.vertex);
  o.texcoord.xy = v.texcoord;
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  float3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  o.color = v.color;

  UNITY_TRANSFER_LIGHTING(o,v.texcoord1.xy); // pass shadow and, possibly, light cookie coordinates to pixel shader
  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader


  //Lowpoly
  o.color = SetupLowpolyColor(v.texcoord.xy, v.color);


  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
    UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
  #else
    UNITY_EXTRACT_FOG(IN);
  #endif
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_RECONSTRUCT_TBN(IN);
  #else
    UNITY_EXTRACT_TBN(IN);
  #endif
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = fixed3(0,0,1);

  // call surface function
  surf (IN, o);

  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  float3 worldN;
  worldN.x = dot(_unity_tbn_0, o.Normal);
  worldN.y = dot(_unity_tbn_1, o.Normal);
  worldN.z = dot(_unity_tbn_2, o.Normal);
  worldN = normalize(worldN);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  gi.light.color = _LightColor0.rgb;
  gi.light.dir = lightDir;
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  UNITY_APPLY_FOG(_unity_fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}



ENDCG

}

	// ---- deferred shading pass:
	Pass {
		Name "DEFERRED"
		Tags { "LightMode" = "Deferred" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma geometry geom
#pragma fragment frag_surf
#pragma multi_compile_instancing
#pragma exclude_renderers nomrt
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#pragma multi_compile_prepassfinal
#include "HLSLSupport.cginc"
#define UNITY_INSTANCED_LOD_FADE
#define UNITY_INSTANCED_SH
#define UNITY_INSTANCED_LIGHTMAPSTS
#include "UnityShaderVariables.cginc"
#include "UnityShaderUtilities.cginc"

#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
        

// vertex-to-fragment interpolation data
struct v2f_surf {
  UNITY_POSITION(pos);
  float4 texcoord : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed4 color : COLOR0;
#ifndef DIRLIGHTMAP_OFF
  float3 viewDir : TEXCOORD4;
#endif
  float4 lmap : TEXCOORD5;
#ifndef LIGHTMAP_ON
  #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
    half3 sh : TEXCOORD6; // SH
  #endif
#else
  #ifdef DIRLIGHTMAP_OFF
    float4 lmapFadePos : TEXCOORD6;
  #endif
#endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO

  //Lowpoly
  float3 wireframe : TEXCOORD8;
};



//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"

#pragma shader_feature_local _ _LOWPOLY_ALPHATEST_LOWPOLY_COLOR_ALPHA _LOWPOLY_ALPHATEST_DIFFUSE_TEXTURE_ALPHA

#pragma shader_feature_local _LOWPOLY_SAMPLETYPE_AVERAGE_COLOR _LOWPOLY_SAMPLETYPE_MIDDLE_UV _LOWPOLY_SAMPLETYPE_FIRST_INDEX
#pragma shader_feature_local _LOWPOLY_FLAT_NORMALS
#pragma shader_feature_local _LOWPOLY_FLAT_LIGHTMAPS
#pragma shader_feature_local _ _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ADDITIVE _LOWPOLY_SECONDARYTEXTUREBLENDMODE_MULTIPLY _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ALPHA_BLEND
#pragma shader_feature_local _ _LOWPOLY_DISPLACEMODE_PARAMETRIC _LOWPOLY_DISPLACEMODE_ONE_TEXTURE _LOWPOLY_DISPLACEMODE_TWO_TEXTURES
#pragma shader_feature_local _ _LOWPOLY_WIREFRAMEMODE_ADDITIVE _LOWPOLY_WIREFRAMEMODE_MULTIPLY
#pragma shader_feature_local _LOWPOLY_WIREFRAME_TRY_QUADS
#pragma shader_feature_local _LOWPOLY_WIREFRAME_NORMALIZE_EDGES
#pragma shader_feature_local _ _LOWPOLY_DIFFUSEBLENDMODE_ADDITIVE _LOWPOLY_DIFFUSEBLENDMODE_MULTIPLY _LOWPOLY_DIFFUSEBLENDMODE_ALPHA_BLEND _LOWPOLY_DIFFUSEBLENDMODE_COLOR_BURN _LOWPOLY_DIFFUSEBLENDMODE_LINEAR_BURN _LOWPOLY_DIFFUSEBLENDMODE_SCREEN _LOWPOLY_DIFFUSEBLENDMODE_OVERLAY _LOWPOLY_DIFFUSEBLENDMODE_HARD_LIGHT
#pragma shader_feature_local _NORMALMAP

#include "Lit.cginc"


// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


  //Lowpoly
  v.vertex = SetupLowpolyVertexDisplace(v);

  //Curved World
  #if defined(CURVEDWORLD_IS_INSTALLED) && !defined(CURVEDWORLD_DISABLED_ON)
      #ifdef CURVEDWORLD_NORMAL_TRANSFORMATION_ON
          CURVEDWORLD_TRANSFORM_VERTEX_AND_NORMAL(v.vertex, v.normal, v.tangent)
      #else
          CURVEDWORLD_TRANSFORM_VERTEX(v.vertex)
      #endif
  #endif


  o.pos = UnityObjectToClipPos(v.vertex);
  o.texcoord.xy = v.texcoord;
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  float3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  float3 viewDirForLight = UnityWorldSpaceViewDir(worldPos);
  #ifndef DIRLIGHTMAP_OFF
  o.viewDir.x = dot(viewDirForLight, worldTangent);
  o.viewDir.y = dot(viewDirForLight, worldBinormal);
  o.viewDir.z = dot(viewDirForLight, worldNormal);
  #endif
  o.color = v.color;
#ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
#else
  o.lmap.zw = 0;
#endif
#ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #ifdef DIRLIGHTMAP_OFF
    o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
    o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
  #endif
#else
  o.lmap.xy = 0;
    #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
      o.sh = 0;
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
#endif


  //Lowpoly
  o.color = SetupLowpolyColor(v.texcoord.xy, v.color);


  return o;
}
#ifdef LIGHTMAP_ON
float4 unity_LightmapFade;
#endif
fixed4 unity_Ambient;

// fragment shader
void frag_surf (v2f_surf IN,
    out half4 outGBuffer0 : SV_Target0,
    out half4 outGBuffer1 : SV_Target1,
    out half4 outGBuffer2 : SV_Target2,
    out half4 outEmission : SV_Target3
#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
    , out half4 outShadowMask : SV_Target4
#endif
) {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
    UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
  #else
    UNITY_EXTRACT_FOG(IN);
  #endif
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_RECONSTRUCT_TBN(IN);
  #else
    UNITY_EXTRACT_TBN(IN);
  #endif
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = fixed3(0,0,1);

  // call surface function
  surf (IN, o);

   
fixed3 originalNormal = o.Normal;
  float3 worldN;
  worldN.x = dot(_unity_tbn_0, o.Normal);
  worldN.y = dot(_unity_tbn_1, o.Normal);
  worldN.z = dot(_unity_tbn_2, o.Normal);
  worldN = normalize(worldN);
  o.Normal = worldN;
  half atten = 1;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  gi.light.color = 0;
  gi.light.dir = half3(0,1,0);
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #ifdef UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // call lighting function to output g-buffer
  outEmission = LightingStandard_Deferred (o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2);
  #if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
    outShadowMask = UnityGetRawBakedOcclusions (IN.lmap.xy, worldPos);
  #endif
  #ifndef UNITY_HDR_ON
  outEmission.rgb = exp2(-outEmission.rgb);
  #endif
}


ENDCG

}

	// ---- shadow caster pass:
	Pass {
		Name "ShadowCaster"
		Tags { "LightMode" = "ShadowCaster" }
		ZWrite On ZTest LEqual

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma geometry geom
#pragma fragment frag_surf
#pragma multi_compile_instancing
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#pragma multi_compile_shadowcaster
#include "HLSLSupport.cginc"
#define UNITY_INSTANCED_LOD_FADE
#define UNITY_INSTANCED_SH
#define UNITY_INSTANCED_LIGHTMAPSTS
#include "UnityShaderVariables.cginc"
#include "UnityShaderUtilities.cginc"

#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

       

// vertex-to-fragment interpolation data
struct v2f_surf {
  V2F_SHADOW_CASTER;
  float4 texcoord : TEXCOORD0; // _MainTex
  float3 worldPos : TEXCOORD1;
  fixed4 color : COLOR0;
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
}; 


//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"

#pragma shader_feature_local _ _LOWPOLY_ALPHATEST_LOWPOLY_COLOR_ALPHA _LOWPOLY_ALPHATEST_DIFFUSE_TEXTURE_ALPHA

#pragma shader_feature_local _LOWPOLY_SAMPLETYPE_AVERAGE_COLOR _LOWPOLY_SAMPLETYPE_MIDDLE_UV _LOWPOLY_SAMPLETYPE_FIRST_INDEX
#pragma shader_feature_local _LOWPOLY_FLAT_NORMALS
#pragma shader_feature_local _LOWPOLY_FLAT_LIGHTMAPS
#pragma shader_feature_local _ _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ADDITIVE _LOWPOLY_SECONDARYTEXTUREBLENDMODE_MULTIPLY _LOWPOLY_SECONDARYTEXTUREBLENDMODE_ALPHA_BLEND
#pragma shader_feature_local _ _LOWPOLY_DISPLACEMODE_PARAMETRIC _LOWPOLY_DISPLACEMODE_ONE_TEXTURE _LOWPOLY_DISPLACEMODE_TWO_TEXTURES
#pragma shader_feature_local _ _LOWPOLY_WIREFRAMEMODE_ADDITIVE _LOWPOLY_WIREFRAMEMODE_MULTIPLY
#pragma shader_feature_local _LOWPOLY_WIREFRAME_TRY_QUADS
#pragma shader_feature_local _LOWPOLY_WIREFRAME_NORMALIZE_EDGES
#pragma shader_feature_local _ _LOWPOLY_DIFFUSEBLENDMODE_ADDITIVE _LOWPOLY_DIFFUSEBLENDMODE_MULTIPLY _LOWPOLY_DIFFUSEBLENDMODE_ALPHA_BLEND _LOWPOLY_DIFFUSEBLENDMODE_COLOR_BURN _LOWPOLY_DIFFUSEBLENDMODE_LINEAR_BURN _LOWPOLY_DIFFUSEBLENDMODE_SCREEN _LOWPOLY_DIFFUSEBLENDMODE_OVERLAY _LOWPOLY_DIFFUSEBLENDMODE_HARD_LIGHT
#pragma shader_feature_local _NORMALMAP

#include "Lit.cginc"


// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


  //Lowpoly
  v.vertex = SetupLowpolyVertexDisplace(v);

  //Curved World
  #if defined(CURVEDWORLD_IS_INSTALLED) && !defined(CURVEDWORLD_DISABLED_ON)
      #ifdef CURVEDWORLD_NORMAL_TRANSFORMATION_ON
          CURVEDWORLD_TRANSFORM_VERTEX_AND_NORMAL(v.vertex, v.normal, v.tangent)
      #else
          CURVEDWORLD_TRANSFORM_VERTEX(v.vertex)
      #endif
  #endif


  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  float3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.texcoord = v.texcoord;
  o.worldPos.xyz = worldPos;
  TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)


  
  //Lowpoly
  o.color = SetupLowpolyColor(v.texcoord.xy, v.color);


  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
    UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
  #else
    UNITY_EXTRACT_FOG(IN);
  #endif
  float3 worldPos = IN.worldPos.xyz;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (IN, o);

  SHADOW_CASTER_FRAGMENT(IN)
}


ENDCG

}


//	// ---- meta information extraction pass:
//	Pass {
//		Name "Meta"
//		Tags { "LightMode" = "Meta" }
//		Cull Off

//CGPROGRAM
//// compile directives
//#pragma vertex vert_surf
//#pragma fragment frag_surf
//#pragma target 3.0
//#pragma multi_compile_instancing
//#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
//#pragma shader_feature EDITOR_VISUALIZATION

//#include "HLSLSupport.cginc"
//#define UNITY_INSTANCED_LOD_FADE
//#define UNITY_INSTANCED_SH
//#define UNITY_INSTANCED_LIGHTMAPSTS
//#include "UnityShaderVariables.cginc"
//#include "UnityShaderUtilities.cginc"

//#include "UnityCG.cginc"
//#include "Lighting.cginc"
//#include "UnityPBSLighting.cginc"

//#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
//#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
//#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))



//        sampler2D _MainTex;
//        sampler2D _BumpMap;

//        struct Input
//        {
//            float2 uv_MainTex;
//            fixed4 color : COLOR;
//        };

//        half _Glossiness;
//        half _Metallic;
//        fixed4 _Color;


//        void surf (Input IN, inout SurfaceOutputStandard o)
//        {
//            // Albedo comes from a texture tinted by color
//            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color * IN.color;
//            o.Albedo = c.rgb;
//            // Metallic and smoothness come from slider variables
//            o.Metallic = _Metallic;
//            o.Smoothness = _Glossiness;
//            o.Alpha = c.a;

//            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
//        }
        
//#include "UnityMetaPass.cginc"

//// vertex-to-fragment interpolation data
//struct v2f_surf {
//  UNITY_POSITION(pos);
//  float2 pack0 : TEXCOORD0; // _MainTex
//  float4 tSpace0 : TEXCOORD1;
//  float4 tSpace1 : TEXCOORD2;
//  float4 tSpace2 : TEXCOORD3;
//  fixed4 color : COLOR0;
//#ifdef EDITOR_VISUALIZATION
//  float2 vizUV : TEXCOORD4;
//  float4 lightCoord : TEXCOORD5;
//#endif
//  UNITY_VERTEX_INPUT_INSTANCE_ID
//  UNITY_VERTEX_OUTPUT_STEREO
//};
//float4 _MainTex_ST;

//// vertex shader
//v2f_surf vert_surf (appdata_full v) {
//  UNITY_SETUP_INSTANCE_ID(v);
//  v2f_surf o;
//  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
//  UNITY_TRANSFER_INSTANCE_ID(v,o);
//  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
//  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
//#ifdef EDITOR_VISUALIZATION
//  o.vizUV = 0;
//  o.lightCoord = 0;
//  if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
//    o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.texcoord.xy, v.texcoord1.xy, v.texcoord2.xy, unity_EditorViz_Texture_ST);
//  else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
//  {
//    o.vizUV = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
//    o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
//  }
//#endif
//  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
//  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
//  float3 worldNormal = UnityObjectToWorldNormal(v.normal);
//  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
//  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
//  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
//  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
//  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
//  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
//  o.color = v.color;
//  return o;
//}

//// fragment shader
//fixed4 frag_surf (v2f_surf IN) : SV_Target {
//  UNITY_SETUP_INSTANCE_ID(IN);
//  // prepare and unpack data
//  Input surfIN;
//  #ifdef FOG_COMBINED_WITH_TSPACE
//    UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
//  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
//    UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
//  #else
//    UNITY_EXTRACT_FOG(IN);
//  #endif
//  #ifdef FOG_COMBINED_WITH_TSPACE
//    UNITY_RECONSTRUCT_TBN(IN);
//  #else
//    UNITY_EXTRACT_TBN(IN);
//  #endif
//  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
//  surfIN.uv_MainTex.x = 1.0;
//  surfIN.color.x = 1.0;
//  surfIN.uv_MainTex = IN.pack0.xy;
//  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
//  #ifndef USING_DIRECTIONAL_LIGHT
//    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
//  #else
//    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
//  #endif
//  surfIN.color = IN.color;
//  #ifdef UNITY_COMPILER_HLSL
//  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
//  #else
//  SurfaceOutputStandard o;
//  #endif
//  o.Albedo = 0.0;
//  o.Emission = 0.0;
//  o.Alpha = 0.0;
//  o.Occlusion = 1.0;
//  fixed3 normalWorldVertex = fixed3(0,0,1);

//  // call surface function
//  surf (surfIN, o);
//  UnityMetaInput metaIN;
//  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
//  metaIN.Albedo = o.Albedo;
//  metaIN.Emission = o.Emission;
//#ifdef EDITOR_VISUALIZATION
//  metaIN.VizUV = IN.vizUV;
//  metaIN.LightCoord = IN.lightCoord;
//#endif
//  return UnityMetaFragment(metaIN);
//}


//ENDCG

//}



    }
    
    CustomEditor "AmazingAssets.LowpolyShader.LitShaderGUI"
    //FallBack "Diffuse"
}
