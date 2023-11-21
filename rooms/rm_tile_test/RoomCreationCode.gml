global.player_object = instance_create_layer(0, 0, "ForeInstances", obj_player);
camera_set_view_target(global.main_camera, global.player_object);