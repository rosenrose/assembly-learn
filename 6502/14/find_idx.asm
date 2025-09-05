    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

CHAR="l"
idx=$90

    ldx #0 ; X = 결과

loop:
    lda str,x
    beq not_found

    cmp #CHAR
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
    .BYTE 0 ; 널 문자

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
