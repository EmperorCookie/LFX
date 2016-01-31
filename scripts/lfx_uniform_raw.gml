///lfx_uniform_raw(diffuse_uvs,image_angle,normal_texture,normal_uvs,specular_texture,specular_uvs,emissive_texture,emissive_uvs,emissive_blend)
//IF YOU NEED NORMAL/SPECULAR/EMISSIVE MAPS TO BE IGNORED, SIMPLY SET THEIR TEXTURE TO -1 AND UVS TO 0
shader_set_uniform_f(LFX_u_uvs, argument0[0], argument0[1], argument0[2], argument0[3]);
shader_set_uniform_f(LFX_u_angle, degtorad(-argument1));
texture_set_stage(LFX_u_normal_map, argument2);
shader_set_uniform_f(LFX_u_normal_uvs, argument3[0], argument3[1], argument3[2], argument3[3]);
texture_set_stage(LFX_u_specular_map, argument4);
shader_set_uniform_f(LFX_u_specular_uvs, argument5[0], argument5[1], argument5[2], argument5[3]);
texture_set_stage(LFX_u_emissive_map, argument6);
shader_set_uniform_f(LFX_u_emissive_uvs, argument7[0], argument7[1], argument7[2], argument7[3]);
shader_set_uniform_f(LFX_u_emissive_blend, colour_get_red(argument8) / 255, colour_get_green(argument8) / 255, colour_get_blue(argument8) / 255);
