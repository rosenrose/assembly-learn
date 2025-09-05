    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

dst=$1000
psrc=$00
pdst=$02

    lda #<src
    sta psrc
    lda #>src
    sta psrc+1
    lda #<dst
    sta pdst
    lda #>dst
    sta pdst+1

    jsr strcpy

strcpy: ; (psrc, pdst) -> <A, P, (pdst)>
;=======================================
; summary: (psrc)에서 (pdst)로 문자열 복사
;
; arguments: psrc   원본 문자열의 주소
;            pdst   복사본의 주소
;
; modifies: A
;           P
;           (pdst)
;=======================================
    .SUBROUTINE
    ldy #$FF ; -1

.loop
    iny
    lda (psrc),y
    sta (pdst),y
    bne .loop

    rts

    .ORG $C000,0
src:
    .BYTE "Hello World"
    .BYTE 0

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
