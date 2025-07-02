    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

len=$90

    ldx #0 ; X = 결과

loop:
    lda str,x
    beq exit
    inx
    jmp loop

exit:
    stx len

    .ORG $C000,0
str:
    .BYTE "Hello World"
    .BYTE 0 ; 널 문자

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
