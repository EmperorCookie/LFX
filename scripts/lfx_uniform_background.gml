///lfx_uniform_background(diffuse_background,image_angle,normal_background,specular_background,emissive_background,emissive_blend)
var diff = argument0;
if(!background_exists(diff)) {
    exit;
}
var ang = argument1;
var norm = argument2;
var spec = argument3;
var emis = argument4;
var ic = argument5;
var ir = colour_get_red(ic) / 255;
var ig = colour_get_green(ic) / 255;
var ib = colour_get_blue(ic) / 255;
var uvs;
if(background_exists(norm)) {
    texture_set_stage(LFX_u_normal_map, background_get_texture(norm));
    uvs = background_get_uvs(norm);
    shader_set_uniform_f(LFX_u_normal_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
} else {
    shader_set_uniform_f(LFX_u_normal_uvs, 0, 0, 0, 0);
}
if(background_exists(spec)) {
    texture_set_stage(LFX_u_specular_map, background_get_texture(spec));
    uvs = background_get_uvs(spec);
    shader_set_uniform_f(LFX_u_specular_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
} else {
    shader_set_uniform_f(LFX_u_specular_uvs, 0, 0, 0, 0);
}
if(background_exists(emis)) {
    texture_set_stage(LFX_u_emissive_map, background_get_texture(emis));
    uvs = background_get_uvs(emis);
    shader_set_uniform_f(LFX_u_emissive_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
} else {
    shader_set_uniform_f(LFX_u_emissive_uvs, 0, 0, 0, 0);
}
shader_set_uniform_f(LFX_u_emissive_blend, ir, ig, ib);
uvs = background_get_uvs(diff);
shader_set_uniform_f(LFX_u_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
shader_set_uniform_f(LFX_u_angle, degtorad(-ang));
