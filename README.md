# LFX Light System

LFX is a deferred, shader based lighting engine for GameMaker:Studio. The pipeline uses a diffuse map, a normal map, a specular map and an emissive map. It uses MRTs and is written in both HLSL and GLSL for portability.

All shaders that don't require specific functionality are written in GLSL ES to avoid having to write multiple versions.

Supports GameMaker:Studio's built-in sprite packing.

Supports GameMaker:Studio's built-in background system.

## Using LFX

### Setup

1. Create an instance of `obj_lfx` or call the function `lfx_init()`
2. Add lights using `lfx_light_add(..)` or `lfx_light_directional_add(..)`

### Drawing your sprites

There are many ways to draw using this system, each having specific uses.

**Simple**

In the draw event of your object, call the function `lfx_draw_self(emissive_blend)`

This function will automatically find the appropriate maps for your `sprite_index` by appending `_normal`, `_specular` and `_emissive` at the end. So for `spr_ball` to have maps, you would add sprites named `spr_ball_normal`, `spr_ball_specular` and `spr_ball_emissive`. The argument `emissive_blend` is the colour used to tint the emissive map.

**Custom**

Before drawing your sprite, call the function `lfx_uniform_sprite(..)` or `lfx_uniform_background(..)`, followed by drawing your sprite.

Included are functions to find the associated sprites easily, for example `sprite_get_map(sprite,string)` which will append `string` to the name of `sprite` and return the corresponding sprite index.

**Tiled**

*Requires you to set the uniforms manually using the __Custom__ method.*

Unfortunately, to work around GameMaker:Studio's forward rendering pipeline, the views had to be recreated using `d3d_transform_*` which broke the built-in culling, which means tiled draws need to be recreated.

Call the function `lfx_draw_sprite_tiled(..)` or `lfx_draw_background_tiled(..)` or `lfx_draw_surface_tiled(..)` after properly setting up the shader uniforms.

**Raw**

Allows you to set the uniforms yourself instead of relying on built-in functions.

Call the function `lfx_uniform_raw(..)` and pass the required arguments, then perform your draw call.

## Contributing

The project is open to contributions. Please use GitFlow.

Note that this project is intended to be released on the YYG Marketplace, so the license will be their EULA.
