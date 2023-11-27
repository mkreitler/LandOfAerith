// Compute the tileset index for an image given its base index, anim frame, and facing:
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

// Recompute dependent variables after a state change:
function monster_update(monster_object) {
	monster_object.x = get_corner_x_for_creature(monster_object.hall_col, monster_object.scale);
	monster_object.y = get_corner_y_for_creature(monster_object.hall_row, monster_object.scale) + global.character_offset_y;
}