///light_system_init()
//You must call this script before any other
//MAKE SURE YOU CALL THIS SCRIPT ONLY ONCE, RISK OF MEMORY LEAK
//Views must be enabled in order for this lighting engine to work
//If you do not want to use views, simply set the view to cover the whole room in the room editor
//The system works in 3D, except the shadows part
globalvar LFX_lights, LFX_casters, LFX_culling, LFX_surface;
LFX_diffuse = -1;
LFX_normal = -1;
LFX_illumin = -1;
LFX_lights = ds_list_create();
LFX_casters = ds_list_create();
LFX_culling = false;
surface_cache_init();
