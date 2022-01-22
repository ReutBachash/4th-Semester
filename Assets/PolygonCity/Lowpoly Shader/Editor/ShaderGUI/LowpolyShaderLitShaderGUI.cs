using UnityEngine;
using UnityEditor;


namespace AmazingAssets.LowpolyShader
{
    class LitShaderGUI : ShaderGUI
    {
        public enum RenderMode { Opaque, Transparent }
        public enum AlphaTest { None, LowpolyColor, Basemap }
        public enum DisplaceMode { None, Parametric, OneTexture, TwoTextures }


        #region MaterialProperty
        static MaterialProperty _CurvedWorldBendSettings = null;


        static MaterialProperty _Color = null;
        static MaterialProperty _Lowpoly_UseVertexColor = null;

        static MaterialProperty _MainTex = null;
        static MaterialProperty _MainTex_Scroll = null;

        static MaterialProperty _Lowpoly_SecondaryTextureBlendMode = null;
        static MaterialProperty _Lowpoly_SecondaryTex = null;
        static MaterialProperty _Lowpoly_SecondaryColor = null;
        static MaterialProperty _Lowpoly_SecondaryTex_Scroll = null;
        static MaterialProperty _Lowpoly_SecondaryTex_InvertAlpha = null;

        static MaterialProperty _Cutoff = null;

        static MaterialProperty _Lowpoly_DisplaceMode = null;
        static MaterialProperty _Lowpoly_DisplaceScriptSynchronize = null;
        static MaterialProperty _Lowpoly_DisplaceDirection = null;
        static MaterialProperty _Lowpoly_DisplaceSpeed = null;
        static MaterialProperty _Lowpoly_DisplaceAmplitude = null;
        static MaterialProperty _Lowpoly_DisplaceFrequency = null;
        static MaterialProperty _Lowpoly_DisplaceNoiseCoef = null;

        static MaterialProperty _Lowpoly_DisplaceMap = null;
        static MaterialProperty _Lowpoly_DisplaceMap_Scroll = null;
        static MaterialProperty _Lowpoly_DisplaceMapChannel = null;
        static MaterialProperty _Lowpoly_DisplaceMapStrength = null;
        static MaterialProperty _Lowpoly_DisplaceSecondaryMap = null;
        static MaterialProperty _Lowpoly_DisplaceSecondaryMap_Scroll = null;
        static MaterialProperty _Lowpoly_DisplaceSecondaryMapChannel = null;
        static MaterialProperty _Lowpoly_DisplaceSecondaryMapStrength = null;
        static MaterialProperty _Lowpoly_DisplaceMapsBlendMode = null;

        static MaterialProperty _Lowpoly_DiffuseColor;
        static MaterialProperty _Glossiness;
        static MaterialProperty _Metallic;
        static MaterialProperty _Lowpoly_SmoothnessSource;

        static MaterialProperty _Lowpoly_DiffuseBlendMode = null;
        static MaterialProperty _Lowpoly_DiffuseBlendStrength = null;
        static MaterialProperty _Lowpoly_DiffuseBlendAlphaPremultiply = null;

        static MaterialProperty _Lowpoly_DiffuseMap = null;
        static MaterialProperty _Lowpoly_DiffuseMap_Scroll = null;
        static MaterialProperty _Lowpoly_BumpMap = null;
        static MaterialProperty _Lowpoly_BumpMap_Scroll = null;
        static MaterialProperty _Lowpoly_BumpMapStrength = null;

        static MaterialProperty _Lowpoly_SampleType = null;
        static MaterialProperty _Lowpoly_FlatNormals = null;
        static MaterialProperty _Lowpoly_FlatLightMaps = null;

        static MaterialProperty _Lowpoly_Cull = null;
        static MaterialProperty _Lowpoly_AlphaTest = null;
        static MaterialProperty _Lowpoly_TransparentFade = null;

