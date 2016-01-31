//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vPosition;
varying vec4 v_vPositionWorld;

void main()
{
    vec4 object_space_pos = vec4(in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vPosition = (gl_Position + gl_Position.w) * 0.5;
    v_vPositionWorld = object_space_pos;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vPosition;
varying vec4 v_vPositionWorld;

const int MAXCASTERS = 50;

uniform sampler2D u_normal; // RGB = NORMAL
uniform sampler2D u_specular; // R = SPECULAR STRENGTH, GB = UNUSED
uniform vec3 u_light_pos; // WORLD SPACE LIGHT POSITION
uniform float u_do_shadows; // WHETHER A CERTAIN LIGHT SHOULD RENDER SHADOWS OR NOT
uniform int u_caster_number; // HOW MANY CASTERS
uniform vec4 u_casters[MAXCASTERS]; // SHADOW CASTERS

float linexline(vec4 line1, vec4 line2) {
    vec4 si;
    si.x = (line1.x - line2.x) * (line1.w - line2.y) - (line1.z - line2.x) * (line1.y - line2.y);
    si.y = (line1.x - line2.z) * (line1.w - line2.w) - (line1.z - line2.z) * (line1.y - line2.w);
    si.z = (line2.x - line1.x) * (line2.w - line1.y) - (line2.z - line1.x) * (line2.y - line1.y);
    si.w = (line2.x - line1.z) * (line2.w - line1.w) - (line2.z - line1.z) * (line2.y - line1.w);
    // INVERT THE RESULT TO TURN IT INTO A MULTIPLIER //
    return 1.0 - sign(max(si.x * -si.y, 0.0) * max(si.z * -si.w, 0.0));
}

void main() {
    // CALCULATE SCREEN SPACE //
    vec2 norm_coord = v_vPosition.xy / v_vPosition.w;
    norm_coord.y = 1.0 - norm_coord.y;
    // FETCH NORMAL //
    vec3 norm = normalize(texture2D(u_normal, norm_coord).rgb * 2.0 - 1.0);
    // CALCULATE THE DIRECTION FROM LIGHT TO PIXEL //
    vec3 lightdir = normalize(u_light_pos - v_vPositionWorld.rgb);
    // CALCULATE INTENSITY //
    float intensity = max(dot(norm, lightdir), 0.0);
    // CALCULATE SPECULAR //
    vec4 speccol = texture2D(u_specular, norm_coord);
    vec3 bounce = reflect(lightdir, norm);
    vec3 camdir = vec3(0.0, 0.0, -1.0);
    float spec = pow(max(dot(bounce, camdir), 0.0), 16.0) * speccol.r;
    // FETCH LIGHT SPRITE //
    vec4 lightcol = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    // CALCULATE SHADOW //
    float shadow = 1.0;
    if(u_do_shadows == 1.0) {
        vec4 line = vec4(u_light_pos.xy, v_vPositionWorld.xy);
        for(int i = 0; i < MAXCASTERS; i += 1) {
            if(i >= u_caster_number) {
                break;
            }
            shadow *= linexline(line, u_casters[i]);
        }
    }
    // OUTPUT RESULT //
    gl_FragColor = vec4(lightcol.rgb * intensity, spec * pow(dot(lightcol.rgb, vec3(0.299, 0.587, 0.114)), 0.5)) * vec4(shadow);
}
