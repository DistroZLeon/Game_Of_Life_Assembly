.data
Board: .space 1600
CBoard: .space 1600
n: .space 4
m: .space 4
p: .space 4
k: .space 4
i: .space 4
j: .space 4
Index: .space 4
genIndex: .space 4
columnIndex: .space 4
lineIndex: .space 4
formatScanf: .asciz "%d"
formatPrintf: .asciz "%d "
newLine: .asciz "\n"
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
je et_afis_matr
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

et_afis_matr:
movl $1, lineIndex
for_lines:
movl lineIndex, %ecx
cmpl %ecx, m
je et_exit
movl $1, columnIndex
for_columns:
movl columnIndex, %ecx
cmpl %ecx, n
je cont2
movl n, %eax
incl %eax
movl %eax, n
movl lineIndex, %eax
movl $0, %edx
mull n
addl columnIndex, %eax
lea Board, %edi
movl (%edi, %eax, 4), %ebx
pushl %ebx
pushl $formatPrintf
call printf
add $8, %esp
pushl $0
call fflush
add $4, %esp
movl n, %eax
decl %eax
movl %eax, n
incl columnIndex
jmp for_columns
cont2:
movl $4, %eax
movl $1, %ebx
movl $newLine, %ecx
movl $2, %edx
int $0x80
incl lineIndex
jmp for_lines

et_exit:
pushl $0
call fflush
addl $4, %esp

mov $1, %eax
mov $0, %ebx
int $0x80