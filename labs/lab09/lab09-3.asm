%include 'in_out.asm'
SECTION .text
 global _start
_start:
 pop ecx ; Извлекаем из стека в `ecx` количество
 ; аргументов (первое значение в стеке)
 pop edx ; Извлекаем из стека в `edx` имя программы
 ; (второе значение в стеке)
 sub ecx, 1 ; Уменьшаем `ecx` на 1 (количество
 ; аргументов без названия программы)
next:
 cmp ecx, 0 ; проверяем, есть ли еще аргументы
 jz _end ; если аргументов нет выходим из цикла
 ; (переход на метку `_end`)
 pop eax ; иначе извлекаем аргумент из стека
 call sprintLF ; вызываем функцию печати
 loop next ; переход к обработке следующего
 ; аргумента (переход на метку `next`)
_end:
 call quit
