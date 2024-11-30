%include 'in_out.asm'
SECTION .data
 msg2 db "Результат: ",0
 msg1 db "Функция: f(x)=4x-3",0
SECTION .bss
 tmp: RESB 80
SECTION .text
 global _start
_start:
 pop ecx
 pop edx
 sub ecx,1
 mov esi, 4
next:
 cmp ecx,0h
 jz _end
 pop eax
 call atoi
 mul esi
 sub eax,3
 add [tmp],eax
 loop next
_end:
 mov eax, msg1
 call sprintLF
 mov eax, msg2
 call sprint
 mov eax, [tmp]
 call iprintLF
 call quit