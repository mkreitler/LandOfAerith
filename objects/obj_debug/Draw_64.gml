/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_VT323);
draw_text_color(0, 0, string_concat("Width in tiles: ", global.width_in_tiles), c_yellow, c_yellow,c_yellow, c_yellow, 255);
draw_text_color(0, 20, string_concat("Height in tiles: ", global.height_in_tiles), c_yellow, c_yellow,c_yellow, c_yellow, 255);
draw_text_color(0, 40, string_concat("Scale: ", global.scale_factor), c_yellow, c_yellow,c_yellow, c_yellow, 255);
