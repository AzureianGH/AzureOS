#include "../types/types.h"
#include "../string/string.h"
#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64
//Video Memory
#define VIDEO_ADDRESS 0xb8000
//Max Rows and Columns
#ifndef MAX_ROWS_TEXT_ONLY
#define MAX_ROWS_TEXT_ONLY 25
#endif
#ifndef MAX_COLS_TEXT_ONLY
#define MAX_COLS_TEXT_ONLY 80
#endif

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
