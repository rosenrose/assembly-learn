    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

LEN=4
sum=$1000

    clc
    lda #0
    ldx #LEN-1

loop:
    bmi exit
    adc nums,x
    dex
    jmp loop

exit:
    sta sum

    .ORG $C000,0
nums:
    .BYTE $01,$02,$03,$04

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
