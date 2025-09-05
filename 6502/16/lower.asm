    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

lower=$80

    ldx #0

loop:
    lda str,x
    beq exit

    cmp #'A
    bcc continue
    cmp #'Z+1
    bcs continue

    ora #%00100000

continue:
    sta lower,x
    inx
    jmp loop

exit:

    .ORG $C000,0
str:
    .BYTE "HeLLo woRLd"
    .BYTE 0 ; 널 문자

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
