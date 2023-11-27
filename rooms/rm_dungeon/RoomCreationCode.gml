global.player_object = instance_create_layer(0, 0, "ForeInstances", obj_player);
global.monster_object = instance_create_layer(0, 0, "MonsterInstances", obj_monster);
array_insert(global.monsters,0,  global.monster_object);

// TEMP
global.monster_object.scale = 2;
global.monster_object.tile_index = 204;
global.monster_object.type = EMONSTER_TYPE.PATROL;
global.monster_object.patrol_col_start = 5;
global.monster_object.patrol_col_end = 11;
global.monster_object.move_speed = 0.5;
global.monster_object.direction = 0;
global.monster_object.speed = global.monster_object.move_speed;
global.monster_object.patrol_turn_wait_time = 1;
monster_update(global.monster_object);

camera_set_view_target(global.main_camera, global.player_object);
global.game_state = EGAME_STATE.DUNGEON_MOVE;