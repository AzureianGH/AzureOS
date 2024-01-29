[bits 32]
[extern main]
; Global halt so C code can call it
[global halt]


call main

;jmp $
jmp $
halt:
	mov eax, 1
	mov ebx, 0
	int 80h