///lfx_caster_draw_all(center_x,center_x,cull?,cull_x1,cull_y1,cull_x2,cull_y2)
//Before calling this function, be sure to set the d3d_transform stack to position the drawings as you want them
var n, cx, cy, dd;
cx = argument0;
cy = argument1;
n = ds_list_size(LFX_casters);
if(n > 0) {
    var a, c, px1, py1, px2, py2, d, r;
    r = 1000;
    d = 0;
    draw_primitive_begin_texture(pr_trianglelist, -1);
    for(a = 0; a < n; a += 1) {
        c = LFX_casters[|a];
        dd = 1;
        if(dd) {
            d += 1;
            px1 = cx + (c[?"x1"] - cx) * r;
            py1 = cy + (c[?"y1"] - cy) * r;
            px2 = cx + (c[?"x2"] - cx) * r;
            py2 = cy + (c[?"y2"] - cy) * r;
            draw_vertex_texture(c[?"x1"], c[?"y1"], 0, 0);
            draw_vertex_texture(c[?"x2"], c[?"y2"], 1, 0);
            draw_vertex_texture(px1, py1, 0, 1);
            draw_vertex_texture(c[?"x2"], c[?"y2"], 1, 0);
            draw_vertex_texture(px1, py1, 0, 1);
            draw_vertex_texture(px2, py2, 1, 1);
            if(d > 150) {
                draw_primitive_end();
                draw_primitive_begin_texture(pr_trianglelist, -1);
                d = 0;
            }
        }
    }
    draw_primitive_end();
}
