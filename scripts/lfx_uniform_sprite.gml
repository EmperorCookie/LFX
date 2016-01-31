///lfx_uniform_sprite(diffuse_sprite,image_index,image_angle,normal_sprite,specular_sprite,emissive_sprite,emissive_blend)
var diff = argument0;
if(!sprite_exists(diff)) {
    exit;
}
var ind = argument1;
var ang = argument2;
var norm = argument3;
var spec = argument4;
var emis = argument5;
var ic = argument6;
var ir = colour_get_red(ic) / 255;
var ig = colour_get_green(ic) / 255;
var ib = colour_get_blue(ic) / 255;
var uvs;
if(sprite_exists(norm)) {
    texture_set_stage(LFX_u_normal_map, sprite_get_texture(norm, ind));
    uvs = sprite_get_uvs(norm, ind);
    shader_set_uniform_f(LFX_u_normal_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
} else {
    shader_set_uniform_f(LFX_u_normal_uvs, 0, 0, 0, 0);
}
if(sprite_exists(spec)) {
    texture_set_stage(LFX_u_specular_map, sprite_get_texture(spec, ind));
    uvs = sprite_get_uvs(spec, ind);
    shader_set_uniform_f(LFX_u_specular_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
} else {
    shader_set_uniform_f(LFX_u_specular_uvs, 0, 0, 0, 0);
}
if(sprite_exists(emis)) {
    texture_set_stage(LFX_u_emissive_map, sprite_get_texture(emis, ind));
    uvs = sprite_get_uvs(emis, ind);
    shader_set_uniform_f(LFX_u_emissive_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
} else {
    shader_set_uniform_f(LFX_u_emissive_uvs, 0, 0, 0, 0);
}
shader_set_uniform_f(LFX_u_emissive_blend, ir, ig, ib);
uvs = sprite_get_uvs(diff, ind);
shader_set_uniform_f(LFX_u_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
shader_set_uniform_f(LFX_u_angle, degtorad(-ang));
