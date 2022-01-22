#ifndef AMAZING_ASSETS_LOWPOLY_SHADER_LIT_CGINC
#define AMAZING_ASSETS_LOWPOLY_SHADER_LIT_CGINC



#if !defined(UNITY_PASS_SHADOWCASTER)

    #if defined(_LOWPOLY_DISPLACEMODE_PARAMETRIC) || defined(_LOWPOLY_DISPLACEMODE_ONE_TEXTURE) || defined(_LOWPOLY_DISPLACEMODE_TWO_TEXTURES)
    
        #define LOWPOLY_GEOMETRY_READ_WORLD_POSITION_TANGENT_SPACE

        #if defined(LOWPOLY_FLAT_ALL_LIGHTS_NORMALS_AND_POSITION)
            
            #define LOWPOLY_GEOMETRY_SAVE_WORLD_POSITION_TANGENT_SPACE
            #define LOWPOLY_GEOMETRY_RECONSTRUCT_DISPLACE_NORMALS                
            #define LOWPOLY_GEOMETRY_SAVE_NORMAL_TANGENT_SPACE      
                
            #ifndef LIGHTMAP_ON
                #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
                    #define LOWPOLY_GEOMETRY_SPHERICAL_HARMONICS
                #endif
            #endif

        #elif defined(_LOWPOLY_FLAT_NORMALS)
            #define LOWPOLY_GEOMETRY_RECONSTRUCT_DISPLACE_NORMALS
            #define LOWPOLY_GEOMETRY_SAVE_NORMAL_TANGENT_SPACE  
        #endif

    #else

        #if defined(LOWPOLY_FLAT_ALL_LIGHTS_NORMALS_AND_POSITION)

            #define LOWPOLY_GEOMETRY_READ_WORLD_POSITION_TANGENT_SPACE
            #define LOWPOLY_GEOMETRY_READ_WORLD_NORMAL_TANGENT_SPACE

            #define LOWPOLY_GEOMETRY_SAVE_WORLD_POSITION_TANGENT_SPACE
            #define LOWPOLY_GEOMETRY_SAVE_NORMAL_TANGENT_SPACE        

            #ifndef LIGHTMAP_ON
                #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
                    #define LOWPOLY_GEOMETRY_SPHERICAL_HARMONICS
                #endif
            #endif

        #elif defined(_LOWPOLY_FLAT_NORMALS) 
            #define LOWPOLY_GEOMETRY_READ_WORLD_NORMAL_TANGENT_SPACE
            #define LOWPOLY_GEOMETRY_SAVE_NORMAL_TANGENT_SPACE   
        #endif
    #endif
#endif

#if defined(_LOWPOLY_WIREFRAMEMODE_ADDITIVE) || defined(_LOWPOLY_WIREFRAMEMODE_MULTIPLY)
    #if !defined(UNITY_PASS_SHADOWCASTER)
        #define LOWPOLY_GEOMETRY_READ_WORLD_POSITION_TANGENT_SPACE
        #define LOWPOLY_GEOMETRY_CALCULATE_WIREFRAME
    #endif
#endif


#if defined(_LOWPOLY_DIFFUSEBLENDMODE_ADDITIVE) || defined(_LOWPOLY_DIFFUSEBLENDMODE_MULTIPLY) || defined(_LOWPOLY_DIFFUSEBLENDMODE_ALPHA_BLEND) || defined(_LOWPOLY_DIFFUSEBLENDMODE_COLOR_BURN) || defined(_LOWPOLY_DIFFUSEBLENDMODE_LINEAR_BURN) || defined(_LOWPOLY_DIFFUSEBLENDMODE_SCREEN) || defined(_LOWPOLY_DIFFUSEBLENDMODE_OVERLAY) || defined(_LOWPOLY_DIFFUSEBLENDMODE_HARD_LIGHT)
#define LOWPOLOY_USING_DIFFUSE_MAPS
#endif

#include "../cginc/Core.cginc"



