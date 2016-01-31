///lfx_init()
//
// You must call this script before any other
//
// Views must be enabled in order for this lighting engine to work
// If you do not want to use views, simply set the view to cover the whole room in the room editor
//
// This engine uses d3d_transforms to work around the way GM's draw pipeline works
// If you need to use d3d_transforms, use the following code:
//
//d3d_transform_stack_push();
//var mat = matrix_get(matrix_world);
//SET YOUR TRANSFORMS HERE
//matrix_set(matrix_world, matrix_multiply(matrix_get(matrix_world), mat));
//DRAW YOUR STUFF HERE
//d3d_transform_stack_pop();
//
instance_create(0, 0, obj_lfx);
