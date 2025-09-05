    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

pcnt=$00
ret=$01
pstrs=$02

    lda #3
    sta pcnt

    lda #<str0
    sta pstrs
    lda #>str0
    sta pstrs+1

    lda #<str1
    sta pstrs+2
    lda #>str1
    sta pstrs+3

    lda #<str2
    sta pstrs+4
    lda #>str2
    sta pstrs+5

    jsr strslen

strslen: ; (pcnt, pstrs) -> ret | <A, X, P>
;=======================================
; summary: 문자열 길이의 합을 구함
;
; arguments: pcnt   문자열 개수 (> 0)
;            pstrs  문자열 주소들
;
; returns:   ret    문자열 길이의 합
;=======================================
    .SUBROUTINE
    ; X = pcnt * 2
    lda pcnt
    asl
    tax

    clc
    lda #0

.loop
    adc (pstrs-2,x)
    dex
    dex
    bne .loop

    sta ret
    rts

    .ORG $C000,0
str0:
    .BYTE $05,"apple"
str1:
    .BYTE $06,"banana"
str2:
    .BYTE $04,"kiwi"

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000

