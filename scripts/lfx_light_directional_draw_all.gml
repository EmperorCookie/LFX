///lfx_light_directional_draw_all()
shader_set(sha_deferred_light_directional);
texture_set_stage(shader_get_sampler_index(sha_deferred_light_directional, "u_specular"), surface_get_texture(LFX_specular));
var n = ds_list_size(LFX_directionals);
for(var a = 0; a < n; a += 1) {
    l = LFX_directionals[|a];
    if(!l[?"enabled"]) {
        continue;
    }
    shader_set_uniform_f(shader_get_uniform(sha_deferred_light_directional, "u_position"), l[?"x"], l[?"y"], l[?"z"]);
    draw_surface_ext(LFX_normal, 0, 0, 1, 1, 0, l[?"blend"], 1);
}
shader_reset();
