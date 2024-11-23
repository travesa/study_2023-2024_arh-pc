%include 'in_out.asm'
section .data
   msg1 db "Введите x: ",0h
   msg2 db "Введите a: ",0h
   msg3 db "Результат: ",0h
global _start
section .bss
   res resb 10
   X resb 10
   A resb 10
section .text
_start:
   mov eax,msg1
   call sprint
   mov ecx,X
   mov edx,10
   call sread
   mov eax,X
   call atoi
   mov [X],eax
   mov eax,msg2
   call sprint
   mov ecx,A
   mov edx,10
   call sread
   mov eax,A
   call atoi
   mov [A],eax ;
   cmp eax,[X]
   je label1
   mov ebx,5
   mov eax,[X]
   mul ebx
   mov [res],eax
   jmp fin
label1:
   mov ecx,[X]
   add eax,ecx
   mov [res],eax
   jmp fin
fin:
   mov eax,msg3
   call sprint
   mov eax,[res]
   call iprintLF
   call quit