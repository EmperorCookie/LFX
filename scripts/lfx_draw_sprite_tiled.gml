///lfx_draw_sprite_tiled(sprite,subimg,x,y)
var spr = argument0;
var img = argument1;
var ox = argument2;
var oy = argument3;
var half_diag = point_distance(0, 0, view_wview[view_current], view_hview[view_current]) * 0.5;
var cx = view_xview[view_current] + view_wview[view_current] * 0.5;
var cy = view_yview[view_current] + view_hview[view_current] * 0.5;
var x1 = cx - half_diag;
var y1 = cy - half_diag;
var x2 = cx + half_diag;
var y2 = cy + half_diag;
var sw = sprite_get_width(spr);
var sh = sprite_get_height(spr);
x1 = x1 - (x1 + ox) mod sw;
y1 = y1 - (y1 + oy) mod sh;
x1 -= sw * (x1 <= 0);
y1 -= sh * (y1 <= 0);
for(var a = x1; a <= x2; a += sw) {
    for(var b = y1; b <= y2; b += sh) {
        draw_sprite(spr, img, a, b);
    }
}
