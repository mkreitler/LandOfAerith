// Returns the "row" value of the top of the dungeon hallway:
function get_hall_top_row() {
	return global.height_in_tiles - array_length(global.macro_hall_tiles[0].tiles);
}

// Returns the number of rows in the hallway space:
function get_rows_in_hall() {
	return array_length(global.macro_hall_tiles[0].tiles);
}

// Returns the bottom row of the hallway:
function get_bottom_row_in_hall() {
	var bottom_row = get_hall_top_row() + get_rows_in_hall() - 1;
	return bottom_row;
}

// Returns the number of (tile) columns in the hallway:
function get_columns_in_hall() {
	return array_length(global.macro_hall_tiles[0].tiles[0]) * global.hall_length;
}

// Returns the y-coordinate of the given row in the hallway:
function get_hall_y(for_row) {
	var rows_in_hall = get_rows_in_hall();
	var safe_row = clamp(for_row, 0, rows_in_hall - 1);
	return (global.height_in_tiles - rows_in_hall + safe_row) * global.tile_size;
}

// Compute the left-corner x-coordinate for a creature given the desired column and scale:
function get_corner_x_for_creature(column, scale) {
	var safe_col = clamp(column - (abs(scale) - 1), 0, global.hall_length * array_length(global.macro_hall_tiles[0].tiles[0]) - 1);
	
	return safe_col * global.tile_size;
}

// Compute the top-corner y-coordinate for a creature given the desired row and scale:
function get_corner_y_for_creature(row, scale) {
	var hall_top_row = get_hall_top_row();
	
	var safe_row = clamp(row - (abs(scale) - 1), 0, hall_top_row + get_rows_in_hall() - 1 - (abs(scale) - 1));

	return safe_row * global.tile_size;
}

function get_sprite_sheet_columns() {
	return floor(sprite_get_width(spr_creatures) / global.tile_size);
}

function get_sprite_source_x_for_tile(tile_index) {	
	var tile_remainder = tile_index % get_sprite_sheet_columns();
	return (tile_remainder) * global.tile_size;
}

function get_sprite_source_y_for_tile(tile_index) {
	return floor(tile_index / get_sprite_sheet_columns()) * global.tile_size;
}

