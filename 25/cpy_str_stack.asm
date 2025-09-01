    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

PG1=$0100
len=estr-str
vstr=$00

    ldx #estr-str-1

pushloop:
    lda str,x
    pha
    dex
    bpl pushloop

    ; 현재 스택포인터 저장
    tsx
    stx vstr

    ; vstr[0] 접근
    ldx vstr

upperloop:
    lda PG1+1,x
    beq exit

    and #%11011111 ; 대문자 변환
    sta PG1+1,x
    inx
    jmp upperloop

exit:
    ; 스택 복구
    lda vstr
    clc
    adc #estr-str
    tax
    txs

    .ORG $C000,0
str:
    .BYTE "abc"
    .BYTE 0
estr:

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000

