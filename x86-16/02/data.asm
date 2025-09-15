TITLE data

.DOSSEG
.8086
.NO87
.MODEL TINY

.DATA
i8    DB 23
i16_0 DW 12*53
i16_1 DW 1234h
i32   DD 2147483647
i64   DQ 9223372036854775807
empty DQ ?

num0  DD 1234h
ALIGN 2
num1  DB 12h

num2  DW 5678h
EVEN
num3  DB 12h

float    DD 98.6
flaot2   DD 87453333r ; 98.6
double   DQ 9.312E-7
edouble  DQ 3EAF3EF274A03CABr ; 9.312E-7
ten_byte DT 7.341E9

str0 DB 'Hello DOS',13,10,'$'
str1 DB "Hello bios",0
str2 DB "ab" ; 61 62
str3 DW "ab" ; 62 61
str4 DD "ab" ; 62 61 00 00
str5 DD "a"  ; 61 00 00

nums   DB 1,2,3,4,5
arr    DB 20 DUP (2)
masks  DB 10 DUP (30h,20h,01h,09h)
str6   DB 5 DUP ("Hello, x86",0)
ddd    DD 2 DUP (2 DUP(2 DUP(1)))
buffer DB 128 DUP (?)

tmp DB 0FFh

barray LABEL BYTE     ; array와 동일
warray LABEL WORD     ; array를 60개의 word로 접근
darray LABEL DWORD    ; array를 30개의 doubleword로 접근
qarray LABEL QWORD    ; array를 15개의 quadword로 접근
farray LABEL FWORD    ; array를 20개의 farword로 접근
tarray LABEL TBYTE    ; array를 12개의 10-byte로 접근
array  DB 120 DUP (?) ; 120바이트 크기의 배열

msg     DB "foobar",0
nearptr DW msg
;farptr  DD msg

END
