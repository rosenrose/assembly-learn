    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

; mul() regs
param00=$00
param01=$01
; mul_min_max() regs
param10=$02
param11=$03
var10=$04
; outputs
out10=$05
out11=$06
out12=$07

    lda #3
    sta param00
    lda #5
    sta param01
    jsr mul

    lda #9
    sta param10
    lda #4
    sta param11
    jsr mul_min_max

    sta out10
    stx out11
    sty out12

mul: ; (param00, param01) -> A | <X, P>
;================================
; 두 인자의 곱을 구함
;================================
    .SUBROUTINE
    lda #0
    ldx param01
    clc

.loop:
    beq .ret

    adc param00
    dex
    jmp .loop

.ret:
    rts

mul_min_max: ; (param10, param11) -> A, X, Y | <P>
;=========================================
; summary:   두 인자의 곱, 최솟값, 최댓값을 구함
; arguments: param10    첫 번째 숫자
;            param11    두 번째 숫자
; returns:   A    param10 * param11
;            X    min(param10, param11)
;            Y    max(param10, param11)
; modifies:  P
;=========================================
    .SUBROUTINE

    ; mul
    lda param10
    sta param00
    lda param11
    sta param01
    jsr mul

    ; 임시 저장
    sta var10

    ; min/max
    lda param10
    cmp param11
    bcs .b

    ; param10 < param11
    tax
    ldy param11
    jmp .ret

.b  ; param10 >= param11
    tay
    ldx param11

.ret
    lda var10
    rts

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
