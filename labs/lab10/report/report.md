---
## Front matter
title: "Отчёт по лабораторной работе №10"

author: "Петлин Артём Дмитриевич"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Приобретение навыков написания программ для работы с файлами.

# Задание

1. Напишите программу работающую по следующему алгоритму:

   - Вывод приглашения “Как Вас зовут?”
   - ввести с клавиатуры свои фамилию и имя
   - создать файл с именем name.txt
   - записать в файл сообщение “Меня зовут”
   - дописать в файл строку введенную с клавиатуры
   - закрыть файл

Создать исполняемый файл и проверить его работу. Проверить наличие файла и его
содержимое с помощью команд ls и cat.
 
# Теоретическое введение

## Права доступа к файлам

ОС GNU/Linux является многопользовательской операционной системой. И для обеспечения защиты данных одного пользователя от действий других пользователей существуют
специальные механизмы разграничения доступа к файлам. Кроме ограничения доступа, данный механизм позволяет разрешить другим пользователям доступ данным для совместной
работы.  
Права доступа определяют набор действий (чтение, запись, выполнение), разрешённых
для выполнения пользователям системы над файлами. Для каждого файла пользователь
может входить в одну из трех групп: владелец, член группы владельца, все остальные. Для
каждой из этих групп может быть установлен свой набор прав доступа. Владельцем файла
является его создатель. Для предоставления прав доступа другому пользователю или другой
группе командой  

       chown [ключи] <новый_пользователь>[:новая_группа] <файл>  
       
     или  
     
       chgrp [ключи] < новая_группа > <файл>  
       
Набор прав доступа задается тройками битов и состоит из прав на чтение, запись и исполнение файла. В символьном представлении он имеет вид строк rwx, где вместо любого
символа может стоять дефис. Всего возможно 8 комбинаций, приведенных в таблице 10.1.
Буква означает наличие права (установлен в единицу второй бит триады r — чтение, первый
бит w — запись, нулевой бит х — исполнение), а дефис означает отсутствие права (нулевое
значение соответствующего бита). Также права доступа могут быть представлены как восьмеричное число. Так, права доступа rw- (чтение и запись, без исполнения) понимаются как
три двоичные цифры 110 или как восьмеричная цифра 6.  
Полная строка прав доступа в символьном представлении имеет вид:  

       <права_владельца> <права_группы> <права_остальных>  

Так, например, права rwx r-x --x выглядят как двоичное число 111 101 001, или восьмеричное 751.  
Свойства (атрибуты) файлов и каталогов можно вывести на терминал с помощью команды
ls с ключом -l. Так например, чтобы узнать права доступа к файлу README можно узнать с
помощью следующей команды:  

       $ls -l /home/debugger/README  
       -rwxr-xr-- 1 debugger users 0 Feb 14 19:08 /home/debugger/README  

В первой колонке показаны текущие права доступа, далее указан владелец файла и группа:

