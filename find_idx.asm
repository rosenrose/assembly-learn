    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

LEN=estr-str
CHAR="l"
idx=$90

    lda #CHAR
    ldx #0 ; X = 결과

loop:
    cpx #LEN
    beq not_found

    cmp str,x
    beq exit
    inx
    jmp loop

not_found:
    ldx #-1

exit:
    stx idx

    .ORG $C000,0
str:
    .BYTE "Hello World"
estr:

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
