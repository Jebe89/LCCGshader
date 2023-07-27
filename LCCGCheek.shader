// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LCCGshader/Cheek"
{
	Properties
	{
		[Header(Diffuse)]_MaskTex("CheekMaskMap (_cheek_A)", 2D) = "black" {}
		_CheekStrength("CheekStrength", Range( 0 , 100)) = 10
		[Toggle]_ShadowLerp("ShadowLerp", Float) = 0
		_MainTex("Color Map (_cheek_C)", 2D) = "red" {}
		_CustomCheekColor("CustomCheekColor", Color) = (1,0,0,0)
		_CustomCheekColorRate("CustomCheekColorRate", Range( 0 , 1)) = 0
		_ShadowColor("ShadowColor", Color) = (0.7,0.7,0.7,0)
		_ShadowStep("ShadowStep", Range( 0 , 1)) = 0
		_ShadowFeather1("ShadowFeather", Range( 0 , 1)) = 0.2
		[Toggle]_ReceiveShadowLerp("ReceiveShadowLerp", Float) = 1
		[Toggle]_ShadowinLightColor("Shadow in LightColor", Float) = 1
		[Toggle]_NoShadowinDirectionalLightColor("NoShadow in DirectionalLightColor", Float) = 1
		[Header(Dirt)]_DirtTex("DirtTex", 2D) = "black" {}
		[HDR]_GlobalDirtColor("GlobalDirtColor", Color) = (1,1,1,0)
		_DirtScale("DirtScale", Range( 0 , 1)) = 0
		_DirtRateR("DirtRateR", Range( 0 , 1)) = 1
		_DirtRateG("DirtRateG", Range( 0 , 1)) = 1
		_DirtRateB("DirtRateB", Range( 0 , 1)) = 1
		[Header(Saturation)]_Saturation("Saturation", Range( 0 , 1)) = 1
		[HDR]_UnsaturationColor("UnsaturationColor", Color) = (0.2117647,0.7137255,0.07058824,0)
		[Header(Light)]_MinDirectLight("MinDirectLight", Range( 0 , 1)) = 0
		_MaxDirectLight("MaxDirectLight", Range( 0 , 2)) = 1
		[Toggle]_UnifyIndirectDiffuseLight("Unify IndirectDiffuseLight", Float) = 1
		_MinIndirectLight("MinIndirectLight", Range( 0 , 1)) = 0.1
		_MaxIndirectLight("MaxIndirectLight", Range( 0 , 2)) = 1
		_LightColorGrayScale("LightColor GrayScale", Range( 0 , 1)) = 0
		_DiffuseLightFactor("DiffuseLightFactor", Range( 0 , 1)) = 0
		_GlobalLightFactor("GlobalLightFactor", Range( 0 , 1)) = 1
		[Header(Stencil Buffer)]_StencilReference("Stencil Reference", Range( 0 , 255)) = 0
		_StencilReadMask("Stencil ReadMask", Range( 0 , 255)) = 255
		_StencilWriteMask("Stencil WriteMask", Range( 0 , 255)) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)]_StencilComparison("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilPassFront("Stencil PassFront", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilFailFront("Stencil FailFront", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilZFailFront("Stencil ZFailFront", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="AlphaTest" }
	LOD 100

		Cull Off
		CGINCLUDE
		#pragma target 3.0 
		ENDCG

       	GrabPass{ }

		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend Off
			BlendOp Add, Max
			AlphaToMask Off
			Cull [_CullMode]
			ColorMask RGBA
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			Stencil
			{
				Ref [_StencilReference]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComparison]
				Pass [_StencilPassFront]
				Fail [_StencilFailFront]
				ZFail [_StencilZFailFront]
			}
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
			#else
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
			#endif

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			#ifndef UNITY_PASS_FORWARDBASE
			#define UNITY_PASS_FORWARDBASE
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_SHADOWS 1

			//This is a late directive
			
			uniform float _StencilZFailFront;
			uniform float _StencilFailFront;
			uniform float _StencilComparison;
			uniform float _StencilPassFront;
			uniform float _StencilWriteMask;
			uniform float _StencilReadMask;
			uniform float _StencilReference;
			uniform float _CullMode;
			uniform float4 _UnsaturationColor;
			uniform float _ShadowLerp;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float4 _CustomCheekColor;
			uniform float _CustomCheekColorRate;
			uniform float4 _ShadowColor;
			uniform float _ShadowStep;
			uniform float _ReceiveShadowLerp;
			uniform float _ShadowFeather1;
			uniform float _NoShadowinDirectionalLightColor;
			uniform float _MinDirectLight;
			uniform float _ShadowinLightColor;
			uniform float _MaxDirectLight;
			uniform float _UnifyIndirectDiffuseLight;
			uniform float _MinIndirectLight;
			uniform float _MaxIndirectLight;
			uniform float _LightColorGrayScale;
			uniform float _DiffuseLightFactor;
			uniform float _GlobalLightFactor;
			uniform float4 _GlobalDirtColor;
			uniform float _DirtRateR;
			uniform sampler2D _DirtTex;
			uniform float4 _DirtTex_ST;
			uniform float _DirtScale;
			uniform float _DirtRateG;
			uniform float _DirtRateB;
			uniform float _Saturation;
			uniform sampler2D _MaskTex;
			uniform float4 _MaskTex_ST;
			uniform float _CheekStrength;
			ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
			float PureLightAttenuation( float3 worldPos )
			{
				#ifdef POINT
				        unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz; \
				        return tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r;
				#endif
				#ifdef SPOT
				#if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1))
				#else
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = input._LightCoord
				#endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz);
				#endif
				#ifdef DIRECTIONAL
				        return 1;
				#endif
				#ifdef POINT_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w;
				#endif
				#ifdef DIRECTIONAL_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xy
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTexture0, lightCoord).w;
				#endif
			}
			
			inline float4 ASE_ComputeGrabScreenPos( float4 pos )
			{
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				float4 o = pos;
				o.y = pos.w * 0.5f;
				o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
				return o;
			}
			


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
			};
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_SHADOW_COORDS(4)
				float4 ase_lmap : TEXCOORD5;
				float4 ase_sh : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
			};
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				
				float3 ase_worldPos = mul(unity_ObjectToWorld, float4( (v.vertex).xyz, 1 )).xyz;
				o.ase_texcoord2.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				#ifdef DYNAMICLIGHTMAP_ON //dynlm
				o.ase_lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif //dynlm
				#ifdef LIGHTMAP_ON //stalm
				o.ase_lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif //stalm
				#ifndef LIGHTMAP_ON //nstalm
				#if UNITY_SHOULD_SAMPLE_SH //sh
				o.ase_sh.xyz = 0;
				#ifdef VERTEXLIGHT_ON //vl
				o.ase_sh.xyz += Shade4PointLights (
				unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
				unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
				unity_4LightAtten0, ase_worldPos, ase_worldNormal);
				#endif //vl
				o.ase_sh.xyz = ShadeSHPerVertex (ase_worldNormal, o.ase_sh.xyz);
				#endif //sh
				#endif //nstalm
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord7 = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_sh.w = 0;
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.pos = UnityObjectToClipPos(v.vertex);
				#if ASE_SHADOWS
					#if UNITY_VERSION >= 560
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#else
						TRANSFER_SHADOW( o );
					#endif
				#endif
				return o;
			}
			
			float4 frag (v2f i ) : SV_Target
			{
				float3 outColor;
				float outAlpha;

				float2 uv_MainTex = i.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 color345 = tex2D( _MainTex, uv_MainTex );
				float4 lerpResult993 = lerp( color345 , _CustomCheekColor , _CustomCheekColorRate);
				float localIsThereALight1110 = ( any(_WorldSpaceLightPos0.xyz) );
				float3 ase_worldPos = i.ase_texcoord2.xyz;
				float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				float3 localDefaultLightDir1111 = ( normalize(UNITY_MATRIX_V[2].xyz + UNITY_MATRIX_V[1].xyz) );
				float3 LightDir1096 = ( localIsThereALight1110 == 1.0 ? worldSpaceLightDir : localDefaultLightDir1111 );
				float3 ase_worldNormal = i.ase_texcoord3.xyz;
				float dotResult1084 = dot( LightDir1096 , ase_worldNormal );
				float HalfLambertTerm1132 = (dotResult1084*0.5 + 0.5);
				float localIsThereALight1186 = ( any(_WorldSpaceLightPos0.xyz) );
				UNITY_LIGHT_ATTENUATION(ase_atten, i, ase_worldPos)
				float HalfShadowAttenuation1128 = ( localIsThereALight1186 == 1.0 ? (saturate( ase_atten )*0.5 + 0.5) : 1.0 );
				float shad_lerp1134 = saturate( ( ( _ShadowStep - (( _ReceiveShadowLerp )?( ( HalfLambertTerm1132 * HalfShadowAttenuation1128 ) ):( HalfLambertTerm1132 )) ) / _ShadowFeather1 ) );
				float4 lerpResult1145 = lerp( lerpResult993 , ( lerpResult993 * _ShadowColor ) , shad_lerp1134);
				#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				float4 ase_lightColor = 0;
				#else //aselc
				float4 ase_lightColor = _LightColor0;
				#endif //aselc
				float3 temp_cast_0 = (_MinDirectLight).xxx;
				float3 clampResult1184 = clamp( ase_lightColor.rgb , temp_cast_0 , float3( 2,2,2 ) );
				float3 worldPos1107 = ase_worldPos;
				float localPureLightAttenuation1107 = PureLightAttenuation( worldPos1107 );
				float3 temp_output_1103_0 = ( clampResult1184 * (( _ShadowinLightColor )?( ase_atten ):( localPureLightAttenuation1107 )) );
				#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch1104 = temp_output_1103_0;
				#else
				float3 staticSwitch1104 = clampResult1184;
				#endif
				float3 temp_cast_1 = (_MaxDirectLight).xxx;
				float3 clampResult1100 = clamp( (( _NoShadowinDirectionalLightColor )?( staticSwitch1104 ):( temp_output_1103_0 )) , float3( 0,0,0 ) , temp_cast_1 );
				UnityGIInput data1112;
				UNITY_INITIALIZE_OUTPUT( UnityGIInput, data1112 );
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON) //dylm1112
				data1112.lightmapUV = i.ase_lmap;
				#endif //dylm1112
				#if UNITY_SHOULD_SAMPLE_SH //fsh1112
				data1112.ambient = i.ase_sh;
				#endif //fsh1112
				UnityGI gi1112 = UnityGI_Base(data1112, 1, ase_worldNormal);
				float3 localMaxShadeSH91120 = ( max(ShadeSH9(half4(0, 0, 0, 1)).rgb, ShadeSH9(half4(0, -1, 0, 1)).rgb) );
				float3 temp_cast_2 = (_MinIndirectLight).xxx;
				float3 temp_cast_3 = (_MaxIndirectLight).xxx;
				float3 clampResult1119 = clamp( (( _UnifyIndirectDiffuseLight )?( localMaxShadeSH91120 ):( gi1112.indirect.diffuse )) , temp_cast_2 , temp_cast_3 );
				float3 temp_output_1091_0 = max( clampResult1100 , clampResult1119 );
				float grayscale1130 = dot(temp_output_1091_0, float3(0.299,0.587,0.114));
				float3 temp_cast_4 = (grayscale1130).xxx;
				float3 lerpResult1129 = lerp( temp_output_1091_0 , temp_cast_4 , _LightColorGrayScale);
				float3 LightColor1133 = lerpResult1129;
				float DiffuseLightFactor1181 = _DiffuseLightFactor;
				float4 lerpResult1147 = lerp( (( _ShadowLerp )?( lerpResult1145 ):( lerpResult993 )) , ( (( _ShadowLerp )?( lerpResult1145 ):( lerpResult993 )) * float4( LightColor1133 , 0.0 ) ) , DiffuseLightFactor1181);
				float GlobalLightFactor1182 = _GlobalLightFactor;
				float4 lerpResult1158 = lerp( lerpResult1147 , ( lerpResult1147 * float4( LightColor1133 , 0.0 ) ) , GlobalLightFactor1182);
				float4 blend_diff954 = lerpResult1158;
				float2 uv_DirtTex = i.ase_texcoord1.xy * _DirtTex_ST.xy + _DirtTex_ST.zw;
				float4 dirt620 = tex2D( _DirtTex, uv_DirtTex );
				float4 break582 = ( dirt620 * _DirtScale );
				float DirtPower590 = ( ( _DirtRateR * break582.r ) + ( _DirtRateG * break582.g ) + ( break582.b * _DirtRateB ) );
				float4 lerpResult597 = lerp( blend_diff954 , _GlobalDirtColor , DirtPower590);
				float4 dirted_diff601 = lerpResult597;
				float dotResult614 = dot( _UnsaturationColor , dirted_diff601 );
				float4 temp_cast_7 = (dotResult614).xxxx;
				float4 lerpResult616 = lerp( temp_cast_7 , dirted_diff601 , _Saturation);
				float4 output_diff618 = lerpResult616;
				float2 uv_MaskTex = i.ase_texcoord1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float4 Alpha963 = tex2D( _MaskTex, uv_MaskTex );
				float4 temp_output_1172_0 = ( Alpha963 * _CheekStrength );
				float4 screenPos = i.ase_texcoord7;
				float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( screenPos );
				float4 screenColor1163 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,ase_grabScreenPos.xy/ase_grabScreenPos.w);
				
				
				outColor = ( saturate( ( output_diff618 * temp_output_1172_0 ) ) + saturate( ( ( 1.0 - temp_output_1172_0 ) * screenColor1163 ) ) ).rgb;
				outAlpha = 1;
				return float4(outColor,outAlpha);
			}
			ENDCG
		}
		
		GrabPass{ }

		Pass
		{
			Name "ForwardAdd"
			Tags { "LightMode"="ForwardAdd" }
			ZWrite Off
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			BlendOp Max, Max
			AlphaToMask Off
			Cull Back
			ColorMask RGBA
			Stencil
			{
				Ref [_StencilReference]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComparison]
				Pass [_StencilPassFront]
				Fail [_StencilFailFront]
				ZFail [_StencilZFailFront]
			}
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
			#else
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
			#endif

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdadd_fullshadows
			#ifndef UNITY_PASS_FORWARDADD
			#define UNITY_PASS_FORWARDADD
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_SHADOWS 1

			//This is a late directive
			
			uniform float _StencilZFailFront;
			uniform float _StencilFailFront;
			uniform float _StencilComparison;
			uniform float _StencilPassFront;
			uniform float _StencilWriteMask;
			uniform float _StencilReadMask;
			uniform float _StencilReference;
			uniform float _CullMode;
			uniform float4 _UnsaturationColor;
			uniform float _ShadowLerp;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float4 _CustomCheekColor;
			uniform float _CustomCheekColorRate;
			uniform float4 _ShadowColor;
			uniform float _ShadowStep;
			uniform float _ReceiveShadowLerp;
			uniform float _ShadowFeather1;
			uniform float _NoShadowinDirectionalLightColor;
			uniform float _MinDirectLight;
			uniform float _ShadowinLightColor;
			uniform float _MaxDirectLight;
			uniform float _UnifyIndirectDiffuseLight;
			uniform float _MinIndirectLight;
			uniform float _MaxIndirectLight;
			uniform float _LightColorGrayScale;
			uniform float _DiffuseLightFactor;
			uniform float _GlobalLightFactor;
			uniform float4 _GlobalDirtColor;
			uniform float _DirtRateR;
			uniform sampler2D _DirtTex;
			uniform float4 _DirtTex_ST;
			uniform float _DirtScale;
			uniform float _DirtRateG;
			uniform float _DirtRateB;
			uniform float _Saturation;
			uniform sampler2D _MaskTex;
			uniform float4 _MaskTex_ST;
			uniform float _CheekStrength;
			ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
			float PureLightAttenuation( float3 worldPos )
			{
				#ifdef POINT
				        unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz; \
				        return tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r;
				#endif
				#ifdef SPOT
				#if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1))
				#else
				#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = input._LightCoord
				#endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz);
				#endif
				#ifdef DIRECTIONAL
				        return 1;
				#endif
				#ifdef POINT_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w;
				#endif
				#ifdef DIRECTIONAL_COOKIE
				#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xy
				#   else
				#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = input._LightCoord
				#   endif
				        DECLARE_LIGHT_COORD(input, worldPos); \
				        return tex2D(_LightTexture0, lightCoord).w;
				#endif
			}
			
			inline float4 ASE_ComputeGrabScreenPos( float4 pos )
			{
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				float4 o = pos;
				o.y = pos.w * 0.5f;
				o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
				return o;
			}
			


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
			};
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_SHADOW_COORDS(4)
				float4 ase_lmap : TEXCOORD5;
				float4 ase_sh : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
			};
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				
				float3 ase_worldPos = mul(unity_ObjectToWorld, float4( (v.vertex).xyz, 1 )).xyz;
				o.ase_texcoord2.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				#ifdef DYNAMICLIGHTMAP_ON //dynlm
				o.ase_lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif //dynlm
				#ifdef LIGHTMAP_ON //stalm
				o.ase_lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif //stalm
				#ifndef LIGHTMAP_ON //nstalm
				#if UNITY_SHOULD_SAMPLE_SH //sh
				o.ase_sh.xyz = 0;
				#ifdef VERTEXLIGHT_ON //vl
				o.ase_sh.xyz += Shade4PointLights (
				unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
				unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
				unity_4LightAtten0, ase_worldPos, ase_worldNormal);
				#endif //vl
				o.ase_sh.xyz = ShadeSHPerVertex (ase_worldNormal, o.ase_sh.xyz);
				#endif //sh
				#endif //nstalm
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord7 = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_sh.w = 0;
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.pos = UnityObjectToClipPos(v.vertex);
				#if ASE_SHADOWS
					#if UNITY_VERSION >= 560
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#else
						TRANSFER_SHADOW( o );
					#endif
				#endif
				return o;
			}
			
			float4 frag (v2f i ) : SV_Target
			{
				float3 outColor;
				float outAlpha;

				float2 uv_MainTex = i.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 color345 = tex2D( _MainTex, uv_MainTex );
				float4 lerpResult993 = lerp( color345 , _CustomCheekColor , _CustomCheekColorRate);
				float localIsThereALight1110 = ( any(_WorldSpaceLightPos0.xyz) );
				float3 ase_worldPos = i.ase_texcoord2.xyz;
				float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				float3 localDefaultLightDir1111 = ( normalize(UNITY_MATRIX_V[2].xyz + UNITY_MATRIX_V[1].xyz) );
				float3 LightDir1096 = ( localIsThereALight1110 == 1.0 ? worldSpaceLightDir : localDefaultLightDir1111 );
				float3 ase_worldNormal = i.ase_texcoord3.xyz;
				float dotResult1084 = dot( LightDir1096 , ase_worldNormal );
				float HalfLambertTerm1132 = (dotResult1084*0.5 + 0.5);
				float localIsThereALight1186 = ( any(_WorldSpaceLightPos0.xyz) );
				UNITY_LIGHT_ATTENUATION(ase_atten, i, ase_worldPos)
				float HalfShadowAttenuation1128 = ( localIsThereALight1186 == 1.0 ? (saturate( ase_atten )*0.5 + 0.5) : 1.0 );
				float shad_lerp1134 = saturate( ( ( _ShadowStep - (( _ReceiveShadowLerp )?( ( HalfLambertTerm1132 * HalfShadowAttenuation1128 ) ):( HalfLambertTerm1132 )) ) / _ShadowFeather1 ) );
				float4 lerpResult1145 = lerp( lerpResult993 , ( lerpResult993 * _ShadowColor ) , shad_lerp1134);
				#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				float4 ase_lightColor = 0;
				#else //aselc
				float4 ase_lightColor = _LightColor0;
				#endif //aselc
				float3 temp_cast_0 = (_MinDirectLight).xxx;
				float3 clampResult1184 = clamp( ase_lightColor.rgb , temp_cast_0 , float3( 2,2,2 ) );
				float3 worldPos1107 = ase_worldPos;
				float localPureLightAttenuation1107 = PureLightAttenuation( worldPos1107 );
				float3 temp_output_1103_0 = ( clampResult1184 * (( _ShadowinLightColor )?( ase_atten ):( localPureLightAttenuation1107 )) );
				#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch1104 = temp_output_1103_0;
				#else
				float3 staticSwitch1104 = clampResult1184;
				#endif
				float3 temp_cast_1 = (_MaxDirectLight).xxx;
				float3 clampResult1100 = clamp( (( _NoShadowinDirectionalLightColor )?( staticSwitch1104 ):( temp_output_1103_0 )) , float3( 0,0,0 ) , temp_cast_1 );
				UnityGIInput data1112;
				UNITY_INITIALIZE_OUTPUT( UnityGIInput, data1112 );
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON) //dylm1112
				data1112.lightmapUV = i.ase_lmap;
				#endif //dylm1112
				#if UNITY_SHOULD_SAMPLE_SH //fsh1112
				data1112.ambient = i.ase_sh;
				#endif //fsh1112
				UnityGI gi1112 = UnityGI_Base(data1112, 1, ase_worldNormal);
				float3 localMaxShadeSH91120 = ( max(ShadeSH9(half4(0, 0, 0, 1)).rgb, ShadeSH9(half4(0, -1, 0, 1)).rgb) );
				float3 temp_cast_2 = (_MinIndirectLight).xxx;
				float3 temp_cast_3 = (_MaxIndirectLight).xxx;
				float3 clampResult1119 = clamp( (( _UnifyIndirectDiffuseLight )?( localMaxShadeSH91120 ):( gi1112.indirect.diffuse )) , temp_cast_2 , temp_cast_3 );
				float3 temp_output_1091_0 = max( clampResult1100 , clampResult1119 );
				float grayscale1130 = dot(temp_output_1091_0, float3(0.299,0.587,0.114));
				float3 temp_cast_4 = (grayscale1130).xxx;
				float3 lerpResult1129 = lerp( temp_output_1091_0 , temp_cast_4 , _LightColorGrayScale);
				float3 LightColor1133 = lerpResult1129;
				float DiffuseLightFactor1181 = _DiffuseLightFactor;
				float4 lerpResult1147 = lerp( (( _ShadowLerp )?( lerpResult1145 ):( lerpResult993 )) , ( (( _ShadowLerp )?( lerpResult1145 ):( lerpResult993 )) * float4( LightColor1133 , 0.0 ) ) , DiffuseLightFactor1181);
				float GlobalLightFactor1182 = _GlobalLightFactor;
				float4 lerpResult1158 = lerp( lerpResult1147 , ( lerpResult1147 * float4( LightColor1133 , 0.0 ) ) , GlobalLightFactor1182);
				float4 blend_diff954 = lerpResult1158;
				float2 uv_DirtTex = i.ase_texcoord1.xy * _DirtTex_ST.xy + _DirtTex_ST.zw;
				float4 dirt620 = tex2D( _DirtTex, uv_DirtTex );
				float4 break582 = ( dirt620 * _DirtScale );
				float DirtPower590 = ( ( _DirtRateR * break582.r ) + ( _DirtRateG * break582.g ) + ( break582.b * _DirtRateB ) );
				float4 lerpResult597 = lerp( blend_diff954 , _GlobalDirtColor , DirtPower590);
				float4 dirted_diff601 = lerpResult597;
				float dotResult614 = dot( _UnsaturationColor , dirted_diff601 );
				float4 temp_cast_7 = (dotResult614).xxxx;
				float4 lerpResult616 = lerp( temp_cast_7 , dirted_diff601 , _Saturation);
				float4 output_diff618 = lerpResult616;
				float2 uv_MaskTex = i.ase_texcoord1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float4 Alpha963 = tex2D( _MaskTex, uv_MaskTex );
				float4 temp_output_1172_0 = ( Alpha963 * _CheekStrength );
				float4 screenPos = i.ase_texcoord7;
				float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( screenPos );
				float4 screenColor1163 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,ase_grabScreenPos.xy/ase_grabScreenPos.w);
				
				
				outColor = ( saturate( ( output_diff618 * temp_output_1172_0 ) ) + saturate( ( ( 1.0 - temp_output_1172_0 ) * screenColor1163 ) ) ).rgb;
				outAlpha = 1;
				return float4(outColor,outAlpha);
			}
			ENDCG
		}

	
	}
	CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.CommentaryNode;1178;-2976.842,373.3504;Inherit;False;1905.078;761.4236;;27;941;993;991;992;1134;1135;1136;1138;1140;1141;1142;1139;1137;1156;1144;1072;1146;1177;1145;954;1149;1147;1150;1157;1158;1148;1183;Main Blend;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1176;-3852.502,414.6555;Inherit;False;584.5752;685.3966;;6;345;620;979;401;64;963;Texture Input;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1175;-978.7212,864.5873;Inherit;False;1183.341;466.6177;;12;890;1162;1164;1165;1166;1167;1168;1169;1172;1173;957;1163;Alpha Blend;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;978;-976.1549,364.8016;Inherit;False;881.8474;439.0491;;6;614;615;617;605;616;618;Saturation;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;943;-1226.731,1398.106;Inherit;False;1448.861;774.5951;;17;580;582;587;588;586;583;585;589;621;584;597;598;599;601;595;579;590;Dirt Process;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;870;355.7067,1443.453;Inherit;False;356.8159;717.053;;7;869;865;864;868;866;867;863;Stencil;1,1,1,1;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;891;596.1736,1245.273;Float;False;False;-1;2;ASEMaterialInspector;100;12;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;ShadowCaster;0;4;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;887;655.7147,2366.687;Float;False;False;-1;2;ASEMaterialInspector;100;12;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;580;-885.1465,1629.046;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;582;-741.1465,1627.046;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;587;-304.623,1623.106;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;588;-386.623,1751.107;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;586;-401.623,1455.106;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;583;-684.6234,1448.106;Inherit;False;Property;_DirtRateR;DirtRateR;15;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;585;-664.6232,1802.107;Inherit;False;Property;_DirtRateB;DirtRateB;17;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;589;-134.6227,1602.106;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;584;-578.623,1609.106;Inherit;False;Property;_DirtRateG;DirtRateG;16;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;597;-429.6741,1944.281;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;579;-1176.732,1729.644;Inherit;False;Property;_DirtScale;DirtScale;14;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;621;-1085.132,1628.284;Inherit;False;620;dirt;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;889;255.2894,1082.278;Float;False;False;-1;2;ASEMaterialInspector;100;12;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;ForwardAdd;0;2;ForwardAdd;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;True;True;2;5;False;;10;False;;2;5;False;;10;False;;True;5;False;;5;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;True;True;True;0;True;_StencilReference;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComparison;0;True;_StencilPassFront;0;True;_StencilFailFront;0;True;_StencilZFailFront;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;598;-611.9752,1903.883;Inherit;False;954;blend_diff;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;599;-601.7682,2043.682;Inherit;False;590;DirtPower;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;614;-625.6831,461.6985;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;605;-858.3099,597.0091;Inherit;False;601;dirted_diff;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;616;-493.1329,536.4902;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;618;-318.3082,534.4692;Inherit;False;output_diff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;617;-926.1551,687.8508;Inherit;False;Property;_Saturation;Saturation;18;1;[Header];Create;True;1;Saturation;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;986;403.2294,2332.833;Inherit;False;225;166;;1;987;Cull;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;615;-886.1813,414.8007;Inherit;False;Property;_UnsaturationColor;UnsaturationColor;19;1;[HDR];Create;True;0;0;0;False;0;False;0.2117647,0.7137255,0.07058824,0;0.2117647,0.7137255,0.07058824,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;595;-825.0815,1958.687;Inherit;False;Property;_GlobalDirtColor;GlobalDirtColor;13;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;590;21.04446,1595.087;Inherit;False;DirtPower;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;601;-253.2362,1944.618;Inherit;False;dirted_diff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;869;442.1517,2044.511;Inherit;False;Property;_StencilZFailFront;Stencil ZFailFront;34;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;868;443.1732,1955.624;Inherit;False;Property;_StencilFailFront;Stencil FailFront;33;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;865;440.8616,1769.399;Inherit;False;Property;_StencilComparison;Stencil Comparison;31;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;864;442.9049,1863.465;Inherit;False;Property;_StencilPassFront;Stencil PassFront;32;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.StencilOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;866;412.5234,1671.591;Inherit;False;Property;_StencilWriteMask;Stencil WriteMask;30;0;Create;True;0;0;0;True;0;False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;867;407.4136,1582.704;Inherit;False;Property;_StencilReadMask;Stencil ReadMask;29;0;Create;True;0;0;0;True;0;False;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;863;405.7073,1493.454;Inherit;False;Property;_StencilReference;Stencil Reference;28;1;[Header];Create;True;1;Stencil Buffer;0;0;True;0;False;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;987;453.2294,2382.833;Inherit;False;Property;_CullMode;Cull Mode;35;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1082;-4156.767,1299.75;Inherit;False;2832.956;1061.392;;42;1133;1132;1131;1130;1129;1128;1127;1126;1125;1124;1123;1120;1119;1118;1114;1113;1112;1111;1110;1109;1108;1107;1106;1105;1104;1103;1102;1101;1100;1099;1098;1097;1096;1094;1091;1086;1085;1084;1083;1184;1185;1186;Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1086;-4102.745,1473.428;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMaxOpNode;1091;-2024.571,1636.688;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1096;-3553.392,1422.876;Inherit;False;LightDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1103;-2781.785,1571.438;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1104;-2719.968,1396.458;Inherit;False;Property;_Keyword1;Keyword 0;6;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDADD;Toggle;2;Key0;Key1;Fetch;False;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1108;-2433.562,1427.967;Inherit;False;Property;_NoShadowinDirectionalLightColor;NoShadow in DirectionalLightColor;11;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;1111;-3877.548,1542.493;Inherit;False;normalize(UNITY_MATRIX_V[2].xyz + UNITY_MATRIX_V[1].xyz);3;Create;0;Default LightDir;False;False;0;;False;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;-2564.414,2146.404;Inherit;False;Property;_MaxIndirectLight;MaxIndirectLight;24;0;Create;True;0;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1119;-2268.494,1983.818;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1129;-1697.754,1639.304;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCGrayscale;1130;-1898.848,1703.071;Inherit;False;1;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1131;-1957.594,1782.121;Inherit;False;Property;_LightColorGrayScale;LightColor GrayScale;25;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1133;-1547.812,1633.188;Inherit;False;LightColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;-2441.479,1578.482;Inherit;False;Property;_MaxDirectLight;MaxDirectLight;21;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;890;154.6199,1047.492;Float;False;False;-1;2;ASEMaterialInspector;100;12;New Amplify Shader;fe4af87006695164d84819765fe282b7;True;Deferred;0;3;Deferred;4;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Deferred;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;1162;-696.1242,914.5873;Inherit;False;618;output_diff;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;1164;-494.9521,1039.595;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1165;-347.807,1039.379;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1166;-418.8995,925.8593;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1167;-211.8603,1035.567;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1168;-210.7134,943.8344;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1169;-63.43624,968.6703;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1172;-634.6087,998.9084;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1173;-823.748,997.6415;Inherit;False;963;Alpha;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;957;-928.7212,1092.805;Inherit;False;Property;_CheekStrength;CheekStrength;1;0;Create;True;0;0;0;False;0;False;10;1;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;1163;-615.6195,1119.205;Inherit;False;Global;_GrabScreen0;Grab Screen 0;68;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;888;255.2894,972.2784;Float;False;True;-1;2;ASEMaterialInspector;100;12;LCCGshader/Cheek;fe4af87006695164d84819765fe282b7;True;ForwardBase;0;1;ForwardBase;3;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;RenderType=Transparent=RenderType;Queue=AlphaTest=Queue=0;True;2;False;0;True;True;0;5;False;;10;False;;0;5;False;;10;False;;True;5;False;;5;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_CullMode;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;True;True;True;0;True;_StencilReference;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComparison;0;True;_StencilPassFront;0;True;_StencilFailFront;0;True;_StencilZFailFront;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;True;2;False;0;;0;0;Standard;0;0;5;False;True;True;False;False;False;;False;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;-3506.338,669.6292;Inherit;False;color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;-3491.926,869.3972;Inherit;False;dirt;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;979;-3800.995,667.4216;Inherit;True;Property;_MainTex;Color Map (_cheek_C);3;0;Create;False;1;Diffuse;0;0;False;0;False;-1;None;None;True;0;False;red;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;401;-3795.476,870.0521;Inherit;True;Property;_DirtTex;DirtTex;12;1;[Header];Create;True;1;Dirt;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;64;-3802.501,464.6555;Inherit;True;Property;_MaskTex;CheekMaskMap (_cheek_A);0;1;[Header];Create;False;1;Diffuse;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;963;-3508.069,465.3428;Inherit;False;Alpha;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;941;-2814.669,713.3723;Inherit;False;345;color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;993;-2627.831,781.0442;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;991;-2852.311,795.7521;Inherit;False;Property;_CustomCheekColor;CustomCheekColor;4;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;992;-2926.842,972.2414;Inherit;False;Property;_CustomCheekColorRate;CustomCheekColorRate;5;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1134;-1805.042,452.5144;Inherit;False;shad_lerp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1135;-1940.402,454.6956;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1136;-2053.671,452.8006;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1138;-2496.813,423.3504;Inherit;False;Property;_ShadowStep;ShadowStep;7;0;Create;True;0;0;0;False;0;False;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1140;-2602.144,585.5449;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1141;-2840.936,514.3016;Inherit;False;1132;HalfLambertTerm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1142;-2861.415,613.0655;Inherit;False;1128;HalfShadowAttenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1139;-2440.245,517.0455;Inherit;False;Property;_ReceiveShadowLerp;ReceiveShadowLerp;9;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1137;-2200.414,446.8504;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1156;-2402.483,629.5006;Inherit;False;Property;_ShadowFeather1;ShadowFeather;8;0;Create;True;0;0;0;False;0;False;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1144;-2633.466,922.7737;Inherit;False;Property;_ShadowColor;ShadowColor;6;0;Create;True;0;0;0;False;0;False;0.7,0.7,0.7,0;0.7,0.7,0.7,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1072;-2427.389,882.6786;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1146;-2431.356,979.6987;Inherit;False;1134;shad_lerp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1177;-2129.072,742.463;Inherit;False;Property;_ShadowLerp;ShadowLerp;2;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1145;-2278.416,823.668;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;954;-1295.763,757.1037;Inherit;False;blend_diff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1149;-1924.255,815.8792;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1147;-1765.535,752.3109;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1157;-1610.696,817.569;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1158;-1450.977,760.0006;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1148;-2089.332,875.1555;Inherit;False;1133;LightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1179;-1823.874,2183.229;Inherit;False;Property;_DiffuseLightFactor;DiffuseLightFactor;26;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1180;-1821.499,2266.08;Inherit;False;Property;_GlobalLightFactor;GlobalLightFactor;27;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1181;-1551.609,2182.164;Inherit;False;DiffuseLightFactor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1182;-1548.499,2269.08;Inherit;False;GlobalLightFactor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1183;-1655.9,919.0062;Inherit;False;1182;GlobalLightFactor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1150;-2009.048,951.5798;Inherit;False;1181;DiffuseLightFactor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1094;-3299.03,1513.828;Inherit;False;Property;_MinDirectLight;MinDirectLight;20;1;[Header];Create;True;1;Light;0;0;False;0;False;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;1123;-3180.075,1386.001;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;1100;-2146.834,1502.097;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;1184;-2978.508,1440.919;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;2,2,2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1101;-3399.35,1642.151;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightAttenuation;1102;-3223.668,1709.388;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1105;-3016.19,1711.431;Inherit;False;Property;_ShadowinLightColor;Shadow in LightColor;10;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1106;-2998.839,1620.931;Inherit;False;RimAtten;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1107;-3227.636,1624.677;Inherit;False;#ifdef POINT$        unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz@ \$        return tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r@$#endif$$#ifdef SPOT$#if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)$#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1))$#else$#define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord4 lightCoord = input._LightCoord$#endif$        DECLARE_LIGHT_COORD(input, worldPos)@ \$        return (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz)@$#endif$$#ifdef DIRECTIONAL$        return 1@$#endif$$#ifdef POINT_COOKIE$#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz$#   else$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord3 lightCoord = input._LightCoord$#   endif$        DECLARE_LIGHT_COORD(input, worldPos)@ \$        return tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w@$#endif$$#ifdef DIRECTIONAL_COOKIE$#   if !defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS)$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xy$#   else$#       define DECLARE_LIGHT_COORD(input, worldPos) unityShadowCoord2 lightCoord = input._LightCoord$#   endif$        DECLARE_LIGHT_COORD(input, worldPos)@ \$        return tex2D(_LightTexture0, lightCoord).w@$#endif;1;Create;1;True;worldPos;FLOAT3;0,0,0;In;;Inherit;False;Pure Light Attenuation;False;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1114;-2572.304,2058.673;Inherit;False;Property;_MinIndirectLight;MinIndirectLight;23;0;Create;True;0;0;0;False;0;False;0.1;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;1112;-2795.907,1921.059;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1113;-2574.435,1947.542;Inherit;False;Property;_UnifyIndirectDiffuseLight;Unify IndirectDiffuseLight;22;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;1120;-2739.949,2001.441;Inherit;False;max(ShadeSH9(half4(0, 0, 0, 1)).rgb, ShadeSH9(half4(0, -1, 0, 1)).rgb);3;Create;0;MaxShadeSH9;False;False;0;;False;0;1;FLOAT3;0
