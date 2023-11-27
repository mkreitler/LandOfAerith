switch(global.game_state) {
	case EGAME_STATE.DUNGEON_MOVE:
		monster_move_tick(self);
		
		switch(type) {
			case EMONSTER_TYPE.SENTRY:
				monster_move_sentry(self);
			break;
			
			case EMONSTER_TYPE.PATROL:
				monster_move_patrol(self);
			break;
		}
	break;
}