/// @description Insert description here
// You can write your code in this editor

x = 2 * global.tile_size;
y = (get_hall_top_row() + get_rows_in_hall() - 2) * global.tile_size + global.character_offset_y;
shadow_type = ESHADOW_TYPE.NONE;

direction = 0;