#include "standard/display/display.h"
#include "standard/keyboard/keyboard.h"
#include "standard/basic/basic.h"
/// Completely halts the system.
void Freeze() {
	asm("hlt");
}
void main()
{
	clear_screen();
	print((char*)"Hello World!");
}