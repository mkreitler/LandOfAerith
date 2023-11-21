/// @description Insert description here
// You can write your code in this editor
var lay_id = layer_get_id("BackTiles");
var map_id = layer_tilemap_get_id(lay_id);
var tileset = tilemap_get_tileset(map_id);

var next_tile_offset = tileset_get_info(tileset).tile_columns + 1;


// Build a background.
var tile_data = global.macro_hall_tiles[0];
for (var i=0; i<global.hall_length; i+=1) {
	for (var iRow=0; iRow<array_length(tile_data.tiles); iRow+=1) {
		var row = min(global.height_in_tiles / 2, global.height_in_tiles - array_length(tile_data.tiles));
		row = row + iRow;
		for (var iCol=0; iCol<array_length(tile_data.tiles[iRow]); iCol+=1) {
			var col = i * array_length(global.macro_hall_tiles[0].tiles[iRow]) + iCol;
			var tile_index = tile_data.tiles[iRow][iCol];
			if (tile_index < 0) {
				tile_index = get_filler_tile_index(tile_index);
			}
			tilemap_set(map_id, tile_index, col, row);
		}
	}
}

tile_data = global.macro_door_tiles[0];
for (var iRoom=0; iRoom<global.rooms_per_hall; iRoom+=1) {
	var room_index = floor(global.hall_length / global.rooms_per_hall);
	var room_offset = irandom(2) - 1;
	room_index = clamp(room_offset + room_index, 0, global.hall_length - 1);
	var which_room = irandom(array_length(global.macro_door_tiles) - 1);
	
	for (var iRow=0; iRow<array_length(tile_data.tiles); iRow+=1) {
		var row = min(global.height_in_tiles / 2, global.height_in_tiles - array_length(tile_data.tiles));
		row = row + iRow;
		for (var iCol=0; iCol<array_length(tile_data.tiles[iRow]); iCol+=1) {
			var col = room_index * array_length(global.macro_door_tiles[0].tiles[iRow]) + iCol;
			var tile_index = tile_data.tiles[iRow][iCol];
			if (tile_index < 0) {
				tile_index = get_filler_tile_index(tile_index);
			}
			tilemap_set(map_id, tile_index, col, row);
		}
	}
}


// camera_set_view_target(global.main_camera, obj_player);