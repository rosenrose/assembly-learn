    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

num=$20
denom=$21
res=$22

    ; == Define operands here ==
    lda #45
    sta num
    
    lda #4
    sta denom
    ; =======================

    ldx #0 ; X = solution

    sec
    lda num
    sbc denom

loop:
    bmi end

    inx
    sbc denom

    jmp loop

end:
    stx res

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
