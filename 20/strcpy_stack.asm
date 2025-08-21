    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

dst=$1000
PG1=$0100

    lda #<src
    pha
    lda #>src
    pha
    lda #<dst
    pha
    lda #>dst
    pha

    jsr strcpy

strcpy: ; (s[0], s[2]) -> <A, X, Y, P, 0x00~05, (s[0])>
;=======================================
; summary: (s[2])에서 (s[0])로 문자열 복사
;=======================================
    .SUBROUTINE
vsrc=$00
vdst=vsrc+2
vretaddr=vdst+2
POPCNT=vretaddr+2-vsrc

    ldx #POPCNT-1

.poploop
    pla
    sta vsrc,x
    dex
    bpl .poploop

    ldy #$FF ; -1

.loop
    iny
    lda (vsrc),y
    sta (vdst),y
    bne .loop

    ; 스택 복구
    lda vretaddr
    pha
    lda vretaddr+1
    pha

    rts

    .ORG $C000,0
src:
    .BYTE "Hello World"
    .BYTE 0

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
