///lfx_caster_delete(id)
ds_map_destroy(argument0);
ds_list_delete(LFX_casters, ds_list_find_index(LFX_casters, argument0));
