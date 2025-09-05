    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

PG1=$0100
FNADD=0
FNSUB=1
FNLSHIFT=2
FNRSHIFT=3
num0=$4000
num1=$4001
op=$4002    
opaddr=$10
out=$12

    ; == Define input here ==
    lda #12
    sta num0

    lda #16
    sta num1

    lda #FNSUB
    sta op
    ; =======================

    ldx op

    lda table_lo,x
    sta opaddr
    lda table_hi,x
    sta opaddr+1

    pha ; return value
    lda num1
    pha
    lda num0
    pha

    lda #>(ret-1) ; return address. jsr이 아니라서 회귀 주소를 스택에 직접 저장
    pha
    lda #<(ret-1)
    pha

    jmp (opaddr)
ret:
    pla
    pla
    pla
    sta out

end:
    jmp end

calc_add: ;(s[0], s[1]) -> s[2] | <A, X, P>
;================================
; summary:   Calculates s[0] + s[1]
;
; arguments: s[0] 
;            s[1]
;
; returns:   s[2]   s[0] + s[1]
;
; modifies:  A
;            X
;            P
;================================
    tsx

    clc
    lda PG1+3,x
    adc PG1+4,x
    sta PG1+5,x

    rts

calc_sub: ;(s[0], s[1]) -> s[2] | <A, X, P>
;================================
; summary:   Calculates s[0] - s[1]
;
; arguments: s[0] 
;            s[1]
;
; returns:   s[2]   s[0] - s[1]
;
; modifies:  A
;            X
;            P
;================================
    tsx

    sec
    lda PG1+3,x
    sbc PG1+4,x
    sta PG1+5,x

    rts

calc_lshift: ;(s[0], s[1]) -> s[2] | <A, X, Y, P>
;================================
; summary:   Left shift s[0] by s[1]
;
; arguments: s[0] 
;            s[1]
;
; returns:   s[2]   s[0] << s[1]
;
; modifies:  A
;            X
;            Y
;            P
;================================
    .SUBROUTINE
    tsx

    lda PG1+3,x
    ldy PG1+4,x

.loop:
    beq .ret

    asl
    dey
    jmp .loop

.ret:
    sta PG1+5,x
    rts

calc_rshift: ;(s[0], s[1]) -> s[2] | <A, X, Y, P>
;================================
; summary:   Right shift s[0] by s[1]
;
; arguments: s[0] 
;            s[1]
;
; returns:   s[2]   s[0] >> s[1]
;
; modifies:  A
;            X
;            Y
;            P
;================================
    .SUBROUTINE
    tsx

    lda PG1+3,x
    ldy PG1+4,x

.loop:
    beq .ret

    lsr
    dey
    jmp .loop

.ret:
    sta PG1+5,x
    rts

    .ORG $C000,0
table_lo:
    .BYTE <calc_add      ; index = 0
    .BYTE <calc_sub      ; index = 1
    .BYTE <calc_lshift   ; index = 2
    .BYTE <calc_rshift   ; index = 3
table_hi:
    .BYTE >calc_add      ; index = 0
    .BYTE >calc_sub      ; index = 1
    .BYTE >calc_lshift   ; index = 2
    .BYTE >calc_rshift   ; index = 3

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
