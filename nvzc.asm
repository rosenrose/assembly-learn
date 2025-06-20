    .PROCESSOR 6502
    .ORG $8000

out=$4000
    ldx #$FF
    tsx

    clc ; 1. pos + neg = pos
    lda #%00101101 ; 45
    adc #%11011111 ; -33
    sta out
      ; 1 00001100   12
      ; N = 0, V = 0, Z = 0, C = 1

    clc ; 2. pos + neg = neg
    lda #%00101101 ; 45
    adc #%11001110 ; -50
    sta out
      ; 0 11111011 ; -5
      ; N = 1, V = 0, Z = 0, C = 0

    clc ; 3. pos + pos (no overflow)
    lda #%00101101 ; 45
    adc #%01010000 ; 80
    sta out
      ; 0 01111101 ; 125
      ; N = 0, V = 0, Z = 0, C = 0

    clc ; 4. pos + pos (overflow)
    lda #%00101101 ; 45
    adc #%01010011 ; 83
    sta out
      ; 0 10000000 ; -128
      ; N = 1, V = 1, Z = 0, C = 0

    clc ; 5. neg + neg (no overflow)
    lda #%10011100 ; -100
    adc #%11101100 ; -20
    sta out
      ; 1 10001000 ; -120
      ; N = 1, V = 0, Z = 0, C = 1

    clc ; 6. neg + neg (overflow)
    lda #%10011100 ; -100
    adc #%11100011 ; -29
    sta out
      ; 1 01111111 ; 127
      ; N = 0, V = 1, Z = 0, C = 1

    clc ; 7. result = 0
    lda #%10011100 ; -100
    adc #%01100100 ; 100
    sta out
      ; 1 00000000 ; 0
      ; N = 0, V = 0, Z = 1, C = 1

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000

    00011101 1 4 8 16
