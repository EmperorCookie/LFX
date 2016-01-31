///lfx_reset()
//Deletes every light and every caster
while(ds_list_size(LFX_lights) > 0) {
    lfx_light_delete(LFX_lights[|0]);
}
while(ds_list_size(LFX_casters) > 0) {
    lfx_light_delete(LFX_casters[|0]);
}
