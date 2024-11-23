%include 'in_out.asm'
section .data
   msg1 db "Наименьшее число: ",0h
   A dd '79'
   B dd '83'
   C dd '41'
global _start
section .bss
   min resb 10
section .text
_start:
   mov ecx,[A]
   mov [min],ecx
   cmp ecx,[C]
   jl label1
   mov ecx,[C]
   mov [min],ecx
label1:
   mov eax,min
   call atoi
   mov [min],eax
   mov ecx,[min]
   cmp ecx,[B]
   jl fin
   mov ecx,[B]
   mov [min],ecx
fin:
   mov eax, msg1
   call sprint
   mov eax,[min]
   call iprintLF
   call quit

