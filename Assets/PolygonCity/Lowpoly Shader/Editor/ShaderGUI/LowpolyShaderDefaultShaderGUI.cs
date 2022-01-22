using System;
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEditor;


namespace AmazingAssets.LowpolyShader
{
    public class LowpolyShaderDefaultShaderGUI : ShaderGUI
    {
        static MaterialProperty _CurvedWorldBendSettings = null;


        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            _CurvedWorldBendSettings = FindProperty("_CurvedWorldBendSettings", properties, false);
            if(_CurvedWorldBendSettings != null)
            {
                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                {
                    EditorGUILayout.LabelField("Curved World", EditorStyles.boldLabel);
                    materialEditor.ShaderProperty(_CurvedWorldBendSettings, string.Empty);

                    GUILayout.Space(5);
                }
                EditorGUILayout.EndVertical();
            }


            base.OnGUI(materialEditor, properties);
        }
    }
}
