#include "../basic/basic.h"

void set_cursor(int off)
{
	off /= 2;
	outb(VGA_CTRL_REGISTER, VGA_OFFSET_HIGH);
	outb(VGA_DATA_REGISTER, (uint8_t)(off >> 8));
	outb(VGA_CTRL_REGISTER, VGA_OFFSET_LOW);
	outb(VGA_DATA_REGISTER, (uint8_t)(off & 0xff));
}
int get_cursor()
{
	outb(VGA_CTRL_REGISTER, VGA_OFFSET_HIGH);
	int offset = inb(VGA_DATA_REGISTER) << 8;
	outb(VGA_CTRL_REGISTER, VGA_OFFSET_LOW);
	offset += inb(VGA_DATA_REGISTER);
	return offset * 2;
}
void set_char_at_video_memory(char character, int offset)
{
	unsigned char* vidmem = (unsigned char*)VIDEO_ADDRESS;
	vidmem[offset] = character;
	vidmem[offset + 1] = WHITE_ON_BLACK;
}
int get_row_from_offset(int offset)
{
	return offset / (2 * MAX_COLS);
}
int get_offset(int col, int row)
{
	return 2 * (row * MAX_COLS + col);
}
int move_offset_to_new_line(int offset)
{
	return get_offset(0, get_row_from_offset(offset) + 1);
}
int scroll_ln(int offset)
{
	memory_copy(
		(char*)(get_offset(0, 1) + VIDEO_ADDRESS),
		(char*)(get_offset(0, 0) + VIDEO_ADDRESS),
		MAX_COLS * (MAX_ROWS - 1) * 2
	);
	for (int col = 0; col < MAX_COLS; col++)
	{
		set_char_at_video_memory(' ', get_offset(col, MAX_ROWS - 1));
	}
	return offset - 2 * MAX_COLS;
}
void print_string(char* string) {
	int offset = get_cursor();
	for (int i = 0; string[i] != 0; ++i) {
		if (string[i] == '\n') {
			offset = move_offset_to_new_line(offset);
		} else {
			set_char_at_video_memory(string[i], offset);
			offset += 2;
		}
		if (offset >= MAX_ROWS * MAX_COLS * 2) {
			offset = scroll_ln(offset);
		}
	}
	set_cursor(offset);
}
	
void clear_screen()
{
	for (int i = 0; i < MAX_COLS * MAX_ROWS; ++i) {
		set_char_at_video_memory(' ', i * 2);
	}
	set_cursor(get_offset(0, 0));
}
void initalize()
{
	clear_screen();
}