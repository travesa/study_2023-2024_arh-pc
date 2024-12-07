%include 'in_out.asm'
SECTION .data
 msg1 db "Введите х: ",0
 msg2 db "4x-3 = ",0
SECTION .bss
 x: RESB 80
 tmp: RESB 80
SECTION .text
 global _start
_start:
 mov eax,msg1
 call sprint
 mov ecx,x
 mov edx,80
 call sread
 mov eax,x
 call atoi
 call _calcul
 mov eax,msg2
 call sprint
 mov eax,[tmp]
 call iprintLF
 call quit
    _calcul:
    mov ebx,4
    mul ebx
    sub eax,3
    mov [tmp],eax
    ret