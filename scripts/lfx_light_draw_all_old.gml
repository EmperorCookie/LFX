///lfx_light_draw_all_old()
var shader = sha_deferred_light_shadows;
var n = ds_list_size(LFX_lights);
shader_set(shader);
texture_set_stage(shader_get_sampler_index(shader, "u_normal"), surface_get_texture(LFX_normal));
texture_set_stage(shader_get_sampler_index(shader, "u_specular"), surface_get_texture(LFX_specular));
// SET CASTER UNIFORMS //
if(shader != sha_deferred_light_plain) {
    var num = ds_list_size(LFX_casters);
    var casters;
    casters[num * 4 + 3] = 0;
    for(var a = num - 1; a >= 0; a -= 1) {
        var c = LFX_casters[|a];
        casters[a * 4 + 3] = c[?"y2"];
        casters[a * 4 + 2] = c[?"x2"];
        casters[a * 4 + 1] = c[?"y1"];
        casters[a * 4] = c[?"x1"];
    }
    shader_set_uniform_f_array(shader_get_uniform(shader, "u_casters"), casters);
    shader_set_uniform_i(shader_get_uniform(shader, "u_caster_number"), num);
}
// DRAW EACH LIGHT //
for(var a = 0; a < n; a += 1) {
    l = LFX_lights[|a];
    if(!l[?"enabled"]) {
        continue;
    }
    shader_set_uniform_f(shader_get_uniform(shader, "u_light_pos"), l[?"x"], l[?"y"], l[?"z"]);
    shader_set_uniform_f(shader_get_uniform(shader, "u_do_shadows"), l[?"shadows"]);
    draw_sprite_ext(l[?"sprite"], l[?"image"], l[?"x"], l[?"y"], l[?"xscale"], l[?"yscale"], l[?"angle"], l[?"blend"], 1);
}
// RESET SHADER //
shader_reset();
