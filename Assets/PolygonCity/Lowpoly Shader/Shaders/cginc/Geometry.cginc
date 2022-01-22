#ifndef AMAZING_ASSETS_LOWPOLY_SHADER_GEOMETRY_CGINC
#define AMAZING_ASSETS_LOWPOLY_SHADER_GEOMETRY_CGINC


#define WireframeShaderDistanceToEdge(a,b,c) length(cross(a - b, a - c))


inline float4 CalcTangent(float3 v1, float3 v2, float3 v3, float2 w1, float2 w2, float2 w3, float3 _n)
{
	float x1 = v2.x - v1.x;
	float x2 = v3.x - v1.x;
	float y1 = v2.y - v1.y;
	float y2 = v3.y - v1.y;
	float z1 = v2.z - v1.z;
	float z2 = v3.z - v1.z;

	float s1 = w2.x - w1.x;
	float s2 = w3.x - w1.x;
	float t1 = w2.y - w1.y;
	float t2 = w3.y - w1.y;

	float r = 0.0001f;
	if (s1 * t2 - s2 * t1 != 0)
		r = 1.0f / (s1 * t2 - s2 * t1);

	float3 tan1 = normalize(float3((t2 * x1 - t1 * x2) * r, (t2 * y1 - t1 * y2) * r, (t2 * z1 - t1 * z2) * r));
    float3 tan2 = normalize(float3((s1 * x2 - s2 * x1) * r, (s1 * y2 - s2 * y1) * r, (s1 * z2 - s2 * z1) * r));


	float w = (dot(cross(_n, tan1), tan2) < 0.0f) ? -1.0f : 1.0f;

	return float4(tan1, w);	 
} 

void CalculateWireframeMass(float3 vertex1, float3 vertex2, float3 vertex3, out float3 mass1, out float3 mass2, out float3 mass3)
{
	#if defined(_LOWPOLY_WIREFRAME_NORMALIZE_EDGES)

		float d1 = distance(vertex1, vertex2);
		float d2 = distance(vertex2, vertex3);
		float d3 = distance(vertex3,  vertex1);		

		float4 b = float4(0, 
		                  WireframeShaderDistanceToEdge(vertex3, vertex1, vertex2) / d1, 
						  WireframeShaderDistanceToEdge(vertex1, vertex2, vertex3) / d2, 
						  WireframeShaderDistanceToEdge(vertex2, vertex1, vertex3) / d3);
		b /= min(b.y, min(b.z, b.w));


		mass1 = b.xzx;
		mass2 = b.xxw;
		mass3 = b.yxx;

		#ifdef _LOWPOLY_WIREFRAME_TRY_QUADS
			
			mass1.x = ((d1 > d2) && (d1 > d3)) ? 10000 : 0;
			mass1.z = ((d3 >= d1) && (d3 > d2)) ? 10000 : 0;
			mass2.y = ((d2 >= d1) && (d2 >= d3)) ? 10000 : 0;

		#endif

	#else

		#if defined(_LOWPOLY_WIREFRAME_TRY_QUADS)

			float d1 = distance(vertex1, vertex2);
			float d2 = distance(vertex2, vertex3);
			float d3 = distance(vertex3, vertex1);

			float3 offset = 0;
			if (d1 > d2 && d1 > d3)
				offset.y = 1;
			else if (d2 > d3 && d2 > d1)
				offset.x = 1;
			else
				offset.z = 1;
			
			mass1 = float3(1, 0, 0) + offset;
			mass2 = float3(0, 0, 1) + offset;
			mass3 = float3(0, 1, 0) + offset;

		#else

			mass1 = float3(1, 0, 0);
			mass2 = float3(0, 1, 0);
			mass3 = float3(0, 0, 1);

		#endif

	#endif
}

