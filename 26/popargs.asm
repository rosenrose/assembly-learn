    .PROCESSOR 6502
    .ORG $8000

    ldx #$FF
    txs

    ; push addr to the stack
    .MACRO phaddr ; (addr) <A, S, P>
        lda #<{1}
        pha
        lda #>{1}
        pha
    .ENDM

    ; pop arguments from the stack
    .MACRO popargs ; (startaddr, cnt) <A, X, S, P>
        ldx #{2}-1
.loop
        pla
        sta {1},x
        dex
        bpl .loop
    .ENDM

dst=$1000

    phaddr src
    phaddr dst
    jsr strcpy

end:
    jmp end

strcpy: ; (s[0], s[2]) <A, X, Y, P, 0x00~0x05, (s[0])>
;==========================================
; summary:   copy str from (s[2]) to (s[0])
;
; arguments: s[0]   src
;            s[2]   dst
;
; modifies:  A
;            X
;            Y
;            P
;            0x00~0x05
;==========================================
    .SUBROUTINE
vsrc=$00
vdst=vsrc+2
vretaddr=vdst+2
POPCNT=vretaddr+2-vsrc

    popargs vsrc, POPCNT
    ldy #$FF

.loop
    iny
    lda (vsrc),y
    sta (vdst),y
    bne .loop

    rts

    .ORG $C000,0
src:
    .BYTE "COMP2300"

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000