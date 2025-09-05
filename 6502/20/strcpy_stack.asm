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

    ; 스택 복구
    pla
    pla
    pla
    pla

strcpy: ; (s[0], s[2]) -> <A, X, Y, P, 0x00~05, (s[0])>
;=======================================
; summary: (s[2])에서 (s[0])로 문자열 복사
;=======================================
    .SUBROUTINE
vsrc=$00
vdst=vsrc+2

    tsx
    lda PG1+3,x
    sta vdst+1
    lda PG1+4,x
    sta vdst
    lda PG1+5,x
    sta vsrc+1
    lda PG1+6,x
    sta vsrc

    ldy #$FF ; -1

.loop
    iny
    lda (vsrc),y
    sta (vdst),y
    bne .loop

    rts

    .ORG $C000,0
src:
    .BYTE "Hello World"
    .BYTE 0

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
