///lfx_caster_add(x1,y1,x2,y2)
//returns the ID of the caster
var m = ds_map_create();
m[?"x1"] = argument0;
m[?"y1"] = argument1;
m[?"x2"] = argument2;
m[?"y2"] = argument3;
ds_list_add(LFX_casters, m);
return m;
