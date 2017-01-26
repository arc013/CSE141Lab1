r0 = 128 //register to store base memory location 
r1 = 128 //first loop i
r2 = 128 //second loop j
r3 = 0 //greatest value
r4 = 0 //left hand
r5 = 0 //right hand
r6 = 0 //count / temp register for holding hamming distance loop check value
r7 = 0 //pointer for hamming distance loop / temp register for holding values to check first and second loop 

in memory 126 is = 8
in memory 127 is = 148

loop1:
	load r1		# load the left side operand from memory (starts at position 128)
	inc r1		# increment the outer loops pointer
	moveout r4  # move the loaded value to r4
	mov r2, r0  # make sure inner loop operand is = 128
loop2:
	load r2		# load the right side operand from memory (starts at position 128)
	inc r2		# increment the inner loops pointer
	movout r5	# move the loaded value to r5
	xor r5, r4  # xor the left and right operand, store in the r5
	setZero r7  # zero out hamming loop counter
	setZero r6 	# zero out hamming distance counter
loop3:
	inc r7      # increment the hamming distance loop
	and1 r5		# and the xor'd value with 1
	shiftR r5	# shift r5 right by one
	setbranch 17 # set the branch location to 17 to skip increment
	abranch0		# branch if and1 r5 returned 0
	inc r6      # increment the count because the bits were different (and returned 0)
	
	//loop 3 logic 
	dec r0		# go to 127
	dec r0		# go to 126
	load r0 	# load 8 from 126
	moveinT r6  # move the count of current hamming distance to special temp register 
	movout r6   # move out 8 to r6
	slt r7, r6 	# do logic with 148
	inc r0 		# go to 127
	inc r0      # got to 128
	moveoutT r6 # restore the count to r6
	setbranch 11 # branch to beginning of hamming distance loop
	abranch1

	slt r3, r6	# if greatest value is less than count
	setbranch 33 # branch passed changing value if it is not less than
	abranch0
	mov r6, r3

	//loop 2 logic 
	dec r0		# go to 127
	load r0 	# load 148 from 127
	movout r7       # move out 148 to r7
	slt r2, r7 	# do logic with 148
	inc r0 		# go to 128
	setbranch 5
	abranch1

	//loop 1 logic
	dec r0 		# go to 127
	load r0 	# load 148 from 127
	movout r7       # move out 148 to r7
	slt r1, r7 	# do logic with 148
	inc r0 		# go to 128
	setbranch 1
	abranch1

	// store answer
	dec r0 		# go to 127 
	movin r3	# move the final value into the storage register
	store r0	# store the final value into memory at position 127
	halt
