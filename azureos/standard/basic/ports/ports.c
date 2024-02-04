#include "../types/types.h"
#include "../string/string.h"
#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64
//Video Memory
#define VIDEO_ADDRESS 0xb8000
#define VGA_CTRL_REGISTER 0x3d4
#define VGA_DATA_REGISTER 0x3d5
#define VGA_OFFSET_LOW 0x0f
#define VGA_OFFSET_HIGH 0x0e

/// @brief Ports in a byte from a given port
/// @param port Port to read from
/// @return Byte read from port
uint8_t inb(uint16_t port)
{
	uint8_t result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}
/// @brief Ports out a byte to a given port
/// @param port Port to write to
/// @param data Byte to write to port
void outb(uint16_t port, uint8_t data)
{
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}
