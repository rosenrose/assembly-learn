    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

num0=$4000
num1=$4001
op=$4002    ; 0(+), 1(-), 2(<), 3(>)
opaddr=$10
out=$12

    ; == Define input here ==
    lda #12
    sta num0
    
    lda #16
    sta num1
    
    lda #0
    sta op
    ; =======================

    ldx op

    lda table_lo,x
    sta opaddr
    lda table_hi,x
    sta opaddr+1

    lda num0    ; A = solution
    jmp (opaddr)

calc_add:
    clc
    adc num1
    jmp end

calc_sub:
    sec
    sbc num1
    jmp end

calc_lshift:
    ldy num1

lshift_loop:
    beq end

    asl
    dey
    jmp lshift_loop

calc_rshift:
    ldy num1

rshift_loop:
    beq end

    lsr
    dey
    jmp rshift_loop

end:
    sta out

    .ORG $C000,0
table_lo:
    .BYTE <calc_add      ; index = 0
    .BYTE <calc_sub      ; index = 1
    .BYTE <calc_lshift   ; index = 2
    .BYTE <calc_rshift   ; index = 3
table_hi:
    .BYTE >calc_add      ; index = 0
    .BYTE >calc_sub      ; index = 1
    .BYTE >calc_lshift   ; index = 2
    .BYTE >calc_rshift   ; index = 3

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
