#ifndef __types_h__
#define __types_h__
#include <stdint.h>
#include <stddef.h>
/*
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;
*/
/*
typedef char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int64_t;
*/
#define bool int
#define null_char '\0'
#define true 1
#define false 0
typedef uint32_t uint;
typedef struct {
	uint32_t x;
	uint32_t y;
} UPoint;

typedef struct {
	int_fast16_t x;
	int_fast16_t y;
} Point;
#define low_16(address) (uint16_t)((address) & 0xFFFF)
#define high_16(address) (uint16_t)(((address) >> 16) & 0xFFFF)
#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f
#endif // __types_h__