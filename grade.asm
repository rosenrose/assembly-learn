    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

out=$4000
in=$4001
    ; == Define input here ==
    lda #63
    sta in
    ; =======================

    lda in

    cmp #90
    bcc grade_b
    lda #'A
    jmp print

grade_b:
    cmp #80
    bcc grade_c
    lda #'B
    jmp print

grade_c:
    cmp #70
    bcc grade_d
    lda #'C
    jmp print

grade_d:
    cmp #60
    bcc grade_f
    lda #'D
    jmp print

grade_f:
    lda #'F

print:
    sta out

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
