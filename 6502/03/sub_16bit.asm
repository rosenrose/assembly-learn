    .PROCESSOR 6502
    .ORG $8000

A_H=%00000000
A_L=%00001100 ; 00000000 00001100 12
M_H=%00000100
M_L=%00000001 ; 00000100 00000001 1025
outl=$2000
outh=outl+1
    ldx #$FF
    txs

    sec       ; c=1
    lda #A_L
    sbc #M_L  ; c==1
    sta outl

    lda #A_H
    sbc #M_H  ; c==0
    sta outh
    ; 11111100 00001011 -1013

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