![](image/rule.jpg){#fig:001 width=100%}  

Тип файла определяется первой позицией, это может быть: каталог — d, обычный файл
— дефис (-) или символьная ссылка на другой файл — l. Следующие 3 набора по 3 символа
определяют конкретные права для конкретных групп: r — разрешено чтение файла, w —
разрешена запись в файл; x — разрешено исполнение файл и дефис (-) — право не дано.  
Для изменения прав доступа служит команда chmod, которая понимает как символьное,
так и числовое указание прав. Для того чтобы назначить файлу /home/debugger/README
права rw-r, то есть разрешить владельцу чтение и запись, группе только чтение, остальным
пользователям — ничего:  

       $chmod 640 README # 110 100 000 == 640 == rw-r-----  
       $ls -l README  
       -rw-r 1 debugger users 0 Feb 14 19:08 /home/debugger/README  

В символьном представлении есть возможность явно указывать какой группе какие права
необходимо добавить, отнять или присвоить. Например, чтобы добавить право на исполнение файла README группе и всем остальным:  

       $chmod go+x README  
       $ls -l README  
       -rw-r-x--x 1 debugger users 0 Feb 14 19:08 /home/debugger/README  
       
Формат символьного режима:  

       chmod <категория><действие><набор_прав><файл>  

## Работа с файлами средствами Nasm

В операционной системе Linux существуют различные методы управления файлами, например, такие как создание и открытие файла, только для чтения или для чтения и записи,
добавления в существующий файл, закрытия и удаления файла, предоставление прав доступа.  
Обработка файлов в операционной системе Linux осуществляется за счет использования
определенных системных вызовов. Для корректной работы и доступа к файлу при его открытии или создании, файлу присваивается уникальный номер (16-битное целое число) –
дескриптор файла.  
Общий алгоритм работы с системными вызовами в Nasm можно представить в следующем
виде:

1. Поместить номер системного вызова в регистр EAX;
2. Поместить аргументы системного вызова в регистрах EBX, ECX и EDX;
3. Вызов прерывания (int 80h);
4. Результат обычно возвращается в регистр EAX.

### Открытие и создание файла
Для создания и открытия файла служит системный вызов sys_creat, который использует
следующие аргументы: права доступа к файлу в регистре ECX, имя файла в EBX и номер
системного вызова sys_creat (8) в EAX.  

       mov ecx, 0777o ; установка прав доступа  
       mov ebx, filename ; имя создаваемого файла  
       mov eax, 8 ; номер системного вызова `sys_creat`  
       int 80h ; вызов ядра  

Для открытия существующего файла служит системный вызов sys_open, который использует следующие аргументы: права доступа к файлу в регистре EDX, режим доступа к файлу в
регистр ECX, имя файла в EBX и номер системного вызова sys_open (5) в EAX.
Среди режимов доступа к файлам чаще всего используются:  

       (0) – O_RDONLY (открыть файл в режиме только для чтения);  
       (1) – O_WRONLY – (открыть файл в режиме только записи);  
       (2) – O_RDWR – (открыть файл в режиме чтения и записи).  

С другими режимами доступа можно ознакомиться в https://man7.org/.
Системный вызов возвращает файловый дескриптор открытого файла в регистр EAX. В
случае ошибки, код ошибки также будет находиться в регистре EAX.  

       mov ecx, 0 ; режим доступа (0 - только чтение)  
       mov ebx, filename ; имя открываемого файла  
       mov eax, 5 ; номер системного вызова `sys_open`  
       int 80h ; вызов ядра  

### Запись в файл

Для записи в файл служит системный вызов sys_write, который использует следующие
аргументы: количество байтов для записи в регистре EDX, строку содержимого для записи
ECX, файловый дескриптор в EBX и номер системного вызова sys_write (4) в EAX.  
Системный вызов возвращает фактическое количество записанных байтов в регистр EAX.
В случае ошибки, код ошибки также будет находиться в регистре EAX.  
Прежде чем записывать в файл, его необходимо создать или открыть, что позволит получить дескриптор файла.  

       mov ecx, 0777o ; Создание файла.  
       mov ebx, filename ; в случае успешного создания файла,  
       mov eax, 8 ; в регистр eax запишется дескриптор файла  
       int 80h  
       mov edx, 12 ; количество байтов для записи  
       mov ecx, msg ; адрес строки для записи в файл  
       mov ebx, eax ; дескриптор файла  
       mov eax, 4 ; номер системного вызова `sys_write`  
       int 80h ; вызов ядра  

### Чтение файла

Для чтения данных из файла служит системный вызов sys_read, который использует
следующие аргументы: количество байтов для чтения в регистре EDX, адрес в памяти для
записи прочитанных данных в ECX, файловый дескриптор в EBX и номер системного вызова
sys_read (3) в EAX. Как и для записи, прежде чем читать из файла, его необходимо открыть,
что позволит получить дескриптор файла.  

       mov ecx, 0 ; Открытие файла.  
       mov ebx, filename ; в случае успешного открытия файла,  
       mov eax, 5 ; в регистр EAX запишется дескриптор файла  
       int 80h  
       mov edx, 12 ; количество байтов для чтения  
       mov ecx, fileCont ; адрес в памяти для записи прочитанных данных  
       mov ebx, eax ; дескриптор файла  
       mov eax, 3 ; номер системного вызова `sys_read`  
       int 80h ; вызов ядра  

### Закрытие файла

Для правильного закрытия файла служит системный вызов sys_close, который использует
один аргумент – дескриптор файла в регистре EBX. После вызова ядра происходит удаление
дескриптора файла, а в случае ошибки, системный вызов возвращает код ошибки в регистр
EAX.  

       mov ecx, 0 ; Открытие файла.  
       mov ebx, filename ; в случае успешного открытия файла,  
       mov eax, 5 ; в регистр EAX запишется дескриптор файла  
       int 80h  
       mov ebx, eax ; дескриптор файла  
       mov eax, 6 ; номер системного вызова `sys_close`  
       int 80h ; вызов ядра  

### Изменение содержимого файла

Для изменения содержимого файла служит системный вызов sys_lseek, который использует следующие аргументы: исходная позиция для смещения EDX, значение смещения в
байтах в ECX, файловый дескриптор в EBX и номер системного вызова sys_lseek (19) в EAX.
Значение смещения можно задавать в байтах. Значения обозначающие исходную позиции
могут быть следующими:  

       (0) – SEEK_SET (начало файла);  
       (1) – SEEK_CUR (текущая позиция);  
       (2) – SEEK_END (конец файла).  
   
В случае ошибки, системный вызов возвращает код ошибки в регистр EAX.

       mov ecx, 1 ; Открытие файла (1 - для записи).  
       mov ebx, filename  
       mov eax, 5  
       int 80h  
       mov edx, 2 ; значение смещения -- конец файла  
       mov ecx, 0 ; смещение на 0 байт  
       mov ebx, eax ; дескриптор файла  
       mov eax, 19 ; номер системного вызова `sys_lseek`  
       int 80h ; вызов ядра  
       mov edx, 9 ; Запись в конец файла  
       mov ecx, msg ; строки из переменной `msg`  
       mov eax, 4  
       int 80h  

### Удаление файла

Удаление файла осуществляется системным вызовом sys_unlink, который использует
один аргумент – имя файла в регистре EBX.  

       mov ebx, filename ; имя файла  
       mov eax, 10 ; номер системного вызова `sys_unlink`  
       int 80h ; вызов ядра  
       
В качестве примера приведем программу, которая открывает существующий файл, записывает в него сообщение и закрывает файл.  

Результат работы программы:

       user@dk4n31:~$ nasm -f elf -g -l main.lst main.asm  
       user@dk4n31:~$ ld -m elf_i386 -o main main.o  
       user@dk4n31:~$ ./main  
       Введите строку для записи в файл: Hello world!  
       user@dk4n31:~$ ls -l  
       -rwxrwxrwx 1 user user 20 Jul 2 13:06 readme.txt  
       -rwxrwxrwx 1 user user 11152 Jul 2 13:05 main  
       -rwxrwxrwx 1 user user 1785 Jul 2 13:03 main.asm  
       -rwxrwxrwx 1 user user 22656 Jul 2 13:05 main.lst  
       -rwxrwxrwx 1 user user 4592 Jul 2 13:05 main.o  
       user@dk4n31:~$ cat readme.txt  
       Hello world!  
       user@dk4n31:~$  

# Выполнение лабораторной работы

![](image/1.jpg){#fig:001 width=100%}  

Переходим в каталог для программам лабораторной работы № 10 и
создаём файлы lab10-1.asm, readme-1.txt и readme-2.txt:

![](image/2.jpg){#fig:001 width=100%}  
![](image/3.jpg){#fig:001 width=100%}  

Вводим в файл lab10-1.asm текст программы из листинга 10.1 (Программа записи в
файл сообщения). Создаём исполняемый файл и проверяем его работу. Программа работает корректно.

![](image/4.jpg){#fig:001 width=100%}  

С помощью команды chmod изменяем права доступа к исполняемому файлу lab10-1,
запретив его выполнение. Пытаемся выполнить файл, получаем "permission denied", потому что мы поставили запрет на выполнение программы.

![](image/5.jpg){#fig:001 width=100%}  

С помощью команды chmod изменяем права доступа к файлу lab10-1.asm с исходным текстом программы, добавив права на исполнение. Пытаемся выполнить файл, это не удается, потому что такие файлы нужно компилировать в машинный код, а потом выполнять.


**Вариант 6**

![](image/6.jpg){#fig:001 width=100%}  

Используем команду chmod для предоставления нудных прав и проверяем сделанное командой ls -l.

# Задание для самостоятельной работы

Создадим новый файл lab10-2.asm и напишем в нем программу работающую по следующему алгоритму:

   - Вывод приглашения “Как Вас зовут?”
   - ввести с клавиатуры свои фамилию и имя
   - создать файл с именем name.txt
   - записать в файл сообщение “Меня зовут”
   - дописать в файл строку введенную с клавиатуры
   - закрыть файл


![](image/7.jpg){#fig:001 width=100%}  
![](image/8.jpg){#fig:001 width=100%}  
![](image/9.jpg){#fig:001 width=100%}  
![](image/10.jpg){#fig:001 width=100%}  

Программа работает корректно

# Выводы

Мы приобрели навыки написания программ для работы с файлами.

# Список литературы{.unnumbered}

::: {#refs}
:::
1. GDB: The GNU Project Debugger. — URL: https://www.gnu.org/software/gdb/.  
2. GNU Bash Manual. — 2016. — URL: https://www.gnu.org/software/bash/manual/.  
3. Midnight Commander Development Center. — 2021. — URL: https://midnight-commander.
org/.  
4. NASM Assembly Language Tutorials. — 2021. — URL: https://asmtutor.com/.  
5. Newham C. Learning the bash Shell: Unix Shell Programming. — O’Reilly Media, 2005. —
354 с. — (In a Nutshell). — ISBN 0596009658. — URL: http://www.amazon.com/Learningbash-Shell-Programming-Nutshell/dp/0596009658.  
6. Robbins A. Bash Pocket Reference. — O’Reilly Media, 2016. — 156 с. — ISBN 978-1491941591.  
7. The NASM documentation. — 2021. — URL: https://www.nasm.us/docs.php.  
8. Zarrelli G. Mastering Bash. — Packt Publishing, 2017. — 502 с. — ISBN 9781784396879.  
9. Колдаев В. Д., Лупин С. А. Архитектура ЭВМ. — М. : Форум, 2018.  
10. Куляс О. Л., Никитин К. А. Курс программирования на ASSEMBLER. — М. : Солон-Пресс, 2017.  
11. Новожилов О. П. Архитектура ЭВМ и систем. — М. : Юрайт, 2016.  
12. Расширенный ассемблер: NASM. — 2021. — URL: https://www.opennet.ru/docs/RUS/nasm/.  
13. Робачевский А., Немнюгин С., Стесик О. Операционная система UNIX. — 2-е изд. — БХВПетербург, 2010. — 656 с. — ISBN 978-5-94157-538-1.  
14. Столяров А. Программирование на языке ассемблера NASM для ОС Unix. — 2-е изд. —
М. : МАКС Пресс, 2011. — URL: http://www.stolyarov.info/books/asm_unix.  
15. Таненбаум Э. Архитектура компьютера. — 6-е изд. — СПб. : Питер, 2013. — 874 с. —
(Классика Computer Science).  
16. Таненбаум Э., Бос Х. Современные операционные системы. — 4-е изд. — СПб. : Питер, 2015. — 1120 с. — (Классика Computer Science).  
