TITLE Convert Hex To Binary

.DOSSEG
.8086
.NO87
.MODEL TINY

.DATA
NUM_DIGITS EQU 4
BUFSIZE    EQU NUM_DIGITS+1
newline    DB 0Dh, 0Ah, '$'
prompt     DB "Enter 4-digit hex number: $"
buffer_in  DB BUFSIZE
           DB BUFSIZE+1 DUP(?)
result     DB "Binary: "
buffer_out DB NUM_DIGITS*4 + 1 DUP(?)
lookup     DB "0000", "0001", "0010", "0011",
              "0100", "0101", "0110", "0111",
              "1000", "1001", "1010", "1011",
              "1100", "1101", "1110", "1111"

.CODE
.STARTUP
; print string to console
PRINTSTR MACRO str ; (str) <ah, dx>
    lea dx, str
    mov ah, 9h
    int 21h
ENDM

    PRINTSTR prompt

    lea dx, buffer_in
    mov ah, 0Ah
    int 21h

    PRINTSTR newline

    cld
    xor ax, ax
    mov ch, 0h
    mov cl, buffer_in[1] ; cx를 입력 문자열의 길이로 초기화
    lea si, buffer_in + 2 ; 문자열의 시작
    lea di, buffer_out

convert_loop:
    jcxz print_result
    lodsb
    cmp al, 'A'
    jb is_numeric
    and al, NOT 20h ; 대문자로 변환
    sub al, 'A' - 10 - '0'

is_numeric:
    sub al, '0'
    shl al, 1
    shl al, 1
    lea bx, lookup
    add bx, ax

    ; buffer_out을 이진수 문자열로 채워넣음
    push si
    mov dx, cx

    mov si, bx
    mov cx, 4
    rep movsb

    mov cx, dx
    pop si

    dec cx
    jmp convert_loop

print_result:
    mov BYTE PTR [di], '$'

    PRINTSTR result

    mov ah, 4Ch
    xor al, al
    int 21h

END
