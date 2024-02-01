[bits 32]
[extern main]
; Global halt so C code can call it
[global halt]


call main

;jmp $
jmp $