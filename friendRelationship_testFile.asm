############################ CHANGE THIS FILE AS YOU DEEM FIT ############################
############################ Add more names if needed ####################################

.data

Name_Jane: .asciiz "Jane"
Name_Joey: .asciiz "Joey"
Name_Alit: .asciiz "Alit"
Name_Veen: .asciiz "Veen"
Name_Stan: .asciiz "Stan"
Name_Kim: .asciiz "Kim"
Name_Steve: .asciiz "Steve"
test: .asciiz ""
I_5: .word 5
J_1: .word 1
I_3: .word 3
J_5: .word 5

.text
main:
    lw $a0, I_5
    lw $a1, J_5
    jal create_network
    add $s0, $v0, $0		# network address in heap

    add $a0, $0, $s0		# pass network address to add_person
    la $a1, Name_Jane
    jal add_person
    
    la $a1, Name_Joey
    jal add_person
 
    la $a1, Name_Alit
    jal add_person
 
    la $a1, Name_Kim
    jal add_person     
                                                                                                      
    la $a1, Name_Jane
    jal get_person
    
    la $a1, Name_Jane
    la $a2, Name_Kim
    li $a3, 1
    jal add_relation
    add $s0, $v0, $0		# network address in heap
    add $a0, $0, $s0		# pass network address to add_person
    la $a1, Name_Jane
    la $a2, Name_Kim
    li $a3, 1
    jal add_relation
    add $s0, $v0, $0		# network address in heap
    
    ############ TESTING PART 1 ENDED  ##############
    
    lw $a0, I_3
    lw $a1, J_5
    jal create_network
    add $s0, $v0, $0		# network address in heap

    add $a0, $0, $s0		# pass network address to add_person
    la $a1, Name_Steve
    jal add_person
    
    la $a1, Name_Jane
    jal add_person
    
    la $a1, Name_Kim
    jal add_person
               
    la $a1, Name_Jane
    jal get_person
    
    la $a1, Name_Jane
    la $a2, Name_Kim
    li $a3, 2
    jal add_relation
    add $s0, $v0, $0		# network address in heap
    
    
    #write test code


exit:
    li $v0, 10
    syscall
.include "hw4.asm"
