#include "../string/string.h"
#include "../types/types.h"
#ifndef PORTS_H
#define PORTS_H
#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64
//Video Memory
#define VGA_CTRL_REGISTER 0x3d4
#define VGA_DATA_REGISTER 0x3d5
#define VGA_OFFSET_LOW 0x0f
#define VGA_OFFSET_HIGH 0x0e

unsigned char port_byte_in(unsigned short port);
void port_byte_out(unsigned short port, unsigned char data);
#endif //PORTS_H