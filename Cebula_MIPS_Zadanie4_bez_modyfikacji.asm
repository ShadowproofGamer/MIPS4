.data
mainprompt: .asciiz "Operacje dostepne do wykonania:\n"
optionsprompt: .asciiz "1.Dodawanie\n2.Odejmowanie\n3.Mnozenie\n4.Dzielenie\n"
decisionprompt: .asciiz "Wpisz numer operacji, ktora chcesz wykonac:\n"
arg1prompt: .asciiz "Podaj pierwszy argument:\n"
arg2prompt: .asciiz "Podaj drugi argument:\n"
resultprompt: .asciiz "Wynik wynosi:\n"
endprompt: .asciiz "\nCzy kontynuowac? (0-nie, 1-tak):\n"
wronginputprompt: .asciiz "Zly numer operacji! Sprobuj jeszcze raz:\n"
wrongargprompt: .asciiz "Incorrect argument inputted! Try again:\n"
dp1: .double 0
.text
main:
#pocz¹tek programu (pytanie o rodzaj operacji)
la $a0, mainprompt
li $v0, 4
syscall
la $a0, optionsprompt
li $v0, 4
syscall
la $a0, decisionprompt
li $v0, 4
syscall
#getting the input:
li $v0, 5
syscall
move $t0, $v0
#checking if the input is correct:
bgt $t0, 4, wronginput
blt $t0, 1, wronginput
arg1:
#asking for the first arg:
la $a0, arg1prompt
li $v0, 4
syscall
li $v0, 7
syscall
mov.d $f2, $f0
arg2:
#asking for the second arg:
la $a0, arg2prompt
li $v0, 4
syscall
li $v0, 7
syscall
mov.d $f4, $f0
#checking which operation to do:
beq $t0, 1, addition
beq $t0, 2, substraction
beq $t0, 3, multiplication
beq $t0, 4, division

#wrong input message:
wronginput:
la $a0, wronginputprompt
li $v0, 4
syscall
j main

addition:
add.d $f0, $f2, $f4
j result

substraction:
sub.d $f0, $f2, $f4
j result

multiplication:
mul.d $f0, $f2, $f4
j result

divisionbyzero:
la $a0, wrongargprompt
li $v0, 4
syscall
j arg2

division:
#checks if arg2 is 0
l.d $f6, dp1
c.eq.d $f4, $f6
bc1t divisionbyzero

div.d $f0, $f2, $f4
j result

result:
#printing result:
la $a0, resultprompt
li $v0, 4
syscall
mov.d $f12, $f0
li $v0, 3
syscall

end:
#prompt asking if you want to end the program
la $a0, endprompt
li $v0, 4
syscall
#getting the input:
li $v0, 5
syscall
bnez $v0, main
li $v0, 10
syscall

eret
teqi
mfc