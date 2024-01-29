#ifndef DISPLAY_H
#define DISPLAY_H
#include "../memory/memory.h"
#include "../basic/string/string.h"
#include "../basic/types/types.h"

extern int currentl;
extern int lineindex;
extern uint8_t* globalmem;

void stcursor(int off);
int gtcursor();
void strcpy(char* dest, const char* src);
void put_char_at(char c, int x, int y);
void put_char_at_color(char c, int x, int y, uint8_t color);
void clear_screen();
int strlen(string str);
void scavm(char _char, int offset);
void print(char* str);

void clear_screen_color(uint8_t color);
#endif // DISPLAY_H
