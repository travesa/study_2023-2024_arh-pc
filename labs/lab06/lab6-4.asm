%include 'in_out.asm'
SECTION .data
    msg: DB 'Введите число x: ',0
    rem: DB 'Резултат: ',0
SECTION .bss
    x: RESB 80
SECTION .text
GLOBAL _start
 _start:
 mov eax, msg
 call sprintLF ;вывели строку msg
 mov ecx, x
 mov edx, 80
 call sread ;считали ввод с клавиатуры
 mov eax,x
 call atoi ;eax=x
 mov ebx,eax ;ebx=x
 mul eax ;eax=x^2
 mul ebx ;eax=x^3
 xor edx,edx ;edx=0
 xor ebx,ebx ;ebx=0
 mov ebx,2 ;ebx=2
 div ebx ; eax/ebx=eax/2
 add eax,1 ;eax+1
 mov edi,eax
 mov eax,rem
 call sprint
 mov eax,edi
 call iprintLF
 call quit