        //Wireframe
        static MaterialProperty _Lowpoly_WireframeThickness = null;
        static MaterialProperty _Lowpoly_WireframeSmoothness = null;
        static MaterialProperty _Lowpoly_WireframeDiameter = null;
        static MaterialProperty _Lowpoly_WireframeNormalizeEdges = null;
        static MaterialProperty _Lowpoly_WireframeColor = null;
        static MaterialProperty _Lowpoly_WireframeColorEmission = null;
        static MaterialProperty _Lowpoly_WireframeMode = null;
        static MaterialProperty _Lowpoly_WireframeTryQuads = null;
        #endregion


        MaterialEditor materialEditor;
        Material material;


        AlphaTest alphaTest;
        RenderMode renderMode;
        bool forceForwardRendering;


        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            this.materialEditor = materialEditor;
            this.material = (Material)materialEditor.target;


            FindProperties(properties);


            renderMode = material.shader.name.Contains("Fade") ? RenderMode.Transparent : RenderMode.Opaque;
            forceForwardRendering = material.shader.name.Contains("Forward Rendering");
            alphaTest = (AlphaTest)_Lowpoly_AlphaTest.floatValue;


            DrawCurvedWorld();
            DrawRenderingSettings();
            DrawLowpolyOptions();
            DrawDefaultSettings();


            base.OnGUI(materialEditor, properties);
        }

        void DrawCurvedWorld()
        {
            if(_CurvedWorldBendSettings != null)
            {
                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                {
                    EditorGUILayout.LabelField("Curved World", EditorStyles.boldLabel);
                    materialEditor.ShaderProperty(_CurvedWorldBendSettings, string.Empty);
                }
                EditorGUILayout.EndVertical();

                GUILayout.Space(5);
            }
        }
         
        void DrawRenderingSettings()
        {
            EditorGUI.BeginChangeCheck();
            renderMode = (RenderMode)EditorGUILayout.EnumPopup("Rendering Mode", renderMode);
            if(EditorGUI.EndChangeCheck())
            {
                materialEditor.RegisterPropertyChangeUndo("Rendering Mode");

                SetupShader();                
            }
            
            materialEditor.ShaderProperty(_Lowpoly_Cull, "Render Face");

            if (renderMode == RenderMode.Transparent)
                materialEditor.ShaderProperty(_Lowpoly_TransparentFade, "Fade By");
            else
                materialEditor.ShaderProperty(_Lowpoly_AlphaTest, "Alpha Test By");
        }

