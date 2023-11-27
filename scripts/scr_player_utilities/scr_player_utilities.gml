function clean_player() {
	if (instance_exists(global.player)) {
		instance_destroy(global.player);
	}
}

function player_move_step(player_obj){
	// Update animation frame:
	player_obj.anim_timer += delta_time;
	while (player_obj.anim_timer > player_obj.anim_interval) {
		player_obj.frame += 1;
		player_obj.anim_timer -= player_obj.anim_interval;
	}

	// These sprite sheets only have two frames of animation.
	player_obj.frame = player_obj.frame % 2;

	player_obj.speed = 0;
	if (player_obj.left_down) player_obj.speed -= player_obj.walk_speed;
	if (player_obj.right_down) player_obj.speed += player_obj.walk_speed;

	if (player_obj.speed > 0) {
		player_obj.direction = 0;
	}
	else if (player_obj.speed < 0) {
		player_obj.direction = 180;
	}

	player_obj.speed = abs(player_obj.speed);

	// Stop animation when not moving:
	if (player_obj.speed == 0) {
		player_obj.frame = 0;
	}

	var hallway_width = global.hall_length * array_length(global.macro_hall_tiles[0].tiles[0]) * global.tile_size;
	var x_max = hallway_width - view_wport[0];
	x = clamp(x, 0, hallway_width - global.tile_size);

	var x_cam = clamp(x - (view_wport[0] / 2), 0, x_max);
	camera_set_view_pos(view_camera[0], x_cam, 0);
}