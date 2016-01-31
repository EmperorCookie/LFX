///pointlight_create(radius)
// RETURNS: sprite_index
// Do not forget to destroy this sprite after use
var w = argument0 * 2;
var sur = surface_create(w, w);
surface_set_target(sur);
draw_clear_alpha(0, 1);
draw_set_circle_precision(64);
draw_circle_colour(argument0, argument0, argument0, c_white, 0, 0);
draw_set_circle_precision(24);
surface_reset_target();
var spr = sprite_create_from_surface(sur, 0, 0, w, w, 0, 0, argument0, argument0);
surface_free(sur);
return spr;
