///lfx_target_diffuse()
var vw = view_wview[view_current] + 4;
var vh = view_hview[view_current] + 4;
if(!surface_exists(LFX_diffuse)) {
    LFX_diffuse = surface_create(vw, vh);
} else {
    if(vw != surface_get_width(LFX_diffuse) || vh != surface_get_height(LFX_diffuse)) {
        surface_resize(LFX_diffuse, vw, vh);
    }
}
