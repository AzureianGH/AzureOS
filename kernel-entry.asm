[bits 32]
[extern start]
[extern update]
; Global halt so C code can call it
[global halt]
; Global doinb so C code can call it
[global doinb]

call start

updat:
    call update
    jmp updat

halt:
	mov eax, 1
	mov ebx, 0
	int 80h