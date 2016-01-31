struct a2v { //in from attributes to vertex
    float4 Position : POSITION;
    float4 Color    : COLOR0;
    float2 Texcoord : TEXCOORD0;
};
  
struct v2p { //out from vertex to pixel
    float4 Position      : POSITION;
    float4 Color         : COLOR0;
    float2 Texcoord      : TEXCOORD0;
};

void main(in a2v IN, out v2p OUT)
{
    OUT.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], IN.Position); 
    
    OUT.Color = IN.Color;
    OUT.Texcoord = IN.Texcoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~struct v2p { //in from vertex to pixel
    float4 Color        : COLOR0;
    float2 Texcoord     : TEXCOORD0;
};

struct p2s { //out from pixel to screen
    float4 Color0    : COLOR0; // DIFFUSE RGB
    float4 Color1    : COLOR1; // NORMAL RGB
    float4 Color2    : COLOR2; // EMISSIVE RGB
    float4 Color3    : COLOR3; // SPECULAR R, GB UNUSED
};

uniform sampler2D u_normal_map;
uniform sampler2D u_emissive_map;
uniform sampler2D u_specular_map;
uniform float4 u_uvs;
uniform float4 u_normal_uvs;
uniform float4 u_specular_uvs;
uniform float4 u_emissive_uvs;
uniform float3 u_emissive_blend;
uniform float u_angle;

float2 normal_rotate(float2 v, float ang) {
    return float2(v.x * cos(ang) - v.y * sin(ang), v.x * sin(ang) + v.y * cos(ang));
}

void main(in v2p IN, out p2s OUT) {
    // COMPUTE A MULTIPLIER TO MAKE AN OUTPUT BLACK IF NO MAP HAS BEEN SUPPLIED
    float has_norm = sign(u_normal_uvs.x + u_normal_uvs.y + u_normal_uvs.z + u_normal_uvs.w);
    float has_spec = sign(u_specular_uvs.x + u_specular_uvs.y + u_specular_uvs.z + u_specular_uvs.w);
    float has_emis = sign(u_emissive_uvs.x + u_emissive_uvs.y + u_emissive_uvs.z + u_emissive_uvs.w);
    // IF YOU MUST MODIFY THE UV COORDS, DO SO HERE BEFORE THE OTHER COORDINATES ARE CALCULATED //
    
    // COMPUTE THE COORDINATES TO ACCOUNT FOR TEXTURE PAGES //
    float2 abs_coord = (IN.Texcoord - u_uvs.xy) / (u_uvs.zw - u_uvs.xy);
    float2 norm_coord = u_normal_uvs.xy + abs_coord * (u_normal_uvs.zw - u_normal_uvs.xy);
    float2 spec_coord = u_specular_uvs.xy + abs_coord * (u_specular_uvs.zw - u_specular_uvs.xy);
    float2 emis_coord = u_emissive_uvs.xy + abs_coord * (u_emissive_uvs.zw - u_emissive_uvs.xy);
    // OUTPUT 0 IS THE DIFFUSE MAP, INCLUDES TRANSPARENCY //
    float4 diff = tex2D(gm_BaseTexture, IN.Texcoord);
    OUT.Color0 = IN.Color * diff;
    // OUTPUT 1 IS THE NORMAL MAP //
    float4 norm = tex2D(u_normal_map, norm_coord);
    norm.xy = normal_rotate(norm.xy * 2.0 - 1.0, u_angle) * 0.5 + 0.5;
    OUT.Color1 = float4(lerp(float3(0.5, 0.5, 1.0), norm.rgb, has_norm), diff.a * IN.Color.a);
    // OUTPUT 2 IS THE EMISSIVE MAP //
    float4 emis = tex2D(u_emissive_map, emis_coord);
    OUT.Color2 = float4(lerp(u_emissive_blend, u_emissive_blend * emis.rgb, has_emis), diff.a * IN.Color.a);
    // OUTPUT 3 IS THE SPECULAR MAP //
    OUT.Color3 = float4(tex2D(u_specular_map, spec_coord).rgb * has_spec, diff.a * IN.Color.a);
}
