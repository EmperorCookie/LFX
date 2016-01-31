//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4(in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_light;
uniform sampler2D u_emissive;
uniform sampler2D u_specular;
uniform vec2 u_texel;
uniform float u_radius;

const float ANGLES = 16.0;
const float LOOKUPS = 4.0;
const float TAU = 6.28318530718;

void main() {
    vec4 basecol = texture2D(gm_BaseTexture, v_vTexcoord);
    // EMISSIVE BLUR //
    vec4 emiscol = texture2D(u_emissive, v_vTexcoord);
    float segment = u_radius / LOOKUPS;
    float angle = TAU / ANGLES;
    vec4 emisblur = vec4(0.0);
    for(float dir = 0.0; dir < TAU; dir += angle) {
        for(float dist = 1.0; dist <= LOOKUPS; dist += 1.0) {
             emisblur += texture2D(u_emissive, v_vTexcoord + vec2(cos(dir), sin(dir)) * u_texel * dist * segment);
        }
    }
    emisblur /= LOOKUPS * ANGLES + 1.0;
    vec4 lightcol = texture2D(u_light, v_vTexcoord);
    vec4 light = clamp(lightcol + emisblur, vec4(0.0), vec4(1.0));
    vec4 spec = texture2D(u_specular, v_vTexcoord);
    gl_FragColor = clamp(vec4(basecol.rgb * light.rgb + emiscol.rgb + emisblur.rgb * 0.5 + lightcol.rgb * spec.rgb * lightcol.a, 1.0), vec4(0.0), vec4(1.0));
}
