// Update animation frame:
anim_timer += delta_time;
while (anim_timer > anim_interval) {
	frame += 1;
	anim_timer -= anim_interval;
}

// These sprite sheets only have two frames of animation.
frame = frame % 2;

speed = 0;
if (left_down) speed -= walk_speed;
if (right_down) speed += walk_speed;

if (speed > 0) {
	direction = 0;
}
else if (speed < 0) {
	direction = 180;
}

speed = abs(speed);

// Stop animation when not moving:
if (speed == 0) {
	frame = 0;
}

var hallway_width = global.hall_length * array_length(global.macro_hall_tiles[0].tiles[0]) * global.tile_size;
var x_max = hallway_width - view_wport[0];
x = clamp(x, 0, hallway_width - global.tile_size);

var x_cam = clamp(x - (view_wport[0] / 2), 0, x_max);
camera_set_view_pos(view_camera[0], x_cam, 0);