void surf (v2f_surf IN, inout SurfaceOutputStandard o)
{
    #if defined(UNITY_PASS_SHADOWCASTER)

        #if defined(_LOWPOLY_ALPHATEST_LOWPOLY_COLOR_ALPHA)

            #if defined(_LOWPOLY_SAMPLETYPE_MIDDLE_UV)
                float4 mainColor = SetupLowpolyColorButForPixelShader(IN.texcoord.zw, IN.color);
            #else
                float4 mainColor = IN.color;
            #endif


            clip(mainColor.a - _Cutoff * 1.01);

        #elif defined(_LOWPOLY_ALPHATEST_DIFFUSE_TEXTURE_ALPHA)
            #if defined(LOWPOLOY_USING_DIFFUSE_MAPS)

                 float4 diffuse = UNITY_SAMPLE_TEX2D(_Lowpoly_DiffuseMap, TRANSFORM_TEX_LOWPOLY(IN.texcoord.xy, _Lowpoly_DiffuseMap));
                 diffuse *= _Lowpoly_DiffuseColor;

                 clip(diffuse.a - _Cutoff * 1.01);

            #endif
        #endif

    #else

        #if defined(_LOWPOLY_SAMPLETYPE_MIDDLE_UV)
            float4 mainColor = SetupLowpolyColorButForPixelShader(IN.texcoord.zw, IN.color);
        #else
            float4 mainColor = IN.color;
        #endif


        #if defined(_LOWPOLY_ALPHATEST_LOWPOLY_COLOR_ALPHA)
            clip(mainColor.a - _Cutoff * 1.01);
        #endif


        float3 wireframeEmission = 0;
        #if defined(_LOWPOLY_WIREFRAMEMODE_ADDITIVE) || defined(_LOWPOLY_WIREFRAMEMODE_MULTIPLY)
            float wireframe = 1 - ReadWireframe(IN.wireframe);

            #if defined(_LOWPOLY_WIREFRAMEMODE_ADDITIVE)
                float4 wireframeColor = saturate(_Lowpoly_WireframeColor + mainColor);
            #else
                float4 wireframeColor = saturate(_Lowpoly_WireframeColor * mainColor);
            #endif

            wireframeEmission = _Lowpoly_WireframeColor.rgb * (1 - wireframe) * _Lowpoly_WireframeColorEmission;

            mainColor.rgb = lerp(lerp(mainColor, wireframeColor, _Lowpoly_WireframeColor.a), mainColor, wireframe).rgb;        
        #endif


        float3 alpha = float3(1, mainColor.a, 0);

        #if defined(LOWPOLOY_USING_DIFFUSE_MAPS)

            float4 diffuse = UNITY_SAMPLE_TEX2D(_Lowpoly_DiffuseMap, TRANSFORM_TEX_LOWPOLY(IN.texcoord.xy, _Lowpoly_DiffuseMap));
            diffuse *= _Lowpoly_DiffuseColor;

            alpha[2] = diffuse.a;

            #if defined(_LOWPOLY_ALPHATEST_DIFFUSE_TEXTURE_ALPHA)
                clip(diffuse.a - _Cutoff * 1.01);
            #endif


            mainColor = BlendDiffuseAndLowpolyColors(mainColor, diffuse);


            #if defined(_NORMALMAP)               
                
                #if defined(_LOWPOLY_DIFFUSEBLENDMODE_ALPHA_BLEND)
                    o.Normal = UnpackNormalWithScale(UNITY_SAMPLE_TEX2D(_Lowpoly_BumpMap, TRANSFORM_TEX_LOWPOLY(IN.texcoord.xy, _Lowpoly_BumpMap)), lerp(0, _Lowpoly_BumpMapStrength, diffuse.a));
                #else

                    float normalStrength = _Lowpoly_DiffuseBlendAlphaPremultiply ? _Lowpoly_BumpMapStrength * diffuse.a : _Lowpoly_BumpMapStrength;
                    o.Normal = UnpackNormalWithScale(UNITY_SAMPLE_TEX2D(_Lowpoly_BumpMap, TRANSFORM_TEX_LOWPOLY(IN.texcoord.xy, _Lowpoly_BumpMap)), normalStrength);

                #endif

            #endif

        #endif

     
        o.Albedo = mainColor.rgb;
        o.Metallic = _Metallic;
        o.Smoothness = _Glossiness * alpha[_Lowpoly_SmoothnessSource];

        #if defined(LOWPOLY_SHADER_TYPE_TRANSAPRENT)
            o.Alpha = alpha[_Lowpoly_TransparentFade + 1];
        #else
            o.Alpha = 1;
        #endif

        o.Emission = wireframeEmission;

    #endif
}

#endif
