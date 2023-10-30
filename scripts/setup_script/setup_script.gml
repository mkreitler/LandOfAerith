// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.res_width = 1200;
global.res_height = 1920;
global.res_aspect = res_width / res_height;

enum EPLATFORM
{
	DESKTOP,
	MOBILE,
	BROWSER
}

global.platform = EPLATFORM.DESKTOP;


function setup_game(){
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
}

global.tile_size = 24;
global.aspect_width = 8;
global.aspect_height = 5;
global.scale_factor = 1;
global.width_in_tiles = 0;
global.height_in_tiles = 0;

function setup_window(win_width, win_height)
{
	var base_width_unit = global.tile_size * global.aspect_width;
	var base_height_unit = global.tile_size * global.aspect_height;
	
	var width_units = floor(win_width / base_width_unit);
	var height_units = floor(win_height / base_height_unit);
	
	var dpi_x = display_get_dpi_x();
	var dpy_y = display_get_dpi_y();
	
	// Compute the scale we'll need to get our characters to be 1/2 inch tall on the screen.
	var pixels_per_half_inch = dpy_y * 0.5;
	var exact_scale_y = pixels_per_half_inch / global.tile_size;
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
}
