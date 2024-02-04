#ifndef __INT_H__
#define __INT_H__
#include "../../basic.h"

typedef struct {
    uint16_t low_offset;
    uint16_t selector;
    uint8_t always0;
    uint8_t flags;
    uint16_t high_offset;
} __attribute__((packed)) idt_gate_t;

void set_idt_gate(int n, uint32_t handler);
char* exception_messages[] = {
    "Division by zero",
    "Debug",
    "Reserved"
};
typedef struct {
    // data segment selector
    uint32_t ds;
    // general purpose registers pushed by pusha
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    // pushed by isr procedure
    uint32_t int_no, err_code;
    // pushed by CPU automatically
    uint32_t eip, cs, eflags, useresp, ss;
} registers_t;
void isr_handler(registers_t* r);

#endif // !__INT_H__
