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