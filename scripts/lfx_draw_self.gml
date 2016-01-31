///lfx_draw_self(<emissive_blend>)
// THIS FUNCTION IS MEANT TO BE USED AS A SIMPLE draw_self() EQUIVALENT
// THE MAPS ARE FOUND BY USING THE sprite_index + "_normal", "_specular" and "_emissive"
// IF A MAP IS NOT FOUND, IT WILL BE IGNORED
// EMISSIVE_BLEND IS THE EMISSIVE SPRITE'S image_blend
// IF EMISSIVE_BLEND IS OMITTED, image_blend IS USED INSTEAD
var blend = image_blend;
if(argument_count > 0) {
    blend = argument[0];
}
lfx_uniform_sprite(sprite_index, image_index, image_angle, sprite_get_map(sprite_index, "_normal"), sprite_get_map(sprite_index, "_specular"), sprite_get_map(sprite_index, "_emissive"), blend);
draw_self();
