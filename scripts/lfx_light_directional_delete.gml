///lfx_light_directional_delete(id)
ds_map_destroy(argument0);
ds_list_delete(LFX_directionals, ds_list_find_index(LFX_directionals, argument0));
