using UnityEngine;
using UnityEditor;

namespace AmazingAssets
{
    namespace LowpolyShader
    {
        class LowpolyShaderSpaceDrawer : MaterialPropertyDrawer
        {
            public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
            {
                EditorGUI.LabelField(position, string.Empty);
            }
        }
    }
}