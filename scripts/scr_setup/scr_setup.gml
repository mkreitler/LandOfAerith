// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.res_width = 1200;
global.res_height = 1920;
global.res_aspect = res_width / res_height;

enum EGAME_STATE {
	SETUP,
	DUNGEON_MOVE,
}

enum EPLATFORM
{
	DESKTOP,
	MOBILE,
	BROWSER
}

enum ESHADOW_TYPE {
	NONE,
	SMALL,
	MEDIUM,
	LARGE
}

enum EMONSTER_TYPE {
	BASIC,
	SENTRY,
	PATROL
}

enum EPATROL_STATE {
	MOVING,
	WAITING,
}

global.game_state = EGAME_STATE.SETUP;
global.platform = EPLATFORM.DESKTOP;
global.do_debug = false;
global.character_offset_y = 5;
global.player = -1;
global.monsters = [];

function setup_game(){
	setup_macro_tile_mappings();
	
	if (os_type == os_android) || (os_type == os_ios)
	{
		global.platform = EPLATFORM.MOBILE;
	}
	
	if (os_browser != browser_not_a_browser)
	{
		global.platform = EPLATFORM.BROWSER;
	}
	
	switch(global.platform)
	{
		case EPLATFORM.DESKTOP:
			setup_window(window_get_width(), window_get_height());
		break;

		case EPLATFORM.MOBILE:
			// Ipad3 = 4x3
			// Fire HD = 8x5
			setup_window(display_get_width(), display_get_height());
		break;
		
		case EPLATFORM.BROWSER: default:
			setup_window(window_get_width(), window_get_height());
		break;
	}
	
	room_goto(rm_dungeon);	
}

global.tile_size = 24;
global.aspect_width = 8;
global.aspect_height = 5;
global.scale_factor = 1;
global.width_in_tiles = 0;
global.height_in_tiles = 0;
global.game_res_x = 0;
global.game_res_y = 0;

function setup_window(win_width, win_height)
{
	var base_width_unit = global.tile_size * global.aspect_width;
	var base_height_unit = global.tile_size * global.aspect_height;
	
	var width_units = floor(win_width / base_width_unit);
	var height_units = floor(win_height / base_height_unit);
	
	var dpi_x = display_get_dpi_x();
	var dpi_y = display_get_dpi_y();
	
	// Compute the scale we'll need to get our characters to be 1 inch tall on the screen (or 1/4 of the screen height):
	var character_size = min(dpi_y * 1.0, win_height * 0.25);
	var exact_scale_y = character_size / global.tile_size;
	global.scale_factor = ceil(exact_scale_y);
	
	global.height_in_tiles = floor(win_height / (global.tile_size * global.scale_factor));
	global.width_in_tiles = floor(win_width / (global.tile_size * global.scale_factor));
		
	global.res_width = global.width_in_tiles * global.tile_size * global.scale_factor;
	global.res_height = global.height_in_tiles * global.tile_size * global.scale_factor;
	
	window_set_size(global.res_width, global.res_height);
	window_set_position((display_get_width() - global.res_width) / 2, (display_get_height() - global.res_height) / 2);

	obj_sizing.image_xscale = global.scale_factor;
	obj_sizing.image_yscale = global.scale_factor;
	obj_sizing.x = global.res_width / 2 - obj_sizing.sprite_width / 2;
	obj_sizing.y = global.res_height / 2 - obj_sizing.sprite_height / 2;	
	
	global.game_res_x = global.res_width / global.scale_factor;
	global.game_res_y = global.res_height / global.scale_factor;
	global.main_camera = camera_create_view(0, 0, global.game_res_x, global.game_res_y);
	
	surface_resize(application_surface, global.game_res_x, global.game_res_y);
	room_set_viewport(rm_dungeon, 0, true, 0, 0, global.game_res_x, global.game_res_y);
	room_set_view_enabled(rm_dungeon, true);
	room_set_camera(rm_dungeon, 0, global.main_camera);
}

function setup_macro_tile_mappings() {
	global.macro_tile_width = 4;
	global.macro_tile_height = 5;
	global.hall_length = 10;
	global.rooms_per_hall = 3;
	
	global.filler_tiles = [-1, 8, 18, 24];
	global.main_tile = [4, 6, 13, 15, 15, 15, 15, 15];
	global.floor_tile = [28, 28, 28, 35];
	
	global.macro_hall_tiles = [
		{
			name : "Test Tile 01",
			tiles: [[31, 31, 31, 31],
					[-1, -1, -1, -1],
					[-1, -1, -1, -1],
					[-1, -1, -1, -1],
					[-2, -2, -2, -2]]
		},
	];
	
	global.macro_door_tiles = [
		{
			name : "Door_Left",
			tiles: [[31, 31, 31, 31],
					[-1, -1, -1, -1],
					[09, 10, -1, -1],
					[16, 23, -1, -1],
					[-2, -2, -2, -2]]
		},
		{
			name : "Door_Mid",
			tiles: [[31, 31, 31, 31],
					[-1, -1, -1, -1],
					[-1, 09, 10, -1],
					[-1, 16, 23, -1],
					[-2, -2, -2, -2]]
		},
		{
			name : "Door_Right",
			tiles: [[31, 31, 31, 31],
					[-1, -1, -1, -1],
					[-1, -1, 09, 10],
					[-1, -1, 16, 23],
					[-2, -2, -2, -2]]
		},
	];
}
	
// Returns the index of a random tile within the filler_tiles array:
function get_filler_tile_index(filler_index) {
	var _lookup_index = irandom(99);
	var _tile_index = 0;

	switch (filler_index) {
		case -1:
			_tile_index = global.main_tile[irandom(array_length(global.main_tile) - 1)];
		
			if (_lookup_index < 1) {
				_tile_index = global.filler_tiles[1];
			}
			else if (_lookup_index < 2) {
				_tile_index = global.filler_tiles[2];
			}
			else if (_lookup_index < 4) {
				_tile_index = global.filler_tiles[3];
			}
		break;
		
		case -2:
			_tile_index = global.floor_tile[irandom(array_length(global.floor_tile) - 1)];
		break;
	}
	
	return _tile_index;
}
