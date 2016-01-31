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

uniform sampler2D u_normal; // RGB = NORMAL
uniform sampler2D u_specular; // R = SPECULAR STRENGTH, GB = UNUSED
uniform vec3 u_light_pos; // WORLD SPACE LIGHT POSITION

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
    // OUTPUT RESULT //
    gl_FragColor = vec4(lightcol.rgb * intensity, spec * pow(dot(lightcol.rgb, vec3(0.299, 0.587, 0.114)), 0.5));
}
