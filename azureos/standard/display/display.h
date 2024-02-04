#ifndef DISPLAY_H
#define DISPLAY_H
#include "../basic/basic.h"
void set_cursor(int off);
int get_cursor();
void set_char_at_video_memory(char character, int offset);
void set_char_at_video_memory_color(char character, int offset, int color);
int get_row_from_offset(int offset);
int get_offset(int col, int row);
int move_offset_to_new_line(int offset);
int scroll_ln(int offset);
void print_string(char* string);
void Flush();
void clear_screen();
void initalize();
#endif // DISPLAY_H