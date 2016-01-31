//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_normal_map;
uniform sampler2D u_emissive_map;
uniform sampler2D u_specular_map;
uniform vec4 u_uvs;
uniform vec4 u_normal_uvs;
uniform vec4 u_specular_uvs;
uniform vec4 u_emissive_uvs;
uniform vec3 u_emissive_blend;
uniform float u_angle;

vec2 normal_rotate(vec2 v, float ang) {
    return vec2(v.x * cos(ang) - v.y * sin(ang), v.x * sin(ang) + v.y * cos(ang));
}

void main() {
    // COMPUTE A MULTIPLIER TO MAKE AN OUTPUT BLACK IF NO MAP HAS BEEN SUPPLIED
    float has_norm = sign(u_normal_uvs.x + u_normal_uvs.y + u_normal_uvs.z + u_normal_uvs.w);
    float has_spec = sign(u_specular_uvs.x + u_specular_uvs.y + u_specular_uvs.z + u_specular_uvs.w);
    float has_emis = sign(u_emissive_uvs.x + u_emissive_uvs.y + u_emissive_uvs.z + u_emissive_uvs.w);
    // IF YOU MUST MODIFY THE UV COORDS, DO SO HERE BEFORE THE OTHER COORDINATES ARE CALCULATED //
    
    // COMPUTE THE COORDINATES TO ACCOUNT FOR TEXTURE PAGES //
    vec2 abs_coord = (v_vTexcoord - u_uvs.xy) / (u_uvs.zw - u_uvs.xy);
    vec2 norm_coord = u_normal_uvs.xy + abs_coord * (u_normal_uvs.zw - u_normal_uvs.xy);
    vec2 spec_coord = u_specular_uvs.xy + abs_coord * (u_specular_uvs.zw - u_specular_uvs.xy);
    vec2 emis_coord = u_emissive_uvs.xy + abs_coord * (u_emissive_uvs.zw - u_emissive_uvs.xy);
    // OUTPUT 0 IS THE DIFFUSE MAP, INCLUDES TRANSPARENCY //
    vec4 diffcol = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragData[0] = v_vColour * diffcol;
    // OUTPUT 1 IS THE NORMAL MAP //
    vec4 norm = texture2D(u_normal_map, norm_coord);
    norm.xy = normal_rotate(norm.xy * 2.0 - 1.0, u_angle) * 0.5 + 0.5;
    gl_FragData[1] = vec4(mix(vec3(0.5, 0.5, 1.0), norm.rgb, has_norm), diffcol.a * v_vColour.a);
    // OUTPUT 2 IS THE EMISSIVE MAP //
    vec4 emis = texture2D(u_emissive_map, emis_coord);
    gl_FragData[2] = vec4(mix(u_emissive_blend, u_emissive_blend * emis.rgb, has_emis), diffcol.a * v_vColour.a);
    // OUTPUT 3 IS THE SPECULAR MAP //
    gl_FragData[3] = vec4(texture2D(u_specular_map, spec_coord).rgb * has_spec, diffcol.a * v_vColour.a);
}
