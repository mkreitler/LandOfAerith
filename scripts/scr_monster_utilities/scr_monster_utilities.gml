function clean_monsters() {
	for (var i=0; i<array_length(global.monsters); ++i) {
		if (instance_exists(global.monsters[i])) {
			instance_destroy(global.monsters[i]);
		}
	}
	
	array_resize(global.monsters, 0);
}

function monster_move_patrol(obj) {
	switch (obj.patrol_state) {
		case EPATROL_STATE.MOVING:
			if (obj.direction < 180) {
				// Moving right.
				var max_x = get_corner_x_for_creature(obj.patrol_col_end, obj.scale);
				if (obj.x > max_x) {
					obj.x = max_x;
					obj.action_timer = 0;
					obj.patrol_state = EPATROL_STATE.WAITING;
					obj.speed = 0;
				}
			}
			else {
				// Moving left.
				var min_x = get_corner_x_for_creature(obj.patrol_col_start, obj.scale);
				if (obj.x < min_x) {
					obj.x = min_x;
					obj.action_timer = 0;
					obj.patrol_state = EPATROL_STATE.WAITING;
					obj.speed = 0;
				}
			}
		break;
		
		case EPATROL_STATE.WAITING:
			obj.action_timer += delta_time / 1000000;
			if (obj.action_timer > obj.patrol_turn_wait_time) {
				obj.action_timer = 0;
				obj.direction = (obj.direction + 180) % 360; // about face!
				obj.speed = obj.move_speed;
				obj.patrol_state = EPATROL_STATE.MOVING;
			}
		break;
	}
}

function monster_move_sentry(obj) {
	// Face the player:
	if (obj.type == EMONSTER_TYPE.SENTRY) {
		var player_center = global.player_object.x + global.player_object.sprite_width / 2;
		var this_center = x + sprite_width / 2;
		if (player_center < this_center) {
			obj.direction = 180;
		}
		else if (player_center > this_center) {
			obj.direction = 0;
		}
	}
}

function monster_move_tick(obj){
	// Update animation frame:
	obj.anim_timer += obj.delta_time;
	while (obj.anim_timer > obj.anim_interval) {
		obj.frame += 1;
		obj.anim_timer -= obj.anim_interval;
	}

	// These sprite sheets only have two frames of animation.
	obj.frame = obj.frame % 2;	
}
