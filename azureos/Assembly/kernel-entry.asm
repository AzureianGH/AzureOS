[bits 32]
[extern main]
; Global halt so C code can call it


call main

;jmp $
jmp $