        void DrawLowpolyOptions()
        {
            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            {
                Rect rect = EditorGUILayout.GetControlRect();
                if (UnityEditor.EditorGUIUtility.isProSkin)
                    EditorGUI.DrawRect(new Rect(rect.xMin - 2, rect.yMin, rect.width + 4, rect.height), Color.white * 0.35f);

                EditorGUI.LabelField(rect, "Lowpoly Color", EditorStyles.boldLabel);
                EditorGUI.indentLevel++;
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Main Map"), _MainTex, _Color);
                    EditorGUI.indentLevel++;
                    {
                        materialEditor.TextureScaleOffsetProperty(_MainTex);
                        materialEditor.ShaderProperty(_MainTex_Scroll, string.Empty);
                    }
                    EditorGUI.indentLevel--;

                    materialEditor.ShaderProperty(_Lowpoly_SecondaryTextureBlendMode, "Secondary Map");
                    if (_Lowpoly_SecondaryTextureBlendMode.floatValue > 0.5f)
                    {
                        materialEditor.TexturePropertySingleLine(new GUIContent("Map"), _Lowpoly_SecondaryTex, _Lowpoly_SecondaryColor);
                        EditorGUI.indentLevel++;
                        {
                            materialEditor.TextureScaleOffsetProperty(_Lowpoly_SecondaryTex);
                            materialEditor.ShaderProperty(_Lowpoly_SecondaryTex_Scroll, string.Empty);

                            if (_Lowpoly_SecondaryTextureBlendMode.floatValue > 2.5f)
                                materialEditor.ShaderProperty(_Lowpoly_SecondaryTex_InvertAlpha, "Invert Alpha");
                        }
                        EditorGUI.indentLevel--;

                        GUILayout.Space(5);
                    }

                    if (renderMode == RenderMode.Opaque && alphaTest == AlphaTest.LowpolyColor)
                    {
                        materialEditor.ShaderProperty(_Cutoff, "Alpha Cutoff");

                        GUILayout.Space(5);
                    }
                }
                EditorGUI.indentLevel--;


                rect = EditorGUILayout.GetControlRect();
                if (UnityEditor.EditorGUIUtility.isProSkin)
                    EditorGUI.DrawRect(new Rect(rect.xMin - 2, rect.yMin, rect.width + 4, rect.height), Color.white * 0.35f);


                EditorGUI.LabelField(rect, "Wireframe", EditorStyles.boldLabel);
                EditorGUI.indentLevel++;
                {
                    materialEditor.ShaderProperty(_Lowpoly_WireframeMode, "Type");

                    if (_Lowpoly_WireframeMode.floatValue > 0.5f)
                    {
                        materialEditor.ShaderProperty(_Lowpoly_WireframeColor, "Color (A) Transparency");
                        materialEditor.ShaderProperty(_Lowpoly_WireframeColorEmission, "Color Emission");
                        materialEditor.ShaderProperty(_Lowpoly_WireframeThickness, "Thickness");
                        materialEditor.ShaderProperty(_Lowpoly_WireframeSmoothness, "Smoothness");
                        materialEditor.ShaderProperty(_Lowpoly_WireframeDiameter, "Diameter");
                        materialEditor.ShaderProperty(_Lowpoly_WireframeNormalizeEdges, "Normalize Edges");         
                        materialEditor.ShaderProperty(_Lowpoly_WireframeTryQuads, "Try Quads");         
                    }
                }
                EditorGUI.indentLevel--;


                rect = EditorGUILayout.GetControlRect();
                if (UnityEditor.EditorGUIUtility.isProSkin)
                    EditorGUI.DrawRect(new Rect(rect.xMin - 2, rect.yMin, rect.width + 4, rect.height), Color.white * 0.35f);

                EditorGUI.LabelField(rect, "Vertex Displace", EditorStyles.boldLabel);
                EditorGUI.indentLevel++;
                {
                    materialEditor.ShaderProperty(_Lowpoly_DisplaceMode, "Type");

                    DisplaceMode displaceMode = (DisplaceMode)_Lowpoly_DisplaceMode.floatValue;
                    switch (displaceMode)
                    {
                        case DisplaceMode.Parametric:
                            {
                                materialEditor.ShaderProperty(_Lowpoly_DisplaceScriptSynchronize, "Update From Scipt");
                                materialEditor.ShaderProperty(_Lowpoly_DisplaceDirection, "Direction (Angle)");
                                materialEditor.ShaderProperty(_Lowpoly_DisplaceSpeed, "Speed");
                                materialEditor.ShaderProperty(_Lowpoly_DisplaceAmplitude, "Amplitude");
                                materialEditor.ShaderProperty(_Lowpoly_DisplaceFrequency, "Frequence");
                                materialEditor.ShaderProperty(_Lowpoly_DisplaceNoiseCoef, "Noise");
                            }
                            break;

                        case DisplaceMode.OneTexture:
                            {
                                materialEditor.TexturePropertySingleLine(new GUIContent("Displace Map"), _Lowpoly_DisplaceMap, _Lowpoly_DisplaceMapStrength, _Lowpoly_DisplaceMapChannel);
                                EditorGUI.indentLevel++;
                                {
                                    materialEditor.TextureScaleOffsetProperty(_Lowpoly_DisplaceMap);
                                    materialEditor.ShaderProperty(_Lowpoly_DisplaceMap_Scroll, string.Empty);
                                }
                                EditorGUI.indentLevel--;
                            }
                            break;

                        case DisplaceMode.TwoTextures:
                            {
                                materialEditor.TexturePropertySingleLine(new GUIContent("Displace Map"), _Lowpoly_DisplaceMap, _Lowpoly_DisplaceMapStrength, _Lowpoly_DisplaceMapChannel);
                                EditorGUI.indentLevel++;
                                {
                                    materialEditor.TextureScaleOffsetProperty(_Lowpoly_DisplaceMap);
                                    materialEditor.ShaderProperty(_Lowpoly_DisplaceMap_Scroll, string.Empty);
                                }
                                EditorGUI.indentLevel--;

                                materialEditor.ShaderProperty(_Lowpoly_DisplaceMapsBlendMode, "Bend Mode");
                                materialEditor.TexturePropertySingleLine(new GUIContent("Secondary Map"), _Lowpoly_DisplaceSecondaryMap, _Lowpoly_DisplaceSecondaryMapStrength, _Lowpoly_DisplaceSecondaryMapChannel);
                                EditorGUI.indentLevel++;
                                {
                                    materialEditor.TextureScaleOffsetProperty(_Lowpoly_DisplaceSecondaryMap);
                                    materialEditor.ShaderProperty(_Lowpoly_DisplaceSecondaryMap_Scroll, string.Empty);
                                }
                                EditorGUI.indentLevel--;
                            }
                            break;

                        default:
                            break;
                    }
                }
                EditorGUI.indentLevel--;


                rect = EditorGUILayout.GetControlRect();
                if (UnityEditor.EditorGUIUtility.isProSkin)
                    EditorGUI.DrawRect(new Rect(rect.xMin - 2, rect.yMin, rect.width + 4, rect.height), Color.white * 0.35f);

                EditorGUI.LabelField(rect, "Render Settings", EditorStyles.boldLabel);
                EditorGUI.indentLevel++;
                {
                    materialEditor.ShaderProperty(_Lowpoly_SampleType, "Color Sample Type");

                    if (forceForwardRendering)
                    {
                        GUI.enabled = false;
                        {
                            EditorGUILayout.Toggle("Flat Normals", true);
                        }
                        GUI.enabled = true;
                    }
                    else
                    {
                        materialEditor.ShaderProperty(_Lowpoly_FlatNormals, "Flat Normals");
                    }

                    EditorGUI.BeginChangeCheck();
                    forceForwardRendering = EditorGUILayout.Toggle("Flat All Lights", forceForwardRendering);
                    if (EditorGUI.EndChangeCheck())
                    {
                        Undo.RecordObject(material, "Shader Change");

                        SetupShader();
                    }

                    materialEditor.ShaderProperty(_Lowpoly_FlatLightMaps, "Flat Lightmaps");
                }
                EditorGUI.indentLevel--;
            }
            EditorGUILayout.EndVertical();
        }

        void DrawDefaultSettings()
        {
            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            {
                Rect rect = EditorGUILayout.GetControlRect();
                if (UnityEditor.EditorGUIUtility.isProSkin)
                    EditorGUI.DrawRect(new Rect(rect.xMin - 2, rect.yMin, rect.width + 4, rect.height), Color.white * 0.35f);

                EditorGUI.LabelField(rect, "Default", EditorStyles.boldLabel);
                EditorGUI.indentLevel++;
                {                    
                    materialEditor.ShaderProperty(_Lowpoly_UseVertexColor, "Use Vertex Color");
                                        
                    materialEditor.ShaderProperty(_Metallic, "Metallic");
                    materialEditor.ShaderProperty(_Glossiness, "Smoothness");
                    EditorGUI.indentLevel++;
                    {
                        materialEditor.ShaderProperty(_Lowpoly_SmoothnessSource, "Source");
                    }
                    EditorGUI.indentLevel--;

                    GUILayout.Space(5);
                    materialEditor.ShaderProperty(_Lowpoly_DiffuseBlendMode, "Diffuse Mode");
                    if(_Lowpoly_DiffuseBlendMode.floatValue > 0.5f)
                    {
                        materialEditor.ShaderProperty(_Lowpoly_DiffuseBlendStrength, "Blend Strength");
                        GUILayout.Space(10);

                        materialEditor.TexturePropertySingleLine(new GUIContent("Diffuse Map"), _Lowpoly_DiffuseMap, _Lowpoly_DiffuseColor);
                        EditorGUI.indentLevel++;
                        {
                            materialEditor.TextureScaleOffsetProperty(_Lowpoly_DiffuseMap);
                            materialEditor.ShaderProperty(_Lowpoly_DiffuseMap_Scroll, string.Empty);

                            materialEditor.ShaderProperty(_Lowpoly_DiffuseBlendAlphaPremultiply, "Alpha Premultiply");
                        }
                        EditorGUI.indentLevel--;

                        if (renderMode == RenderMode.Opaque && alphaTest == AlphaTest.Basemap)
                            materialEditor.ShaderProperty(_Cutoff, "Alpha Cutoff");


                        GUILayout.Space(5);
                        EditorGUI.BeginChangeCheck();
                        materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map"), _Lowpoly_BumpMap, _Lowpoly_BumpMapStrength);
                        if (EditorGUI.EndChangeCheck())
                        {
                            materialEditor.RegisterPropertyChangeUndo("Normal Map");

                            if (_Lowpoly_BumpMap.textureValue == null)
                                material.DisableKeyword("_NORMALMAP");
                            else
                                material.EnableKeyword("_NORMALMAP");
                        }

                        EditorGUI.indentLevel++;
                        {
                            materialEditor.TextureScaleOffsetProperty(_Lowpoly_BumpMap);
                            materialEditor.ShaderProperty(_Lowpoly_BumpMap_Scroll, string.Empty);
                        }
                        EditorGUI.indentLevel--;
                    }
                }
                EditorGUI.indentLevel--;
            }
            EditorGUILayout.EndVertical();
        }


        void FindProperties(MaterialProperty[] properties)
        {
            _CurvedWorldBendSettings = FindProperty("_CurvedWorldBendSettings", properties, false);

            _Color = FindProperty("_Color", properties);
            _Lowpoly_UseVertexColor = FindProperty("_Lowpoly_UseVertexColor", properties);

            _MainTex = FindProperty("_MainTex", properties);
            _MainTex_Scroll = FindProperty("_MainTex_Scroll", properties);
            _Lowpoly_SecondaryTextureBlendMode = FindProperty("_Lowpoly_SecondaryTextureBlendMode", properties);
            _Lowpoly_SecondaryTex = FindProperty("_Lowpoly_SecondaryTex", properties);
            _Lowpoly_SecondaryColor = FindProperty("_Lowpoly_SecondaryColor", properties);
            _Lowpoly_SecondaryTex_Scroll = FindProperty("_Lowpoly_SecondaryTex_Scroll", properties);
            _Lowpoly_SecondaryTex_InvertAlpha = FindProperty("_Lowpoly_SecondaryTex_InvertAlpha", properties);
            _Cutoff = FindProperty("_Cutoff", properties);


            _Lowpoly_DisplaceMode = FindProperty("_Lowpoly_DisplaceMode", properties);
            _Lowpoly_DisplaceScriptSynchronize = FindProperty("_Lowpoly_DisplaceScriptSynchronize", properties);
            _Lowpoly_DisplaceDirection = FindProperty("_Lowpoly_DisplaceDirection", properties);
            _Lowpoly_DisplaceSpeed = FindProperty("_Lowpoly_DisplaceSpeed", properties);
            _Lowpoly_DisplaceAmplitude = FindProperty("_Lowpoly_DisplaceAmplitude", properties);
            _Lowpoly_DisplaceFrequency = FindProperty("_Lowpoly_DisplaceFrequency", properties);
            _Lowpoly_DisplaceNoiseCoef = FindProperty("_Lowpoly_DisplaceNoiseCoef", properties);

            _Lowpoly_DisplaceMap = FindProperty("_Lowpoly_DisplaceMap", properties);
            _Lowpoly_DisplaceMap_Scroll = FindProperty("_Lowpoly_DisplaceMap_Scroll", properties);
            _Lowpoly_DisplaceMapChannel = FindProperty("_Lowpoly_DisplaceMapChannel", properties);
            _Lowpoly_DisplaceMapStrength = FindProperty("_Lowpoly_DisplaceMapStrength", properties);
            _Lowpoly_DisplaceSecondaryMap = FindProperty("_Lowpoly_DisplaceSecondaryMap", properties);
            _Lowpoly_DisplaceSecondaryMap_Scroll = FindProperty("_Lowpoly_DisplaceSecondaryMap_Scroll", properties);
            _Lowpoly_DisplaceSecondaryMapChannel = FindProperty("_Lowpoly_DisplaceSecondaryMapChannel", properties);
            _Lowpoly_DisplaceSecondaryMapStrength = FindProperty("_Lowpoly_DisplaceSecondaryMapStrength", properties);
            _Lowpoly_DisplaceMapsBlendMode = FindProperty("_Lowpoly_DisplaceMapsBlendMode", properties);


            _Lowpoly_DiffuseColor = FindProperty("_Lowpoly_DiffuseColor", properties);
            _Glossiness = FindProperty("_Glossiness", properties);
            _Metallic = FindProperty("_Metallic", properties);
            _Lowpoly_SmoothnessSource = FindProperty("_Lowpoly_SmoothnessSource", properties);

            _Lowpoly_DiffuseBlendMode = FindProperty("_Lowpoly_DiffuseBlendMode", properties);
            _Lowpoly_DiffuseBlendStrength = FindProperty("_Lowpoly_DiffuseBlendStrength", properties);
            _Lowpoly_DiffuseBlendAlphaPremultiply = FindProperty("_Lowpoly_DiffuseBlendAlphaPremultiply", properties);
            _Lowpoly_DiffuseMap = FindProperty("_Lowpoly_DiffuseMap", properties);
            _Lowpoly_DiffuseMap_Scroll = FindProperty("_Lowpoly_DiffuseMap_Scroll", properties);
            _Lowpoly_BumpMap = FindProperty("_Lowpoly_BumpMap", properties);
            _Lowpoly_BumpMap_Scroll = FindProperty("_Lowpoly_BumpMap_Scroll", properties);
            _Lowpoly_BumpMapStrength = FindProperty("_Lowpoly_BumpMapStrength", properties);

            _Lowpoly_SampleType = FindProperty("_Lowpoly_SampleType", properties);
            _Lowpoly_FlatNormals = FindProperty("_Lowpoly_FlatNormals", properties);
            _Lowpoly_FlatLightMaps = FindProperty("_Lowpoly_FlatLightMaps", properties);

            _Lowpoly_Cull = FindProperty("_Lowpoly_Cull", properties);
            _Lowpoly_AlphaTest = FindProperty("_Lowpoly_AlphaTest", properties);
            _Lowpoly_TransparentFade = FindProperty("_Lowpoly_TransparentFade", properties);

            //Wireframe
            _Lowpoly_WireframeThickness = FindProperty("_Lowpoly_WireframeThickness", properties);
            _Lowpoly_WireframeSmoothness = FindProperty("_Lowpoly_WireframeSmoothness", properties);
            _Lowpoly_WireframeDiameter = FindProperty("_Lowpoly_WireframeDiameter", properties);
            _Lowpoly_WireframeNormalizeEdges = FindProperty("_Lowpoly_WireframeNormalizeEdges", properties);
            _Lowpoly_WireframeColor = FindProperty("_Lowpoly_WireframeColor", properties);
            _Lowpoly_WireframeColorEmission = FindProperty("_Lowpoly_WireframeColorEmission", properties);
            _Lowpoly_WireframeMode = FindProperty("_Lowpoly_WireframeMode", properties);
            _Lowpoly_WireframeTryQuads = FindProperty("_Lowpoly_WireframeTryQuads", properties);
        }

        void SetupShader() 
        {
            if(renderMode == RenderMode.Transparent)
            {
                if (forceForwardRendering)
                    material.shader = Shader.Find("Hidden/Amazing Assets/Lowpoly Shader/Lit (Fade Forward Rendering)");
                else
                    material.shader = Shader.Find("Hidden/Amazing Assets/Lowpoly Shader/Lit (Fade)");
            }
            else
            {
                if (forceForwardRendering)
                    material.shader = Shader.Find("Hidden/Amazing Assets/Lowpoly Shader/Lit (Forward Rendering)");
                else
                   material.shader = Shader.Find("Amazing Assets/Lowpoly Shader/Lit");
            }
        }
    }
}