[maxvertexcount(3)]
#if defined(LOWPOLY_SHADER_SKYBOX)
void geom(triangle v2f input[3], inout TriangleStream<v2f> triStream)
#else
void geom(triangle v2f_surf input[3], inout TriangleStream<v2f_surf> triStream)
#endif
{
	//Vertex
	#if defined(LOWPOLY_GEOMETRY_READ_WORLD_POSITION_WORLD_SPACE)
		float3 v0 = input[0].worldPos;
		float3 v1 = input[1].worldPos;
		float3 v2 = input[2].worldPos;

		float3 positon = (v0 + v1 + v2) / 3;

	#elif defined(LOWPOLY_GEOMETRY_READ_WORLD_POSITION_TANGENT_SPACE)
		float3 v0 = float3(input[0].tSpace0.w, input[0].tSpace1.w, input[0].tSpace2.w);
		float3 v1 = float3(input[1].tSpace0.w, input[1].tSpace1.w, input[1].tSpace2.w);
		float3 v2 = float3(input[2].tSpace0.w, input[2].tSpace1.w, input[2].tSpace2.w);

		#if defined(_LOWPOLY_SAMPLETYPE_FIRST_INDEX)
			float3 positon = v0;
		#else
			float3 positon = (v0 + v1 + v2) / 3;
		#endif

	#else
		float3 v0 = float3(1, 0, 0);
		float3 v1 = float3(0, 1, 0);
		float3 v2 = float3(0, 0, 1);

		float3 positon = float3(0, 0, 0);
	#endif

	//Normal
	#if defined(LOWPOLY_GEOMETRY_READ_WORLD_NORMAL_TANGENT_SPACE)
		float3 normal0 = float3(input[0].tSpace0.z, input[0].tSpace1.z, input[0].tSpace2.z);
		float3 normal1 = float3(input[1].tSpace0.z, input[1].tSpace1.z, input[1].tSpace2.z);
		float3 normal2 = float3(input[2].tSpace0.z, input[2].tSpace1.z, input[2].tSpace2.z);

		#if defined(_LOWPOLY_SAMPLETYPE_FIRST_INDEX)
			float3 normal = normal0;
		#else
			float3 normal = normalize((normal0 + normal1 + normal2) / 3);
		#endif

	#elif defined(LOWPOLY_GEOMETRY_RECONSTRUCT_DISPLACE_NORMALS)
		float3 normal = normalize(cross(v1 - v0, v2 - v0));
	#endif




	//Position
	#if defined(LOWPOLY_GEOMETRY_SAVE_WORLD_POSITION_WORLD_SPACE)
		input[0].worldPos = positon;
		input[1].worldPos = positon;
		input[2].worldPos = positon;

	#elif defined(LOWPOLY_GEOMETRY_SAVE_WORLD_POSITION_TANGENT_SPACE)
		input[0].tSpace0.w = positon.x;	
		input[0].tSpace1.w = positon.y;	
		input[0].tSpace2.w = positon.z;	

		input[1].tSpace0.w = positon.x;	
		input[1].tSpace1.w = positon.y;	
		input[1].tSpace2.w = positon.z;	

		input[2].tSpace0.w = positon.x;	
		input[2].tSpace1.w = positon.y;	
		input[2].tSpace2.w = positon.z;	
	#endif

	//Normal
	#if defined(LOWPOLY_GEOMETRY_SAVE_NORMAL_WORLD_NORMAL)
		input[0].worldNormal = normal;	
		input[1].worldNormal = normal;	
		input[2].worldNormal = normal;	
	#elif defined(LOWPOLY_GEOMETRY_SAVE_NORMAL_TANGENT_SPACE)
		input[0].tSpace0.z = input[1].tSpace0.z = input[2].tSpace0.z = normal.x;
		input[0].tSpace1.z = input[1].tSpace1.z = input[2].tSpace1.z = normal.y;
		input[0].tSpace2.z = input[1].tSpace2.z = input[2].tSpace2.z = normal.z;
	#endif 

	
	//Lighmap UV
	#if defined(_LOWPOLY_FLAT_LIGHTMAPS)
		#if defined(UNITY_PASS_FORWARDBASE) || defined(UNITY_PASS_DEFERRED)
			#if defined(_LOWPOLY_SAMPLETYPE_FIRST_INDEX)
				float4 lmap = input[0].lmap;
			#else
				float4 lmap = (input[0].lmap + input[1].lmap + input[2].lmap) / 3.0;
			#endif
		 
			input[0].lmap = lmap;	
			input[1].lmap = lmap;	
			input[2].lmap = lmap;	
		#endif
	#endif

	//SH
	#if defined(LOWPOLY_GEOMETRY_SPHERICAL_HARMONICS)
		#if defined(_LOWPOLY_SAMPLETYPE_FIRST_INDEX)
			half3 sh = input[0].sh;
		#else
			half3 sh = (input[0].sh + input[1].sh + input[2].sh) / 3;
		#endif
		 
		input[0].sh = sh;	
		input[1].sh = sh;	
		input[2].sh = sh;	
	#endif



	//Color
	#if defined(_LOWPOLY_SAMPLETYPE_FIRST_INDEX)

		float2 uv = input[0].texcoord.xy;
		fixed4 lowpolyColor = input[0].color;

	#else

		float2 uv = (input[0].texcoord.xy + input[1].texcoord.xy + input[2].texcoord.xy) / 3;
		fixed4 lowpolyColor = (input[0].color + input[1].color + input[2].color) / 3.0;

	#endif
	
	input[0].texcoord.zw = uv;
	input[1].texcoord.zw = uv;
	input[2].texcoord.zw = uv;

	input[0].color = lowpolyColor;
	input[1].color = lowpolyColor;
	input[2].color = lowpolyColor;

	

	//Wireframe
	#if defined(LOWPOLY_GEOMETRY_CALCULATE_WIREFRAME)
		float3 mass0, mass1, mass2;
		CalculateWireframeMass(v0, v1, v2, mass0, mass1, mass2);

		input[0].wireframe = mass0;
 		input[1].wireframe = mass1;
 		input[2].wireframe = mass2;
	#endif



	triStream.Append( input[0] );
	triStream.Append( input[1] );
    triStream.Append( input[2] );

	triStream.RestartStrip();
} 

#endif
