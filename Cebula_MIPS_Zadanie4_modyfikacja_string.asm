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
wrongargprompt2: .asciiz "Argument too long! Try again:\n"
newline: .asciiz "\n"
dp1: .double 0
dp10: .double 10
indata1: .space 20
indata2: .space 20
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
#moving input into $t5
move $t5, $t0

#loading 10 into $f8 register
l.d $f8, dp10


arg1:
#asking for the first arg:
la $a0, arg1prompt
li $v0, 4
syscall
la $a0,indata1
la $a1,20
li $v0, 8
syscall
la $t0,($a0) 		# entered string is stored in the $t0 register
li $t1,0 		# string length
#clearing arg1 $f2
l.d $f2, dp1
l.d $f16, dp1				
l.d $f18, dp1
l.d $f20, dp1
li $t2,0		# sub 1 parts				
				
				
 counter1:
 lb $t7, 0($t0)
 
 
 #test
 la $a0, ($t7)
 li $v0, 11
 syscall
 la $a0, newline
 li $v0, 4
 syscall
 
 #increasing string length
 addi $t0, $t0, 1
 addi $t1, $t1, 1
 #if 0 move to argument 2 loading
 beqz $t7, arg2
 #if special character move to argument 2 loading
 blt $t7, 32, arg2
 #if not a number (>57) throw error
 bgt $t7, 57, wrongdoubleinput1
 #checks if floating point detected
 beq $t7, 46, counter1p2
 beq $t7, 44, counter1p2 
 #checks if argument not too small
 blt $t7, 48, wrongdoubleinput1
 #checks if argument too long
 bgt $t1, 14, argtoolong1
 #converting to double
 subi $t7, $t7, 48 
 mtc1.d $t7, $f16
 cvt.d.w $f16, $f16
 mul.d $f2, $f2, $f8
 add.d $f2, $f2, $f16
 j counter1

counter1p2:
 lb $t7, 0($t0)
 #increasing string length
 addi $t0, $t0, 1
 addi $t1, $t1, 1
 addi $t2, $t2, 1
 #if 0 move to join1
 beqz $t7, join1
 #if special character move to argument 2 loading
 blt $t7, 32, join1
 #if not a number (>57) throw error
 bgt $t7, 57, wrongdoubleinput1
 #checks if argument not too small
 blt $t7, 48, wrongdoubleinput1
 #checks if argument too long
 bgt $t1, 14, argtoolong1
 #converting to double
 subi $t7, $t7, 48 
 mtc1.d $t7, $f16
 cvt.d.w $f16, $f16
 mul.d $f18, $f18, $f8
 add.d $f18, $f18, $f16
 j counter1p2
 
join1:
subi $t2, $t2, 1
beqz $t2, merge1
div.d $f18, $f18, $f8

j join1

merge1:
add.d $f2, $f2, $f18











arg2:
#asking for the second arg:
la $a0, arg2prompt
li $v0, 4
syscall
la $a0,indata2
la $a1,20
li $v0, 8
syscall
#loading data from input
la $t0,($a0) 		# entered string is stored in the $t0 register
li $t1,0 		# string length
li $t4,0		# sub 1 parts
li $t2,0		# sub 1 parts

#clearing arg2 $f4
l.d $f4, dp1
l.d $f16, dp1				
l.d $f18, dp1
l.d $f20, dp1

 counter2:
 lb $t7, 0($t0)
 #increasing string length
 addi $t0, $t0, 1
 addi $t1, $t1, 1
 #if 0 move to argument 2 loading
 beqz $t7, operationTypeCheck
  #if special character move to argument 2 loading
 blt $t7, 32, operationTypeCheck
 #if not a number (>57) throw error
 bgt $t7, 57, wrongdoubleinput2
 #checks if floating point detected
 beq $t7, 46, counter2p2
 beq $t7, 44, counter2p2 
 #checks if argument not too small
 blt $t7, 48, wrongdoubleinput2
 #checks if argument too long
 bgt $t1, 14, argtoolong2
 #converting to double
 subi $t7, $t7, 48 
 mtc1.d $t7, $f16
 cvt.d.w $f16, $f16
 mul.d $f4, $f4, $f8
 add.d $f4, $f4, $f16
 j counter2

counter2p2:
 lb $t7, 0($t0)
 #increasing string length
 addi $t0, $t0, 1
 addi $t1, $t1, 1
 addi $t2, $t2, 1
 #if 0 move to join1
 beqz $t7, join2
  #if special character move to argument 2 loading
 blt $t7, 32, join2
 #if not a number (>57) throw error
 bgt $t7, 57, wrongdoubleinput2
 #checks if argument not too small
 blt $t7, 48, wrongdoubleinput2
 #checks if argument too long
 bgt $t1, 14, argtoolong2
 #converting to double
 subi $t7, $t7, 48 
 mtc1.d $t7, $f16
 cvt.d.w $f16, $f16
 mul.d $f20, $f20, $f8
 add.d $f20, $f20, $f16
 j counter2p2
 
join2:
subi $t2, $t2, 1
beqz $t2, merge2
div.d $f20, $f20, $f8
j join2

merge2:
add.d $f4, $f4, $f20









operationTypeCheck:
#checking which operation to do:
beq $t5, 1, addition
beq $t5, 2, substraction
beq $t5, 3, multiplication
beq $t5, 4, division

#wrong input message:
wronginput:
la $a0, wronginputprompt
li $v0, 4
syscall
j main

#wrong arg1 message:
wrongdoubleinput1:
la $a0, wrongargprompt
li $v0, 4
syscall
j arg1

#wrong arg2 message:
wrongdoubleinput2:
la $a0, wrongargprompt
li $v0, 4
syscall
j arg2

#argument too long message
argtoolong1:
la $a0, wrongargprompt2
li $v0, 4
syscall
j arg1

#argument too long message
argtoolong2:
la $a0, wrongargprompt2
li $v0, 4
syscall
j arg2


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