Node;AmplifyShaderEditor.Compare;1085;-3721.426,1423.535;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;1110;-3881.354,1416.876;Inherit;False;any(_WorldSpaceLightPos0.xyz);1;Create;0;Is There A Light;False;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1083;-4070.688,1883.987;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;1084;-3845.648,1834.025;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1097;-3885.906,1949.474;Float;False;Constant;_RemapValue1;Remap Value;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;1098;-3718.319,1858.242;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1099;-4055.187,1791.563;Inherit;False;1096;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1132;-3516.593,1857.943;Inherit;False;HalfLambertTerm;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1124;-3924.522,2108.604;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;1125;-3787.825,2139.657;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1126;-3944.412,2187.889;Float;False;Constant;_RemapValue3;Remap Value;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1127;-4118.466,2103.687;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1186;-3740.388,2054.155;Inherit;False;any(_WorldSpaceLightPos0.xyz);1;Create;0;Is There A Light;False;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1185;-3580.56,2084.014;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1128;-3419.151,2083.833;Inherit;False;HalfShadowAttenuation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
WireConnection;580;0;621;0
WireConnection;580;1;579;0
WireConnection;582;0;580;0
WireConnection;587;0;584;0
WireConnection;587;1;582;1
WireConnection;588;0;582;2
WireConnection;588;1;585;0
WireConnection;586;0;583;0
WireConnection;586;1;582;0
WireConnection;589;0;586;0
WireConnection;589;1;587;0
WireConnection;589;2;588;0
WireConnection;597;0;598;0
WireConnection;597;1;595;0
WireConnection;597;2;599;0
WireConnection;614;0;615;0
WireConnection;614;1;605;0
WireConnection;616;0;614;0
WireConnection;616;1;605;0
WireConnection;616;2;617;0
WireConnection;618;0;616;0
WireConnection;590;0;589;0
WireConnection;601;0;597;0
WireConnection;1091;0;1100;0
WireConnection;1091;1;1119;0
WireConnection;1096;0;1085;0
WireConnection;1103;0;1184;0
WireConnection;1103;1;1105;0
WireConnection;1104;1;1184;0
WireConnection;1104;0;1103;0
WireConnection;1108;0;1103;0
WireConnection;1108;1;1104;0
WireConnection;1119;0;1113;0
WireConnection;1119;1;1114;0
WireConnection;1119;2;1118;0
WireConnection;1129;0;1091;0
WireConnection;1129;1;1130;0
WireConnection;1129;2;1131;0
WireConnection;1130;0;1091;0
WireConnection;1133;0;1129;0
WireConnection;1164;0;1172;0
WireConnection;1165;0;1164;0
WireConnection;1165;1;1163;0
WireConnection;1166;0;1162;0
WireConnection;1166;1;1172;0
WireConnection;1167;0;1165;0
WireConnection;1168;0;1166;0
WireConnection;1169;0;1168;0
WireConnection;1169;1;1167;0
WireConnection;1172;0;1173;0
WireConnection;1172;1;957;0
WireConnection;888;0;1169;0
WireConnection;345;0;979;0
WireConnection;620;0;401;0
WireConnection;963;0;64;0
WireConnection;993;0;941;0
WireConnection;993;1;991;0
WireConnection;993;2;992;0
WireConnection;1134;0;1135;0
WireConnection;1135;0;1136;0
WireConnection;1136;0;1137;0
WireConnection;1136;1;1156;0
WireConnection;1140;0;1141;0
WireConnection;1140;1;1142;0
WireConnection;1139;0;1141;0
WireConnection;1139;1;1140;0
WireConnection;1137;0;1138;0
WireConnection;1137;1;1139;0
WireConnection;1072;0;993;0
WireConnection;1072;1;1144;0
WireConnection;1177;0;993;0
WireConnection;1177;1;1145;0
WireConnection;1145;0;993;0
WireConnection;1145;1;1072;0
WireConnection;1145;2;1146;0
WireConnection;954;0;1158;0
WireConnection;1149;0;1177;0
WireConnection;1149;1;1148;0
WireConnection;1147;0;1177;0
WireConnection;1147;1;1149;0
WireConnection;1147;2;1150;0
WireConnection;1157;0;1147;0
WireConnection;1157;1;1148;0
WireConnection;1158;0;1147;0
WireConnection;1158;1;1157;0
WireConnection;1158;2;1183;0
WireConnection;1181;0;1179;0
WireConnection;1182;0;1180;0
WireConnection;1100;0;1108;0
WireConnection;1100;2;1109;0
WireConnection;1184;0;1123;1
WireConnection;1184;1;1094;0
WireConnection;1105;0;1107;0
WireConnection;1105;1;1102;0
WireConnection;1106;0;1107;0
WireConnection;1107;0;1101;0
WireConnection;1113;0;1112;0
WireConnection;1113;1;1120;0
WireConnection;1085;0;1110;0
WireConnection;1085;2;1086;0
WireConnection;1085;3;1111;0
WireConnection;1084;0;1099;0
WireConnection;1084;1;1083;0
WireConnection;1098;0;1084;0
WireConnection;1098;1;1097;0
WireConnection;1098;2;1097;0
WireConnection;1132;0;1098;0
WireConnection;1124;0;1127;0
WireConnection;1125;0;1124;0
WireConnection;1125;1;1126;0
WireConnection;1125;2;1126;0
WireConnection;1185;0;1186;0
WireConnection;1185;2;1125;0
WireConnection;1128;0;1185;0
ASEEND*/
//CHKSM=AE109C1A9A00F866B3B083656B942EA20E9FB777