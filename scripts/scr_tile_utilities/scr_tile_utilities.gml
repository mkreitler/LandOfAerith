// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_anim_index(base_index, frame, is_facing_right){
	var final_index = base_index;
	
	var sheet_width = sprite_get_width(spr_creatures);
	var columns_in_tileset = (sheet_width / global.tile_size);
	
	if (is_facing_right) {
		var row = floor(base_index / columns_in_tileset);
		var unflipped_col = base_index - row * columns_in_tileset;
		var flipped_col = (columns_in_tileset - 1) - unflipped_col;
		final_index = row * columns_in_tileset + flipped_col;
	}
	
	if (frame > 0) {
		final_index += columns_in_tileset;
	}
	
	return final_index;
}