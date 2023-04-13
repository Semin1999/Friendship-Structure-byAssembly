############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################




# Name: Semin Bae
# ID: 114730530
# Email: semin.bae@stonybrook.edu







.text:

.globl create_network
create_network:
	blt $a0, $0, err	#if I is negative, error
	
	blt $a1, $0, err	#if E is negative, error

	move $s0, $a0	#save the max I value in $s0
	
	move $s1, $a1	#save the max J value in $s1
	
	li $a0, 4	#needs 1 word
	
	li $v0, 9	#allocate heap
	
        syscall	
        
        move $s2, $v0	#save the max I address in $s2
        
        li $a0, 4	#needs 1 word
        
        li $v0, 9	#allocate heap
        
        syscall
        
        move $s3, $v0	#save the max J address in $s3 
        
        sw $s0, 0($s2)	#save the max I value in max I heap memeory
        
        sw $s1, 0($s3)	#save the max J value in max J heap memeory
        
        li $a0, 4	#needs 1 word (for current I address)
        
        li $v0, 9	#allocate heap
        
        syscall
        
        move $s4, $v0	#save the current I address in $s4
        
        li $a0, 4	#needs 1 word (for current J address)
        
        li $v0, 9	#allocate heap
        
        syscall
        
        move $s5, $v0	#save the current J address in $s5
        
        sw $0, 0($s4)	# initialize the current I address
        
        sw $0, 0($s5)	# initialize the current J address
        
        sll $t0, $s0, 2	# max I value * 4
        
        sll $t1, $s1, 2	# max J value * 4
        
        
        move $a0, $t0	# array of node address (max I value * 4)
        
        
        li $v0, 9		# allocate heap
        
        syscall
        
        move $s6, $v0	#save $s6 the array of nodes address
        
        
        
        move $a0, $t1	# array of edge address (max J value * 4)
        
        li $v0, 9		# allocate heap
        
        syscall
        
        move $s7, $v0	# save $s7 the edge of nodes addresss
        
        
initialize_arr_node:
	
	move $t2, $s6	#temp move array of node address to $t2
	
	loop1:
	
	sw $0, 0($t2)	# initalize array of node address
	
	addi $t2, $t2, 4	# go to next word
	
	
	
	beq $t2, $s7, initialize_arr_edge	#if moving address of node is meet with edge address, then go to work for edge array address
	
	j loop1		# jump loop

initialize_arr_edge:

	
	move $t3, $s7		#temp move array of edge address to $t3
	
	addu $t4, $s7, $t1	# $t4 = edge array address($t7) + 40 -> to know where is the end of edge array address
	
	
	
	loop2:
	
	
	
	sw $0, 0($t3)		# initalize
	
	addi $t3, $t3, 4		# go to next
	
	
	
	beq $t3, $t4, finish_initalized	#if moving address is same with end of array address
	
	j loop2		# jump loop


finish_initalized:
	
	
	move $v0, $s2	# $s0 is the max I value, so that is the start of network address(mean network address) so move it in to the $v0
	
	move $t8, $s0	#move max I value due to test case
	
	move $t9, $s1	#move max J value due to test case


  jr $ra
#############################___PART 1 END___#################################

.globl add_person
add_person:

#CHECK the NETWORK BOUNDARY

	move $s0, $a0
	
	addi $t5, $a0, 16		# it is the node array address 


	
	addi $t0, $s7, -4		# $t0 is the last address of node array
	
	lw $t1, 0($t0)
	
	bne $t1, $0, err		# if the last address of node array word is not zero then error
	
	
#Check the is it blank word
	
	lb  $t0, 0($a1)	#get the bit from wordtest address
	
	beq $t0, $0, err	#if testing name is 0 then error
	
