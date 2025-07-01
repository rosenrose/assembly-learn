    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

MAX=20
index=$10
out=$11

    clc
    lda #0 ; sum = 0
    ldx #1 ; index = 1

loop:
    cpx #MAX+1
    beq exit

    stx index
    adc index
    inx
    jmp loop

exit:
    sta out


    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
