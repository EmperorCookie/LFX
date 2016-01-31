///lfx_light_follow(id,x_offset,y_offset,angle_offset)
//Follows calling object's (x, y, image_angle)
//This function should be called last, after all movement is done (end_step_event)
//x_offset/y_offset are rotated with image_angle
var nx, ny, na;
nx = 0;
ny = 0;
na = image_angle + argument3;
if(argument1 != 0 or argument2 != 0) {
    if(na != 0) {
        nx = vector_rotate_x(argument1, argument2, na);
        ny = vector_rotate_y(argument1, argument2, na);
    } else {
        nx = argument1;
        ny = argument2;
    }
}
nx += x;
ny += y;
argument0[?"x"] = nx;
argument0[?"y"] = ny;
argument0[?"angle"] = na mod 360;
