facing_right = direction == 0;

var draw_index = tile_index;
if (frame == 1) {
	draw_index += get_sprite_sheet_columns();
}

var sprite_source_x = get_sprite_source_x_for_tile(draw_index);
var sprite_source_y = get_sprite_source_y_for_tile(draw_index);

var draw_scale = scale;
var draw_x = x;

if (facing_right) {
	draw_scale *= -1;
	draw_x += global.tile_size * scale;
}

draw_sprite_part_ext(spr_creatures, 0, sprite_source_x, sprite_source_y, global.tile_size, global.tile_size, draw_x, y, draw_scale, abs(draw_scale), c_white, 1);


