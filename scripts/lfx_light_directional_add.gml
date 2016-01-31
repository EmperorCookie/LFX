///lfx_light_directional_add(x,y,z,blend)
//returns the ID of the light or -1 on error
var m = ds_map_create();
m[?"x"] = argument0;
m[?"y"] = argument1;
m[?"z"] = argument2;
m[?"blend"] = argument3;
m[?"enabled"] = 1;
ds_list_add(LFX_directionals, m);
return m;
