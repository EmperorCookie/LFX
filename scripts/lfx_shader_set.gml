///lfx_shader_set()
// USE THIS IF YOU HAD TO RESET THE SHADER OR THE SURFACE TARGET
// SET THE TARGET SURFACES //
surface_set_target_ext(0, LFX_diffuse);
surface_set_target_ext(1, LFX_normal);
surface_set_target_ext(2, LFX_emissive);
surface_set_target_ext(3, LFX_specular);
// SET THE SHADER //
shader_set(LFX_shader);
