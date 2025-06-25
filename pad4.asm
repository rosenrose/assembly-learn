    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

out=$4000
column=$4001
    ; LCD에 문자열을 출력하는 코드
    ; thanks..
    ldx #6
    ldy #6
    ; X == 문자열 길이
    ; Y == LCD 커서의 열 위치
    txa
    and #%00000011

    beq pad0

    ldx #'.

    cmp #3
    beq pad1

    cmp #2
    beq pad2

    stx out
    iny
    sty column

pad2:
    stx out
    iny
    sty column

pad1:
    stx out
    iny
    sty column

pad0:

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
