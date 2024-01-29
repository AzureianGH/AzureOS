#include "ports/ports.h"
#include "string/string.h"
#include "types/types.h"
#include "../memory/memory.h"
void Wait(uint miliseconds) {
    for (int i = 0; i < miliseconds; i++) {
        for (int j = 0; j < 500000; j++) {
            // im losing my sanity :3
        }
    }
}
typedef struct {
    uint16_t isr_low;
    uint16_t kernel_cs;
    uint8_t reserved;
    uint8_t attributes;
    uint16_t isr_high;
} __attribute__((packed)) idt_entry_t;

__attribute__((aligned(0x10)))
static idt_entry_t idt[256];

typedef struct {
    uint16_t limit;
    uint32_t base;
} __attribute__((packed)) idtr_t;

static idtr_t idtr;

__attribute__((noreturn))
void exception_handler(void);
void exception_handler() {
    __asm__ volatile ("cli; hlt");
}