#Check is there same name
	
	# $t7 is moving address for array
	# $t6 is moving name for argument
	move $t7, $s6	#moving address for array node (temp use)
	
	move $t6, $a1	# moving name address
	
	
	check_loop:
	
	lw $t0, 0($t7)				# get first alphabet for arr
	
	beq $t0, $0, check_loop_finish	# if array[i] == 0 then loop_finish
	
	
	lw $t5, 0($t7)	# get address of address array
	
	addi $t5, $t5, 4
	
	addi $t7, $t7, 4	# plus 4 on arr (go to next array)
	
	
	move $t6, $a1	#initalize the argument
	
	move $t4, $t6	#byte moving add for word
	
	word_loop:
	
	
	lb $t0, 0($t5)	# get first alphabet from array node
	
	lb $t1, 0($t4)	# get first alphabet from name
	
	beq $t1, $0, finish_or_error	#if alphabet next is 0 then go to check_loop
	
	
	addi $t5, $t5, 1	# go to next byte
	
	addi $t4, $t4, 1	# go to next byte
	
	
	
	beq $t0, $t1, word_loop	# if it's same then go to next bit
	
	j check_loop			# if it's different then go to check_loop
	
	finish_or_error:
	
	beq $t1, $t0, err
	
	li $t2, 58
	
	blt $t0, $t2, err
	
	j check_loop

	
	
	check_loop_finish:

	li $t0, 0			# alphabet counter = 0
	
	move $t2, $a1		# Get name address in $t2
	
	
	count_loop1:
	
	lb $t3, 0($t2)		# get alphabet from name in $t3
	
	beq $t3, $0, finish_count1
	
	addi $t0, $t0, 1
	
	addi $t2, $t2, 1
	
	j count_loop1
	
	
	finish_count1:
	
	li $a0, 4			# counter number (length of word needs only one byte

	li $v0, 9			# allocate heap
	
	syscall			# get address in $v0
	
	sw $0, 0($v0)
	
	sw $t0, 0($v0)		# get couning number in allocation heap address 
	
	move $t1, $v0		#(THIS $t1 IS THE NODE address)
	
	
	move $a0, $t0		# one more allocating heap for 
	
	li $v0, 9			# allocate heap
	
	syscall			# get address in $v0
	
	sw $0, 0($v0)
	# NOW $v0 has the address for char
	
	move $t2, $a1		# Get name address in $t2
	
	count_loop2:
	
	lb $t3, 0($t2)		# get alphabet from name in $t3
	
	beq $t3, $0, finish_count2
	
	sb $t3, 0($v0)
	
	addi $t2, $t2, 1
	
	addi $v0, $v0, 1
	
	j count_loop2
	
	
	
	finish_count2:
	
	
	
	#Used temp = $t1( allocated address), $t8, $t9
	
	
	
	move $a0, $s0		#$a0 and $s0 has the network address
	
	addi $t2, $s0, 8		# it is the current node num
	
	lw $t3, 0($t2)		# get from that
	
	addi $t3, $t3, 1		# add it
	
	sw $t3, 0($t2)		# then put it again
	
	addi $t3, $t3, -1		# then back to again to put
	
	
	
	addi $t2, $s0, 16		# it is the array node address
	
	sll $t3, $t3, 2		# times four Then $t3 has the address for 
	
	addu $t3, $t3, $t2	# then $t3 has the address for save $t1
	
	sw $t1, 0($t3)
	
	
	
	move $v0, $a0
	
	li $v1, 1	


  jr $ra

.globl get_person
get_person:

#Check is there same name
	
	# $t7 is moving address for array
	# $t6 is moving name for argument
	move $t7, $s6	#moving address for array node (temp use)
	
	move $t6, $a1	# moving name address
	
	
	
	check_loop_:
	
	lw $t0, 0($t7)				# get first alphabet for arr
	
	beq $t0, $0, err_part3	# if array[i] == 0 then loop_finish
	
	
	
	lw $t5, 0($t7)	# get address of address array
	
	addi $t5, $t5, 4
	
	
	
	move $s0, $t5	# will use for part 
	
	addi $s0, $s0, -4	# go to the int area( start of the address for node)
	
	
	addi $t7, $t7, 4	# plus 4 on arr (go to next array)
	
	
	
	move $t6, $a1	#initalize the argument
	
	
	
	move $t4, $t6	#byte moving add for word
	
	word_loop_:
	
	
	
	lb $t0, 0($t5)	# get first alphabet from array node
	
	lb $t1, 0($t4)	# get first alphabet from name
	
	beq $t1, $0, finish_or_error_	 #if alphabet next is 0 then go to check_loop
	
			
	addi $t5, $t5, 1	# go to next byte
	
	addi $t4, $t4, 1	# go to next byte
	
	
	
	beq $t0, $t1, word_loop_	# if it's same then go to next bit
	
	j check_loop_			# if it's different then go to check_loop
	
	
	
	finish_or_error_:
	
	beq $t1, $t0, check_loop_finish_
	
	li $t2, 58
	
	blt $t0, $t2, check_loop_finish_
	
	j check_loop_
	
	
	
	check_loop_finish_:
	
	
	
	move $v0, $s0
	
	li $v1, 1

  jr $ra
  	
