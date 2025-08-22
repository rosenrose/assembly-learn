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

pmin=$05
pmax=$07
mul_res=$1000
min=$1001
max=$1002

    lda #9
    sta param10
    lda #4
    sta param11

    lda #<min
    sta pmin
    lda #>min
    sta pmin+1
    lda #<max
    sta pmax
    lda #>max
    sta pmax+1

    jsr mul_min_max
    sta mul_res

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

mul_min_max: ; (param10, param11, pmin, pmax) -> A, (pmin), (pmin) | <X, Y, P>
;=========================================
; summary:   두 인자의 곱, 최솟값, 최댓값을 구함
;
; arguments: param10    첫 번째 숫자
;            param11    두 번째 숫자
;            pmin       최솟값 저장 주소
;            pmax       최댓값 저장 주소
;
; returns:   A          param10 * param11
;            (pmin)     min(param10, param11)
;            (pmax)     max(param10, param11)
;
; modifies:  X
;            Y
;            P
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

    ldy #0

    ; min/max
    lda param10
    cmp param11
    bcs .geq

    ; param10 < param11
    sta (pmin),y
    lda param11
    sta (pmax),y
    jmp .ret

.geq ; param10 >= param11
    sta (pmax),y
    lda param11
    sta (pmin),y

.ret
    lda var10
    rts

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
