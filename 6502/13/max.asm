    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

LEN=enums-nums
max=$90

    lda nums
    ldx #LEN-1

loop:
    beq exit
    cmp nums,x
    bcs continue
    lda nums,x

continue:
    dex
    jmp loop

exit:
    sta max

    .ORG $C000,0
nums:
    .BYTE $03,$32,$A0,$C7
enums:

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
