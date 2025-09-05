    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

num0=$1000
num1=$1001
op=$1002
out=$10

    ; == Define input here ==
    lda #12
    sta num0
    
    lda #16
    sta num1
    
    lda #'+
    sta op
    ; =======================

    lda num0 ; A = solution
    ldx op

calc:
    cpx #'+
    bne calc_sub

calc_add:
    clc
    adc num1
    jmp end

calc_sub:
    cpx #'-
    bne calc_lshift

    sec
    sbc num1
    jmp end

calc_lshift:
    cpx #'<
    bne calc_rshift

    ldy num1

lshift_loop:
    beq end

    asl
    dey
    jmp lshift_loop

calc_rshift:
    cpx #'>
    bne end

    ldy num1

rshift_loop:
    beq end

    lsr
    dey
    jmp rshift_loop

end:
    sta out

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
