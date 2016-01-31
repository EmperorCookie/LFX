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

uniform sampler2D u_specular; // R = SPECULAR STRENGTH, GB = UNUSED
uniform vec3 u_position; // WORLD SPACE LIGHT POSITION

vec2 normal_rotate(vec2 v, float ang) {
    return vec2(v.x * cos(ang) - v.y * sin(ang), v.x * sin(ang) + v.y * cos(ang));
}

void main() {
    // FETCH NORMAL //
    vec3 norm = normalize(texture2D(gm_BaseTexture, v_vTexcoord).rgb * 2.0 - 1.0);
    // NORMALIZE POSITION //
    vec3 pos = normalize(u_position);
    // CALCULATE INTENSITY //
    float intensity = max(dot(norm, pos), 0.0);
    // CALCULATE SPECULAR //
    vec4 speccol = texture2D(u_specular, v_vTexcoord);
    vec3 bounce = reflect(pos, norm);
    vec3 camdir = vec3(0.0, 0.0, -1.0);
    float spec = pow(max(dot(bounce, camdir), 0.0), 16.0) * speccol.r;
    // FINAL RESULT //
    gl_FragColor = vec4(v_vColour.rgb * intensity, spec * pow(dot(v_vColour.rgb, vec3(0.299, 0.587, 0.114)), 0.5));
}
