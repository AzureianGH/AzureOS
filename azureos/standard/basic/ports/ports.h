#include "../string/string.h"
#include "../types/types.h"
#ifndef PORTS_H
#define PORTS_H
#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64
//Video Memory
#define VIDEO_ADDRESS 0xb8000
#define VGA_CTRL_REGISTER 0x3d4
#define VGA_DATA_REGISTER 0x3d5
#define VGA_OFFSET_LOW 0x0f
#define VGA_OFFSET_HIGH 0x0e

uint8_t inb(uint16_t port);
void outb(uint16_t port, uint8_t data);
#endif //PORTS_H