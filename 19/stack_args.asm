    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

PG1=$0100 ; 페이지 1은 스택 시작주소
out=$12

    lda #4
    pha
    jsr func
    sta out
    pla

    lda #104
    pha
    jsr func
    sta out+1
    pla

    lda #27
    pha
    jsr func
    sta out+2
    pla

func: ; (s[0]) -> A | <X, P>
;=======================================
; s[0] / 2 + 1 계산
;=======================================
    tsx
    
    lda PG1+3,x
    lsr
    clc
    adc #1

    rts

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
