
#include "../basic/basic.h"
#define video_memory ((uint8_t*)0xb8000)


int currentl = 0;
int lineindex = 0;
uint8_t* globalmem = video_memory;

const uint8_t color = 0x0f;

void stcursor(int off)
{
    off /= 2;
    outb(VGACTRLREG, VGACURSORHIGH);
    outb(VGADATA, (uint8_t)(off >> 8));
    outb(VGACTRLREG, VGACURSORLOW);
    outb(VGADATA, (uint8_t)(off & 0xff));
}

int gtcursor()
{
	int off = 0;
	outb(VGACTRLREG, VGACURSORHIGH);
	off = inb(VGADATA) << 8;
	outb(VGACTRLREG, VGACURSORLOW);
	off += inb(VGADATA);
	return off * 2;
}

void strcpy(char* dest, const char* src) {
    while ((*dest++ = *src++) != null_char);
}

void put_char_at(char c, int x, int y) {
    uint8_t* ptr = video_memory + (y * 80 + x) * 2;
    *ptr = c;
    *(ptr + 1) = color;
}

void put_char_at_color(char c, int x, int y, uint8_t color) {
    uint8_t* ptr = video_memory + (y * 80 + x) * 2;
    *ptr = c;
    *(ptr + 1) = color;
}

void clear_screen() {
    uint8_t* ptr = video_memory;
    for (int i = 0; i < 80 * 25; i++) {
        put_char_at(' ', i % 80, i / 80);
    }
    globalmem = video_memory;
}
void clear_screen_color(uint8_t color) {
	uint8_t* ptr = video_memory;
	for (int i = 0; i < 80 * 25; i++) {
		put_char_at_color(' ', i % 80, i / 80, color);
	}
	globalmem = video_memory;
}

int strlen(const char str[]) {
	int length = 0;
	while (str[length] != null_char) {
		length++;
	}
	return length;
}
/// <summary>
/// Set character at video memory offset
/// </summary>
/// <param name="_char">Character to place</param>
/// <param name="offset">Video Address Offset</param>
void scavm(char _char, int offset) {
    uint8_t* vidmem = (uint8_t*)VIDEO_ADDRESS;
    vidmem[offset] = _char;
    vidmem[offset + 1] = color;
}

void print(const char* str) {
    
	//
}