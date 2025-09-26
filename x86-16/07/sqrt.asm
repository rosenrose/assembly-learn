TITLE Square Root

.DOSSEG
.8086
.8087
.MODEL TINY

.DATA
num    DW 121
result DW ?

.CODE
.STARTUP
    push num
    call sqrt
    add  sp, 2

    mov result, ax

    mov ah, 4Ch
    xor al, al
    int 21h

; Calc square root
sqrt PROC NEAR
    push bp
    mov bp, sp
    sub sp, 2

    finit
    fild    WORD PTR [bp+4]
    fsqrt
    fistp   WORD PTR [bp-2]
    fwait
    mov     ax, WORD PTR [bp-2]

    mov sp, bp
    pop bp
    ret
sqrt ENDP
END
