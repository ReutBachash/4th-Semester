Shader "Unlit/HealthBarShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _Health ("Health Value",  Range(0,1) ) = 0
        _BorderSize ("BorderSize",range(0,0.5)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Health;
            float _BorderSize;

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };



            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }


            float IverseLerp(float a,float b,float v)
            {
                return (v-a)/(b-a);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 coords = i.uv;
                coords.x *=8;
                float2 pointOnSgtLine = float2(clamp(coords.x,0.5,7.5),0.5);
                float sdf=distance(coords,pointOnSgtLine)*2-1;
                //return sdf;   
                clip(-sdf);
                
                float borderSdf = sdf+_BorderSize;
                float pd = fwidth(borderSdf);
                
                float borderMask = 1-saturate(borderSdf/pd);

                float healthbarMask = _Health>i.uv.x;
                clip(healthbarMask-0.5);

                float3 healthBarTexture = tex2D(_MainTex,float2(_Health,i.uv.y));

                if(_Health<0.3)
                {
                    float flash = cos(_Time.y*4)*0.3+1;
                healthBarTexture*=flash;
                }
                
                //return float4(healthBarTexture,1);
                //float tHealthValue = IverseLerp(_MinValue,_MaxValue,_Health);

                //float4 healthbarColor = lerp(_ColorA,_ColorB,tHealthValue);
                //float4 bgColor = float4(0,0,0,0);
                

                //float4 outColor = lerp(bgColor,healthbarColor,healthbarMask);
                return  float4 (healthBarTexture*healthbarMask*borderMask,0); 
;
            }
            ENDCG
        }
    }
}
