///lfx_light_delete(id)
if(argument0[?"sprite"] != argument0[?"original"]) {
    sprite_delete(argument0[?"sprite"]);
}
if(argument0[?"sprite_delete"]) {
    sprite_delete(argument0[?"original"]);
}
ds_map_destroy(argument0);
ds_list_delete(LFX_lights, ds_list_find_index(LFX_lights, argument0));
