    .PROCESSOR 6502
    .ORG $8000

sum=$1000

    clc
    lda nums
    adc nums+1
    adc nums+2
    adc nums+3
    sta sum

    .ORG $C000,0
nums:
    .BYTE $00,$01,$02,$03
hello:
    .BYTE "Hello, world!"
    .BYTE 0 ; 널 문자
    .WORD $1000,$1001

    .ORG $FFFC,0
    .WORD $8000
    .WORD $0000
