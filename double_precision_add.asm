    .PROCESSOR 6502
    .ORG $8000

NUM0=%01101000
NUM1=%10011010
outl=$2000
outh=outl+1
    ldx #$FF
    txs

    clc         ; c=0
    lda #NUM0
    adc #NUM1   ; c==1
    sta outl
    lda #0
    adc #0      ; c==0
    sta outh

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
