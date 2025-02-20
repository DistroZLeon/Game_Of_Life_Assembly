.data
Board: .space 1600
CBoard: .space 1600
dime: .space 4
l: .space 4
n: .space 4
m: .space 4
p: .space 4
k: .space 4
i: .space 4
j: .space 4
lungime: .space 4
cript: .space 4
Index: .space 4
genIndex: .space 4
columnIndex: .space 4
lineIndex: .space 4
mesaj: .space 24
cmesaj: .space 24
pmesaj: .space 24
formatsirprint: .asciz "%s\n"
formatsir: .asciz "%s"
formatScanf: .asciz "%d"
formatPrintf: .asciz "%d\n"
.text
.global main
decizie:
pushl %ebp
movl %esp, %ebp
cmpl $1, 8(%ebp)
je s1
cmpl $3, 12(%ebp)
je s1_cv
movl $0, %eax
pop %ebp
ret
s1:
cmpl $2, 12(%ebp)
je s1_cv
cmpl $3, 12(%ebp)
je s1_cv
movl $0, %eax
pop %ebp
ret
s1_cv:
movl $1, %eax
pop %ebp
ret

verificare:
pushl %ebp
movl %esp, %ebp
pushl %ebx
movl 8(%ebp), %ecx
movl 12(%ebp), %ebx
cmp %ecx, %ebx
jle rein
movl %ecx, %edx
pop %ebx
pop %ebp
ret
rein:
xor %edx, %edx
pop %ebx
pop %ebp
ret

main:
pushl $m
pushl $formatScanf
call scanf
add $8, %esp

pushl $n
pushl $formatScanf
call scanf
add $8, %esp

pushl $p
pushl $formatScanf
call scanf
add $8, %esp

movl n, %eax
addl $2, %eax
movl %eax, n

movl m, %eax
addl $2, %eax
movl %eax, m
movl $0, lineIndex 

movl $0, Index

et_citire_matrice:
movl Index, %ecx
cmpl %ecx, p
je cont1
pushl $lineIndex
pushl $formatScanf
call scanf
add $8, %esp
pushl $columnIndex
pushl $formatScanf
call scanf
add $8, %esp
movl lineIndex, %eax
incl %eax
movl %eax, lineIndex
movl columnIndex, %eax
incl %eax
movl %eax, columnIndex
movl lineIndex, %eax
movl $0, %edx
mull n
addl columnIndex, %eax
lea Board, %edi
movl $1, (%edi, %eax, 4)
incl Index
jmp et_citire_matrice

cont1:
pushl $k
pushl $formatScanf
call scanf
addl $8, %esp

movl $0, genIndex

movl n, %eax
decl %eax
movl %eax, n

movl m, %eax
decl %eax
movl %eax, m

et_generatii:
movl genIndex,%ecx
cmpl %ecx, k
je cor
movl $1, lineIndex
et_prelucrare_l:
movl lineIndex, %ecx
cmpl %ecx, m
je cont3
movl $1, columnIndex
et_prelucrare_c:
movl columnIndex, %ecx
cmpl %ecx, n
je cont10
movl n, %eax
incl %eax
movl %eax, n
movl lineIndex, %eax
movl $0, %edx
mull n
addl columnIndex, %eax
movl %eax, Index
lea Board, %edi
movl (%edi, %eax, 4), %ebx
xor %edx, %edx

subl n, %eax
decl %eax
addl (%edi, %eax, 4), %edx
incl %eax
addl (%edi, %eax, 4), %edx
incl %eax
addl (%edi, %eax, 4), %edx
addl n, %eax
addl (%edi, %eax, 4), %edx
subl $2, %eax
addl (%edi, %eax, 4), %edx
addl n, %eax
addl (%edi, %eax, 4), %edx
incl %eax
addl (%edi, %eax, 4), %edx
incl %eax
addl (%edi, %eax, 4), %edx

pushl %edx
pushl %ebx
call decizie
pop %ebx
addl $4, %esp

lea CBoard, %edi
movl Index, %ebx
movl %eax, (%edi, %ebx, 4)
movl n, %eax
decl %eax
movl %eax, n
incl columnIndex
jmp et_prelucrare_c
cont10:
incl lineIndex
jmp et_prelucrare_l

cont3:
movl $1, i
for_l_cop:
movl i, %ecx
cmpl %ecx, m
je cont4
movl $1, j
for_c_cop:
movl j, %ecx
cmpl %ecx, n
je cont5
movl n, %eax
incl %eax
movl %eax, n
movl i, %eax
xor %edx, %edx
mull n
addl j, %eax
lea CBoard, %edi
xor %edx, %edx
addl (%edi, %eax, 4), %edx
lea Board, %edi
movl %edx, (%edi, %eax, 4)
movl n, %eax
decl %eax
movl %eax, n
incl j
jmp for_c_cop
cont5:
incl i
jmp for_l_cop
cont4:
incl genIndex
jmp et_generatii

