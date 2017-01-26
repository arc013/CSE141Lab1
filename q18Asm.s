
// 
// r1 = 9
// r2 = 32 // base array address
// r3 = 0  //count
// r4 = 0  // i
// r5 = 0 // temp  (array element)
// r6 = 0 //local
// r7 = 64
// r8 = 0 //store 0x0f and compare register
//
//
// memory location 31 stores 0x0f
// 

moveinT r1 //store 9 inside temp reg

load r1   #r1 has value 9  
          #special register now contain the string
movout r1 #r1 is now the string



loop:


mov r5 r2    #copy base array into r5
add r5 r4    #add i to base array to get position of element

load r5    #r5 has value of element (32+i)
           #speical regiest now contains array element 0
movout r5  #array elment 0 in r5



dec  r2    #31 now to get 0x0f
load r2    #special regiester now has 0x0f
movout r8  #r8 now has 0x0f


mov r6 r5  #copy temp into local
and r6 r8  #clear upper bits of local element


slt r1 r6  # check equality 
setbranch opposite0 #branch to check the other way around
branch0    # only branch to check if this one is not true 

jump next0  # jump to check next 4 bits (since we know not equal)

opposite0: 
slt r6 r1  # check equality 
setbranch next0 #branch if not less than (equal)
branch0
inc r3     # count++

next0:
shiftR r5 
mov r6 r5  #copy temp into local
and r6 r8  #clear upper bits of local element

slt r1 r6  # check equality 
setbranch opposite1 #branch to check the other way around
branch0    # only branch to check if this one is not true 

jump next1  # jump to check next 4 bits (since we know not equal)

opposite1: 
slt r6 r1  # check equality 
setbranch next1 #branch if not less than (equal)
branch0
inc r3     # count++

next1:
shiftR r5
mov r6 r5  # copy temp into local
and r6 r8  # clear upper bits of local element

slt r1 r6  # check equality 
setbranch opposite2 #branch to check the other way around
branch0    # only branch to check if this one is not true

jump next2  # jump to check next 4 bits (since we know not equal)

opposite2: 
slt r6 r1  # check equality 
setbranch next2 #branch if not less than (equal)
branch0
inc r3     # count++


next2:
shiftR r5
mov r6 r5  # copy temp into local
and r6 r8  # clear upper bits of local element

slt r1 r6  # check equality 
setbranch opposite3 #branch to check the other way around
branch0    # only branch to check if this one is not true 

jump next3  # jump to check next 4 bits (since we know not equal)

opposite3: 
slt r6 r1  # check equality 
setbranch next3 #branch if not less than (equal)
branch0
inc r3     # count++


next 3:

shiftR r5
mov r6 r5  # copy temp into local
and r6 r8  # clear upper bits of local element

slt r1 r6  # check equality 
setbranch opposite4 #branch to check the other way around
branch0    # only branch to check if this one is not true 

jump endbit_check  # jump to end of checking
opposite4: 
slt r6 r1  # check equality 
setbranch endbit_check #branch if not less than (equal)
branch0
inc r3     # count++



endbit_check : 


inc r2     # make r2 go back to 32



setZero r5 # clear temp
setZero r6 # clear local


moveoutT r6# r6 has value of 9
inc r6     # r6 is now 10


setZero r8  # make r8 0
inc r8      # r8 is 1

slt r3 r8
setbranch count2
branch1   count2  # not equal check the next count

slt r8 r3
setbranch count2
branch1   count2  # not equal check the next count
load r6           # special register now has array[10]
moveout r5        # r5 is array[10]
inc r5            # array[10]++
movin r5          # move to store register
store r6          # store array[10]++ value back to array[10]

jump endif

count2:

inc r6      # r6 is 11
inc r8      # r8 is 2

slt r3 r8
setbranch count3
branch1   count3  # not equal check the next count

slt r8 r3
setbranch count3
branch1   count3  # not equal check the next count
load r6           # special register now has array[11]
moveout r5        # r5 is array[11]
inc r5            # array[11]++
movin r5          # move to store register
store r6          # store array[11]++ value back to array[11]

jump endif

count3:

inc r6      # r6 is 12
inc r8      # r8 is 3

slt r3 r8
setbranch count4
branch1           # not equal check the next count

slt r8 r3
setbranch count4
branch1           # not equal check the next count
load r6           # special register now has array[12]
moveout r5        # r5 is array[12]
inc r5            # array[12]++
movin r5          # move to store register
store r6          # store array[12]++ value back to array[12]

jump endif

count4:

inc r6      # r6 is 13
inc r8      # r8 is 4

slt r3 r8
setbranch count5
branch1           # not equal check the next count

slt r8 r3
setbranch count5
branch1           # not equal check the next count
load r6           # special register now has array[13]
moveout r5        # r5 is array[13]
inc r5            # array[13]++
movin r5          # move to store register
store r6          # store array[13]++ value back to array[13]

jump endif

count5:

inc r6      # r6 is 14
inc r8      # r8 is 5

slt r3 r8
setbranch endif
branch1           # not equal check the next count

slt r8 r3
setbranch endif
branch1           # not equal check the next count
load r6           # special register now has array[14]
moveout r5        # r5 is array[14]
inc r5            # array[14]++
movin r5          # move to store register
store r6          # store array[14]++ value back to array[14]


endif:
setZero r5        # clear r5
setZero r6        # clear r6
inc r4            # i++  

slt r4 r7         # check loop condition i<64 or not
setbranch loop    
branch1           # if condition matched branch to loop
                  # else program finished 

program_done:






