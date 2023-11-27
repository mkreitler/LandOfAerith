hall_col = 7; // irandom(get_columns_in_hall() - 1);
hall_row = get_bottom_row_in_hall() - 1;

x = get_corner_x_for_creature(hall_col, scale);
y = get_corner_y_for_creature(hall_row, scale) + global.character_offset_y;