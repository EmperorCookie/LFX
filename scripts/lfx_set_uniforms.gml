///lfx_set_shader(diffuse_sprite,image_index,normal_sprite,specular_sprite,illumin_sprite,illumin_blend)
var diff = argument0;
var ind = argument1;
var norm = argument2;
var spec = argument3;
var illu = argument4;
var ic = argument5;
var ir = colour_get_red(ic) / 255;
var ig = colour_get_green(ic) / 255;
var ib = colour_get_blue(ic) / 255;
shader_set(sha_deferred);
texture_set_stage(LFX_u_normal_map, sprite_get_texture(norm, ind));
texture_set_stage(LFX_u_illumin_map, sprite_get_texture(spec, ind));
texture_set_stage(LFX_u_specular_map, sprite_get_texture(illu, ind));
var uvs = sprite_get_uvs(diff, ind);
shader_set_uniform_f(LFX_u_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
uvs = sprite_get_uvs(norm, ind);
shader_set_uniform_f(LFX_u_normal_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
uvs = sprite_get_uvs(spec, ind);
shader_set_uniform_f(LFX_u_specular_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
uvs = sprite_get_uvs(illu, ind);
shader_set_uniform_f(LFX_u_illumin_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
shader_set_uniform_f(LFX_u_illumin_colour, ir, ig, ib);