///lfx_caster_follow(id,x1_offset,y1_offset,x2_offset,y2_offset,angle_offset)
var ox1, oy1, ox2, oy2, na;
na = image_angle + argument5;
if(na != 0) {
    ox1 = vector_rotate_x(argument1, argument2, na);
    oy1 = vector_rotate_y(argument1, argument2, na);
    ox2 = vector_rotate_x(argument3, argument4, na);
    oy2 = vector_rotate_y(argument3, argument4, na);
} else {
    ox1 = argument1;
    oy1 = argument2;
    ox2 = argument3;
    oy2 = argument4;
}
argument0[?"x1"] = x + ox1;
argument0[?"y1"] = y + oy1;
argument0[?"x2"] = x + ox2;
argument0[?"y2"] = y + oy2;