err_part3:

  	li $v0, -1
  	
  	li $v1, -1
  
  jr $ra


.globl add_relation
add_relation:

	
	move $t9, $a0	# move network add to the $t9
	
	move $k0, $a1	#first person address temp save in k0
	
	move $k1, $a2	#second person address temp save in k1
	
	#Check the first person in array



	#Check edge array is in the capacity
	
	addi $t0, $t9, 12
	
	lw $t0, 0($t0)
	
	addi $t1, $t9, 4
	
	lw $t1, 0($t1)
	
	beq $t0, $t1, err_part4
	
		
				
	#first person is already in $a1
	
	addi $sp, $sp, -4
	
	sw $ra, 0($sp)
	
	jal get_person
	
	lw $ra, 0($sp)
	
	addi $sp, $sp, 4
	
	move $t2, $s0		# name 1 heap address
	
	li $t0, 1
	bne $v1, $t0, err_part4		#If first person is not in the array then error
	
	move $a1, $k1		#put second person in the a1 for the test
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal get_person
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	move $t3, $s0		# name 2 heap address
	
	li $t0, 1
	bne $v1, $t0, err_part4		#If first person is not in the array then error
	
	
	move $s0, $k0		#move the first, second name in to $s0, $s1
	move $s1, $k1		# just simply save in $s0, $s1
	

	
	
	#Check first and second is same
	loop_part4_:
	lb $t0, 0($k0)
	lb $t1, 0($k1)
	bne $t0, $t1, finish_loop_
	beq $t0, $0, err_part4
	addi $k0, $k0, 1
	addi $k1, $k1, 1
	j loop_part4_
	finish_loop_:	
	
	#If relation int is greater 3 or less than 0
	li $t0, 0
	li $t1, 3
	bgt $a3, $t1, err_part4
	blt $a3, $t0, err_part4
	
	#HAVE TO MAKE CONDITION 4	
		#something condition 4.......
	
	jamp:
	
	li $a0, 4			# counter number (length of word needs only one byte
	li $v0, 9			# allocate heap
	syscall			# get address in $v0
	sw $t2, 0($v0)		# name1 in to the heap
	move $t5, $v0		#This $t5 address is the edge address
	
	li $a0, 4			# counter number (length of word needs only one byte
	li $v0, 9			# allocate heap
	syscall			# get address in $v0
	sw $t3, 0($v0)		# name 2  in to the heap
	
	li $a0, 4			# counter number (length of word needs only one byte
	li $v0, 9			# allocate heap
	syscall			# get address in $v0
	sw $a3, 0($v0)		# relation type(int) in to the heap
	
	addi $t2, $t9, 12		# $t2 is the current edge num
	lw $t3, 0($t2)		# get from there
	addi $t3, $t3, 1
	sw $t3, 0($t2)
	addi $t3, $t3, -1
	
	move $t2, $s7		# $s7 is the array of edge address
	sll $t3, $t3, 2		# current num * 4 (before add 1)
	addu $t3, $t3, $t2	# start of edge addres + current num * 4
	sw $t5, 0($t3)
	
	move $a0, $t9
	move $v0, $t9
	li $v1, 1
	
  jr $ra

err_part4:

	li $v0, -1
	li $v1, -1
	
	jr $ra

.globl get_distant_friends
get_distant_friends:
	
	move $t8, $a0		#network
	move $t9, $a1		#name
	
	done_get_distant:
	
	li $v0, -1
	
  jr $ra

err:
	li $v0, -1
	li $v1, -1
	
  jr $ra













	#Line have to do part 5

















err_:
	li $v0, -1
	li $v1, -1
	
  jr $ra



