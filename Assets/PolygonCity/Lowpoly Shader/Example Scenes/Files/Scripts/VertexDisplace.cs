using UnityEngine;
using System.Collections;

namespace AmazingAssets.LowpolyShader.Example
{
    public class VertexDisplace : MonoBehaviour
    {
        //Variables //////////////////////////////////////////////////////////////////
        [Range(0f, 360f)]
        public float direction = 0;
        public float speed = 1;
        public float amplitude = 1f;
        public float frequency = 0.5f;
        public float noise = 1.0f;

        public Material targetMaterial;

        Vector3 originalPosition;

        public float stepLength = 0.5f;
        float deltaTime = 0;
        float deltaStep = 0;


        //Functions ////////////////////////////////////////////////////////////
        void Start()
        {
            originalPosition = transform.position;
        }

        void Update()
        {
            deltaTime += Time.deltaTime;
            deltaStep += Time.deltaTime;

            if (deltaStep > stepLength)
            {

                #region Shader time sync
                if (targetMaterial != null)
                {
                    targetMaterial.SetFloat("_Lowpoly_ScriptTime", Time.time);

                    targetMaterial.SetFloat("_Lowpoly_DisplaceDirection", direction);
                    targetMaterial.SetFloat("_Lowpoly_DisplaceSpeed", speed);
                    targetMaterial.SetFloat("_Lowpoly_DisplaceAmplitude", amplitude);
                    targetMaterial.SetFloat("_Lowpoly_DisplaceFrequency", frequency);
                    targetMaterial.SetFloat("_Lowpoly_DisplaceNoiseCoef", noise);



                    //Animate diffuse maps
                    Vector2 offset = new Vector2(Random.value, 0);
                    targetMaterial.SetTextureOffset("_Lowpoly_DiffuseMap", offset);
                    targetMaterial.SetTextureOffset("_Lowpoly_BumpMap", offset);
                }
                #endregion



                #region Update transform position
                //Current world position
                Vector3 worldPos = originalPosition;

                //Direction
                Vector2 dir = Rotate(new Vector2(worldPos.x, worldPos.z), direction - 45);

                //Noise
                float n = Noise(new Vector3(worldPos.x, worldPos.z, worldPos.z)) * noise;

                //Calculate diplace
                float displace = (amplitude * (n + 1)) * Mathf.Sin(Vector2.Dot(dir, Vector2.one * frequency) + deltaTime * speed + n);

                //Update position
                Vector3 newPos = worldPos;
                newPos.y += displace;

                transform.position = Vector3.Lerp(originalPosition, newPos, Mathf.SmoothStep(0f, 1f, deltaTime));
                #endregion


                //Reset deltaStep 
                deltaStep = 0;
            }
        }

        float Noise(Vector3 e)
        {
            float r = Mathf.Sin(Vector3.Dot(e, new Vector3(12.9898f, 78.233f, 63.9137f)));

            return r - Mathf.Floor(r);
        }

        public Vector2 Rotate(Vector2 v, float degrees)
        {
            float radians = degrees * Mathf.Deg2Rad;
            float sin = Mathf.Sin(radians);
            float cos = Mathf.Cos(radians);

            float tx = v.x;
            float ty = v.y;

            return new Vector2(cos * tx - sin * ty, sin * tx + cos * ty);
        }
    }
}