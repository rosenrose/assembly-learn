    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

LEN=enums0-nums0
pnums0=$00
pnums1=$02
pres=$04
plen=$06
res=$1000

    lda #<nums0
    sta pnums0
    lda #>nums0
    sta pnums0+1
    lda #<nums1
    sta pnums1
    lda #>nums1
    sta pnums1+1

    lda #<res
    sta pres
    lda #>res
    sta pres+1

    lda #LEN
    sta plen

    jsr arrsum

arrsum: ; (pnums0, pnums1, pres, plen) -> <A, X, Y, P, (pres)>
;=======================================
; summary: (pnums0)와 (pnums1)의 합 계산
;
; arguments: pnums0   배열1의 주소
;            pnums1   배열2의 주소
;            pres     결과 배열의 주소
;            plen     배열의 길이
;
; modifies: A
;           X
;           Y
;           P
;           (pres)
;=======================================
    .SUBROUTINE
    ldy plen
    dey

.loop:
    clc
    lda (pnums0),y
    adc (pnums1),y
    sta (pres),y
    dey
    bpl .loop

    rts

    .ORG $C000,0
nums0:
    .BYTE $01,$02,$03,$04,$05,$06
enums0:
nums1:
    .BYTE $11,$12,$13,$14,$15,$16
enums1:

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000

