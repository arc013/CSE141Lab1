moveinT r1 //store 9 inside temp reg
load r1   #r1 has value 9  
movout r1 #r1 is now the string
mov r5 r2    #copy base array into r5
add r5 r4    #add i to base array to get position of element
load r5    #r5 has value of element (32+i)
movout r5  #array elment 0 in r5
dec  r2    #31 now to get 0x0f
load r2    #special regiester now has 0x0f
movout r8  #r8 now has 0x0f
mov r6 r5  #copy temp into local
and r6 r8  #clear upper bits of local element
slt r1 r6  # check equality 
setbranch 2 #branch to check the other way around
rbranch0    # only branch to check if this one is not true 
setbranch 4
jump  		# jump to check next 4 bits (since we know not equal)
slt r6 r1  # check equality 
setbranch 1 #branch if not less than (equal)
rbranch0
inc r3     # count++
shiftR r5 
mov r6 r5  #copy temp into local
and r6 r8  #clear upper bits of local element
slt r1 r6  # check equality 
setbranch 2 #branch to check the other way around
rbranch0    # only branch to check if this one is not true 
setbranch next1
jump next1  # jump to check next 4 bits (since we know not equal)
slt r6 r1  # check equality 
setbranch 1 #branch if not less than (equal)
rbranch0
inc r3     # count++
shiftR r5
mov r6 r5  # copy temp into local
and r6 r8  # clear upper bits of local element
slt r1 r6  # check equality 
setbranch 2 #branch to check the other way around
rbranch0    # only branch to check if this one is not true
setbranch 4
jump   		# jump to check next 4 bits (since we know not equal)
slt r6 r1  # check equality 
setbranch 1 #branch if not less than (equal)
rbranch0
inc r3     # count++
shiftR r5
mov r6 r5  # copy temp into local
and r6 r8  # clear upper bits of local element
slt r1 r6  # check equality 
setbranch 2 #branch to check the other way around
rbranch0    # only branch to check if this one is not true 
setbranch 4
jump   	   # jump to check next 4 bits (since we know not equal)
slt r6 r1  # check equality 
setbranch 1 #branch if not less than (equal)
rbranch0
inc r3     # count++
shiftR r5
mov r6 r5  # copy temp into local
and r6 r8  # clear upper bits of local element
slt r1 r6  # check equality 
setbranch 2 #branch to check the other way around
rbranch0    # only branch to check if this one is not true 
setbranch 4
jump  	   # jump to end of checking
slt r6 r1  # check equality 
setbranch 1 #branch if not less than (equal)
rbranch0
inc r3     # count++
inc r2     # make r2 go back to 32
setZero r5 # clear temp
setZero r6 # clear local
movoutT r6# r6 has value of 9
inc r6     # r6 is now 10
setZero r8  # make r8 0
inc r8      # r8 is 1
slt r3 r8
setbranch 11
rbranch1   # not equal check the next count
slt r8 r3
setbranch 8
rbranch1     # not equal check the next count
load r6           # special register now has array[10]
movout r5        # r5 is array[10]
inc r5            # array[10]++
movin r5          # move to store register
store r6          # store array[10]++ value back to array[10]
setbranch 30
setbranch 29
jump
inc r6      # r6 is 11
inc r8      # r8 is 2
slt r3 r8
setbranch 11
rbranch1    # not equal check the next count
slt r8 r3
setbranch 8
rbranch1    # not equal check the next count
load r6           # special register now has array[11]
movout r5        # r5 is array[11]
inc r5            # array[11]++
movin r5          # move to store register
store r6          # store array[11]++ value back to array[11]
setbranch 22
setbranch 21
jump
inc r6      # r6 is 12
inc r8      # r8 is 3
slt r3 r8
setbranch 10
rbranch1           # not equal check the next count
slt r8 r3
setbranch 7
rbranch1           # not equal check the next count
load r6           # special register now has array[12]
movout r5        # r5 is array[12]
inc r5            # array[12]++
movin r5          # move to store register
store r6          # store array[12]++ value back to array[12]
setbranch 29
jump
inc r6      # r6 is 13
inc r8      # r8 is 4
slt r3 r8
setbranch 10
rbranch1           # not equal check the next count
slt r8 r3
setbranch 7
rbranch1           # not equal check the next count
load r6           # special register now has array[13]
movout r5        # r5 is array[13]
inc r5            # array[13]++
movin r5          # move to store register
store r6          # store array[13]++ value back to array[13]
setbranch 13
jump
inc r6      # r6 is 14
inc r8      # r8 is 5
slt r3 r8
setbranch 8
rbranch1           # not equal check the next count
slt r8 r3
setbranch 6
rbranch1           # not equal check the next count
load r6           # special register now has array[14]
movout r5        # r5 is array[14]
inc r5            # array[14]++
movin r5          # move to store register
store r6          # store array[14]++ value back to array[14]
setZero r5        # clear r5
setZero r6        # clear r6
inc r4            # i++  
slt r4 r7         # check loop condition i<64 or not
setbranch 4    
abranch1           # if condition matched branch to loop
halt