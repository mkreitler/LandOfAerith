/// @description Insert description here
// You can write your code in this editor
var shadow_index = -1;
switch(shadow_type) {
	case ESHADOW_TYPE.SMALL:
		shadow_index = get_anim_index(13, 0, false);
	break;
	
	case ESHADOW_TYPE.MEDIUM:
		shadow_index = get_anim_index(12, 0, false);
	break;
	
	case ESHADOW_TYPE.LARGE:
		shadow_index = get_anim_index(11, 0, false);
	break;
	
	default: // Includes ESHADOW_TYPE.NONE
		// Do nothing.
	break;
}

if (shadow_index > 0) {
	draw_tile(ts_creatures_flipped, shadow_index, 0, x, y);
}

facing_right = direction == 0;
var anim_index = get_anim_index(tile_index, frame, facing_right);
if (facing_right) {
	draw_tile(ts_creatures_flipped, anim_index, 0, x, y);
}
else {
	draw_tile(ts_creatures, anim_index, 0, x, y);
}