cor:
pushl $cript
pushl $formatScanf
call scanf
addl $8, %esp
addl $8, %esp
pushl $mesaj
pushl $formatsir
call scanf
addl $8, %esp
cmpl $0, cript
je ind
movl $2, %eax
xor %ecx, %ecx
jmp len

ind:
xor %eax, %eax
xor %ecx, %ecx

len:
lea mesaj, %edi
cmpl $0, (%edi, %eax, 1)
je cop
incl %ecx
incl %eax
jmp len

cop:
movl %ecx, lungime
incl m
movl n, %eax
incl %eax
movl %eax, n
xor %edx, %edx
mull m
movl %eax, dime
movl $0, Index
xor %ebx, %ebx
cmpl $1, cript
je def

sir:
movl Index, %ecx
cmpl %ecx, lungime
je cot
xor %eax, %eax
lea Board, %edi
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
incl %ebx
lea mesaj, %edi
movl Index, %edx
xorb (%edi, %edx, 1), %al
lea cmesaj, %edi
movb %al, (%edi, %edx, 1)
incl Index
jmp sir
cot:
movl $0, Index
movl $1, l

efectuare:
movl Index, %ecx
cmpl lungime, %ecx
je col
xor %eax, %eax
xor %ebx, %ebx
lea cmesaj, %edi
movb (%edi, %ecx, 1), %al
movb (%edi, %ecx, 1), %bl
and $15, %al
shr $4, %bl
incl l
movl l, %edx
lea pmesaj, %edi
movb %bl, (%edi, %edx, 1 )
incl %edx
movb %al, (%edi, %edx, 1)
movl %edx, l
incl Index
jmp efectuare

col:
movl $0, Index
incl l
xor %eax, %eax

traducere:
movl Index, %ecx
cmp l, %ecx
je detaliu
lea pmesaj, %edi
movb (%edi, %ecx, 1), %al
cmp $9, %al
jle conv
subb $10, %al
addb $'A', %al
movb %al, (%edi, %ecx, 1)
incl Index
jmp traducere
conv:
addb $'0', %al
movb %al, (%edi, %ecx, 1)
incl Index
jmp traducere
detaliu:
lea pmesaj, %edi
movl $1, %eax
movb $'x', (%edi, %eax, 1)
jmp afisare

def:
movl $2, Index
incl lungime
incl lungime
nero:
movl Index, %ecx
cmpl lungime, %ecx
je mon
lea mesaj, %edi
xor %eax, %eax
cmpb $'A', (%edi, %ecx, 1)
jge tr
movb (%edi, %ecx, 1), %al
subb $'0', %al
movb %al, (%edi, %ecx, 1)
incl Index
jmp nero
tr:
movb (%edi, %ecx, 1), %al
subb $'A', %al
addb $10, %al
movb %al, (%edi, %ecx, 1)
incl Index
jmp nero
mon:
movl $2, columnIndex
movl $0, Index
tip:
movl columnIndex, %ecx
cmpl lungime, %ecx 
je afara
lea mesaj, %edi
xor %eax, %eax
movb (%edi, %ecx, 1), %al
shl $4, %al
incl %ecx
addb (%edi, %ecx, 1), %al
incl %ecx
movl Index, %edx
lea cmesaj, %edi
movb %al, (%edi, %edx, 1)
movl %ecx, columnIndex
pushl %eax
incl Index
jmp tip

afara:
xor %eax, %eax
xor %ecx, %ecx
lea cmesaj, %edi

len2:
cmpl $0, (%edi, %eax, 1)
je coa
incl %ecx
incl %eax
jmp len2

coa:
movl %ecx, lungime
movl $0, Index
xor %ebx, %ebx

sirc:
movl Index, %ecx
cmpl %ecx, lungime
je afisare
xor %eax, %eax
lea Board, %edi
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
shl %eax
incl %ebx
pushl dime
pushl %ebx
call verificare
addl $8, %esp
movl %edx, %ebx
addl (%edi,%ebx,4), %eax
incl %ebx
lea cmesaj, %edi
movl Index, %edx
xorb (%edi, %edx, 1), %al
lea pmesaj, %edi
movb %al, (%edi, %edx, 1)
incl Index
jmp sirc

afisare: 
pushl $pmesaj
pushl $formatsirprint
call printf
addl $8, %esp

et_exit: 
pushl $0
call fflush
addl $4, %esp

mov $1, %eax
mov $0, %ebx
int $0x80
