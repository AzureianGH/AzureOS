#include "../string/string.h"
#include "../types/types.h"
#ifndef PORTS_H
#define PORTS_H
#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64
//Video Memory
#define VIDEO_ADDRESS 0xb8000

#define VGACTRLREG 0x3d4
#define VGADATA 0x3d5
#define VGACURSORHIGH 0x0f
#define VGACURSORLOW 0x0e

uint8_t inb(uint16_t port);
void outb(uint16_t port, uint8_t data);
#endif //PORTS_H