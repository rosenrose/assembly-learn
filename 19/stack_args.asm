    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

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

func: ; (s[0]) -> A | <X, P, 0x10, 0x11>
;=======================================
; s[0] / 2 + 1 계산
;=======================================
vtmp=$10
    pla
    sta vtmp
    pla
    sta vtmp+1

    ; s[0]
    pla
    pha ; 스택 복구 1/2단계

    ; s[0] / 2 + 1
    lsr
    clc
    adc #1

    tax
    
    lda vtmp+1 ; 스택 복구 2/2단계
    pha
    lda vtmp
    pha

    txa
    rts

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
