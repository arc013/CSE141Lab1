# r0 = 0x1000 0000 // not free
# r1 = 1
# r2 = 2
# r3 = 0
# r4 = 0
# r5 = 0 (not for check initially anymore)!
# r6 = 8 for final result lowest position // not free
# r7 = 0 storing check
#
# memory position 0 stores the check value

load r1
movout r1    #r1 has a1


load r2
movout r2    #r2 has a2

mov r3 r1    #copy r1 into r3 now r3 also has a1
and r3 r0    # now r3 is 0x1000 0000 or 0x0000 0000

slt r3 r4
setbranch 14# skipAnegate
rbranch0

negate r1
negate r2
inc r4      # make r4 1

add r1 r4   
dec r4      # make r4 0
add r2 r4   # add 0 for overflow
#inc r5
inc r7      # check += 1

setZero r3  # for address of a1 and a2
inc r3      # r3 is 1 for address of a1
movin r1    #move a1 into store reg
store r3

inc r3      # r3 is 2 for address of a2
movin r2    # move a2 into store reg
store r3

#setZero r3  # for address of check
#movin r5    # store check into position 0 
#store r3

skipAnegate:

setZero r1
inc r1
inc r1
inc r1      # r1 is now 3 for address of b1

mov r2 r1  
inc r2      # r2 is now 4 for address of b2

load r1    
movout r1   # r1 now has value b1
 
load r2
movout r2   # r2 now has value b2

setZero r4
setZero r3


mov r3 r1   # copy r1 into r3 now r3 also has b1
and r3 r0   # now r3 is 0x1000 0000 or 0x0000 0000

slt r3 r4
setbranch 15# skipBnegate
rbranch0

negate r1
negate r2
inc r4      # make r4 1

add r1 r4   
dec r4      # make r4 0
add r2 r4   # add 0 for overflow
#inc r5
inc r7      # check += 1

setZero r3  # for address of b1 and b2
inc r3      # r3 is 1 for address of b1
movin r1    # move b1 into store reg
store r3

inc r3      # r3 is 2 for address of b2
movin r2    # move b2 into store reg
store r3

skipBnegate:

################ switch logic to use r7 to store the check value
################ r7 now contains 0, 1 or 2
#setZero r3  # for address of check
#movin r5    # move check into special store register 
#store r3    # store check into position 0 of memory

#######################################
# negate logic done check stored in memory location 0
# r0 contains 0x1000 0000, r6 contains 8
# r1-r5, free to do anything after this point
#######################################


setZero r4  # clear r4

shiftR r0
shiftR r0
shiftR r0
shiftR r0
shiftR r0
shiftR r0
shiftR r0   # now r0 holds 0x0000 0001


####a2b2 (low low)#####
setZero r1
inc r1
inc r1      # r1 is now 2 which is memory address for a2
load r1     # now loading a2 into special load/store reg
movout r1   # now r1 is a2
setZero r2
inc r2
inc r2
inc r2
inc r2      # r2 is now 4 which is memory address of b2
load r2     # now loading b2 into special load/store reg
movout r2   # now r2 is b2
setZero r3  # use r3 for loop count i
#####
# don't modify r0-r3 after this point 
# they hold value required for the repeated loops
# r0 = 0x0000 0001
# r1 = a2
# r2 = b2
# r3 = i
# r6 = 8 for final result lowest position on memory
#####
lowlowloop:

moveinT r2  # copy b2 into special temp reg for shifting
shiftRN r3  # shift right i times to get the ith bit of b2
moveoutT r4 # now r4 contains the correct bit to check in the LSB
and r4 r0   # tempb & mask to get either 0x0000 0000 or 0x0000 0001 in r4

setZero r5  # for slt check other operand
slt r5 r4
setbranch 29# end_check_if_lowlow
rbranch0
#### if tempb!= 0 in other words the LSB is 1
moveinT r1  # copy the value in r1 into special temp reg
shiftLN r3  # a2 < i to get the bits needed to put in lower part of result
setZero r4  
moveoutT r4 # r4 now contains the bits you want to add to intermediate result
load r6     # r6 contains 8 which is last pos. of final result memory address
            # special load-store register now contains last pos. (8) of
            # final result
setZero r5
movout r5   # r5 now contains the final result to last position 
add r5 r4   # adding the bits aka lower_a2b2 += tempb may produce overflow
###############
###### next add may have cin from overflow!!
###############
movin r5    # put the resultant into special load-store register
store r6    # store the new result into final position 8 in memory 


dec r6      # to get mem. position 7 to load and store final result
load r6     # r6 contains 7 which is 2nd to last final pos. of result
            # special load-store register now contains 2nd to last pos. (7) of
            # final result
inc r6      # r6 back to being 8
movout r5   # r5 now contains the 2nd to last pos. of final element
setZero r4  # set r4 to zero
add r5 r4   # add zero to r4 for overflow (if there is one) overflow will be
            # cleared after this point
mov r4 r3   # copy i into r4
negate r4   # doing 2's compliment to get -i
inc r4      # add 1 after flipping bits (no overflow) 
add r4 r6   # add 8 to -i and store in r4 which is the number to shift
moveinT r1  # copy the value in r1 into special temp register for shifting
shiftRN r4  # shifting a2 by 8-i bits, the result is in special temp
setZero r4  # clear r4
moveoutT r4 # now r4 contains the bits to store in 2nd to last position
add r5 r4   # adding bits that needed to go to 2nd to last position from the
            # shift (not possible to have overflow) //
# //Double check over flow here Conor ^^ I think won't have overflow with 80%
# confidence 
#
# CONOR CONOR CONOR
#
###########################################################
dec r6      # to get address 7 for second to last position of final result
movein r5   # move the value we calculated for that position into special
            # load-store register
store r6    # storing the value into second to last final result position (7)
inc r6      # make r6 go back up to 8

#### end inner if 
end_check_if_lowlow:
inc r3      # i += 1 
slt r3 r6   # loop condition if i<8
setbranch -32 #lowlowloop
setbranch -10#lowlowloop  # target too far needs to add more to branch register
rbranch1

### end lowlowloop


#######################################
# r0 contains 0x0000 0001, r6 contains 8
# r1-r5, free to do anything after this point
#######################################



### start highlowloop

setZero r1
setZero r2
setZero r3
setZero r4
setZero r5
#setZero r7

inc r1      # r1 is now 1 for mem location of a1
load r1     # loading a1 into special load-store register
movout r1   # moving a1 into r1

inc r2
inc r2
inc r2 
inc r2      # r2 is now 4 for mem location of b2
load r2     # loading b2 into special load-store register
movout r2   # moving b2 into r2


highlowloop: #using r3 as i for loop count

moveinT r2  # copy b2 into temp reg for shifting
shiftRN r3  # shifting right ith times to get ith bit of b2
moveoutT r4 # now r4 contains the correct LSB to check

and r4 r0   # checking to see if it's 0 or 1 
            # r4 is now either 0x0000 0000 0x0000 0001
slt r5 r4   # r5 is 0, checking if r4 is 1
setbranch 31#end_checkif_highlow
setbranch 2 #end_checkif_highlow
rbranch0    
            # LSB is one
moveinT r1  # copy a1 into temp register for shifting
shiftLN r3  # getting the bits to go to the lower part 
            # a1<i
setZero r4  
moveoutT r4 # r4 now contains the bits to add to lower part of intermediate
            # result
dec r6      # now r6 is at 7 for mem position 7 for 2nd to last final result position 
load r6     # loading 2nd to last final result position into special load-store 
            # register
setZero r5 
moveout r5  # now r5 contains 2nd to last final result positon 
add r5 r4   # adding the right bits to 2nd to last final result position
            # may produce overflow!

movin r5    # put result into load-store register
store r6    # storing it back to memory location 7
dec r6      # now r6 is at 6 for upper part of intermediate answer 
load r6     # moving 2nd position of final result element into special
            # load-store register
inc r6
inc r6      # r6 back up to 8
movout r5   # 2nd positon of final result in r5
setZero r4
add r5 r4   # adding 0 for overflow if previous add produce overflow
mov r4 r3   # copying i into r4
negate r4   # flipping bits of i to get -i 
inc r4      # add 1 to r4 to do 2's compliment 
add r4 r6   # (-i) + 8  aka (8-i) in r4
moveinT r1  # moving a1 into special temp register for shifting
shiftRN r4  # shifting a1 right by (8-i) bits
setZero r4  
moveoutT r4 # the correct bits to add to upper part of intermediate answer is in
            # r4
add r5 r4   # adding the bits to 2nd position of final result (will not produce 
            # overflow
dec r6
dec r6      # now r6 is at 6 for 2nd position of final result in mem (6)
movin r5    # moving the result after bits are added for 2nd position of final
            # result
store r6    # storing 2nd position of final result back to memory location 6
inc r6
inc r6      # r6 now back to 8

end_checkif_highlow:
inc r3      # i += 1
slt r3 r6   # check if i < 8
setBranch   -32
setBranch   -14
rbranch1 

### end highlowloop


#######################################
# r0 contains 0x0000 0001, r6 contains 8
# r1-r5, free to do anything after this point
#######################################



### start lowhighloop

setZero r1
setZero r2
setZero r3
setZero r4
setZero r5
#setZero r7

inc r1
inc r1      # r1 is now 2 for mem location of a2
load r1     # loading a2 into special load-store register
movout r1   # moving a2 into r1

inc r2
inc r2 
inc r2      # r2 is now 3 for mem location of b1
load r2     # loading b1 into special load-store register
movout r2   # moving b1 into r2



lowhighloop: #using r3 as i for loop count
moveinT r2  # copy b1 into temp reg for shifting
shiftRN r3  # shifting right ith times to get ith bit of b1
moveoutT r4 # now r4 contains the correct LSB to check

and r4 r0   # checking to see if it's 0 or 1 
            # r4 is now either 0x0000 0000 0x0000 0001
slt r5 r4   # r5 is 0, checking if r4 is 1
setBranch 31# end_checkif_lowhigh
setBranch 9 # end_checkif_lowhigh

rbranch0 
            # LSB is one
moveinT r1  # copy a2 into temp register for shifting
shiftLN r3  # getting the bits to go to the lower part 
            # a2 < i
setZero r4  
moveoutT r4 # r4 now contains the bits to add to lower part of intermediate
            # result
dec r6      # now r6 is at 7 for mem position 7 for 2nd to last final result position 
load r6     # loading 2nd to last final result position into special load-store 
            # register
setZero r5 
moveout r5  # now r5 contains 2nd to last final result positon 
add r5 r4   # adding the right bits to 2nd to last final result position
            # may produce overflow!

movin r5    # put result into load-store register
store r6    # storing it back to memory location 7
dec r6      # now r6 is at 6 for upper part of intermediate answer 
load r6     # moving 2nd position of final result element into special
            # load-store register
inc r6
inc r6      # r6 back up to 8
movout r5   # 2nd positon of final result in r5
setZero r4
add r5 r4   # adding 0 for overflow if previous add produce overflow
mov r4 r3   # copying i into r4
negate r4   # flipping bits of i to get -i 
inc r4      # add 1 to r4 to do 2's compliment 
add r4 r6   # (-i) + 8  aka (8-i) in r4
moveinT r1  # moving a1 into special temp register for shifting
shiftRN r4  # shifting a1 right by (8-i) bits
setZero r4  
moveoutT r4 # the correct bits to add to upper part of intermediate answer is in
            # r4
add r5 r4   # adding the bits to 2nd position of final result
            # different from previous loop this may produce overflow!!!!!!
            # !!!!!!!!!!!!!!!!!!!!!Conor Conor 
dec r6
dec r6      # now r6 is at 6 for 2nd position of final result in mem (6)
movin r5    # moving the result after bits are added for 2nd position of final
            # result
store r6    # storing 2nd position of final result back to memory location 6
###############################
###### for overflow into position one, assumption is that it can only overflow
###### once in the loop need verfication from TA
###############################
setZero r4
setZero r5
add r5 r4   # adding 0s to see if there was overflow from previous add
            # if so there will be 1 in r5
movin r5    # copy r5 into special load-store register
dec r6      # r6 is now 5 for 1st position of final result memory address
store r6    # storing the overflow bit (if there is one, if not it's zero) into
            # first position (mem location 5) of final result 
###############################
###### special overflow ends
###############################
inc r6
inc r6
inc r6      # r6 is back to 8

end_checkif_lowhigh:

inc r3      # i += 1
slt r3 r6   # i < 8
setBranch -32
setBranch -21
rbranch1 


### lowhighloop ends

#######################################
# r0 contains 0x0000 0001, r6 contains 8
# r1-r5, free to do anything after this point
#######################################


### highhighloop starts

setZero r1
setZero r2
setZero r3
setZero r4
setZero r5
#setZero r7

inc r1      # r1 is now 1 for mem location of a1
load r1     # loading a2 into special load-store register
movout r1   # moving a2 into r1

inc r2
inc r2 
inc r2      # r2 is now 3 for mem location of b1
load r2     # loading b1 into special load-store register
movout r2   # moving b1 into r2



highhighloop: 
            # r3 is i for loop count
moveinT r2  # copy b1 into temp reg for shifting
shiftRN r3  # shifting right ith times to get ith bit of b1
moveoutT r4 # now r4 contains the correct LSB to check

and r4 r0   # checking to see if it's 0 or 1 
            # r4 is now either 0x0000 0000 0x0000 0001
slt r5 r4   # r5 is 0, checking if r4 is 1
setBranch 31# end_checkif_highhigh
setBranch 6 # end_checkif_highhigh
rbranch0 
            # LSB is one
moveinT r1  # copy a1 into temp register for shifting
shiftLN r3  # getting the bits to go to the lower part 
            # a1 < i
setZero r4  
moveoutT r4 # r4 now contains the bits to add to lower part of intermediate
            # result
dec r6
dec r6      # r6 is now 6 for 2nd position of final result memory location 
load r6     # loading 2nd position of final result into special load-store 
            # register
setZero r5 
moveout r5  # now r5 contains 2nd position of final result 
add r5 r4   # adding the right bits to 2nd position of final result 
            # may produce overflow!
movin r5    # put result into load-store register
store r6    # storing it back to memory location 6
dec r6      # now r6 is at 5 for upper part of intermediate answer 
load r6     # moving 1st position of final result element into special
            # load-store register
inc r6
inc r6
inc r6      # r6 is now at 8
movout r5   # 1st positon of final result in r5
setZero r4
add r5 r4   # adding 0 for overflow if previous add produce overflow
mov r4 r3   # copying i into r4
negate r4   # flipping bits of i to get -i 
inc r4      # add 1 to r4 to do 2's compliment 
add r4 r6   # (-i) + 8  aka (8-i) in r4
moveinT r1  # moving a1 into special temp register for shifting
shiftRN r4  # shifting a1 right by (8-i) bits
setZero r4  
moveoutT r4 # the correct bits to add to upper part of intermediate answer is in
            # r4
add r5 r4   # adding correct bits to upper intermediate answer, 1st position of
            # final result 
            # NOT possible to have overflow!
dec r6
dec r6
dec r6      # r6 is now at 5
movein r5   # moving the upper intermediate result (1st position of final result)
            # into special load-store register
store r6    # storing 1st position of final result to memory location 5

inc r6
inc r6
inc r6      # r6 is back to 8
end_checkif_highhigh:

inc r3      # i += 1
slt r3 r6   # i < 8
setBranch -32 # highhighloop
setBranch -18 # highhighloop
rbranch1

### end high high loop
#######################################
# r0 contains 0x0000 0001, r6 contains 8
# r1-r5 free to do anything after this point
#######################################


### make sure the sign of final product is correct
setZero r1
setZero r2
setZero r3
setZero r4
setZero r5



add r7 r0   # if r7 is 2 or 0 then all 0s
            # if r7 is 1 then 0x 0000 0001
            # if is 0x0000 0001 then it's negative
slt r7 r0   # is r7 < 1 if so then r7 is 0 
            # product is positive if slt produce 1
            # then we skip the negate logic
setBranch 27# product_sign_correct
rbranch1

###### last position
            # product is negative !!!
load r6     # loading final product last position into special load-store
            # register at memory location 8
movout r1   # r1 now contains final product last position
negate r1   # flip the bits
inc r1      # +1 for 2's compliment need to check overflow logic with inc
##############
####### CONOR CONOR check here does inc uses overflow register!?!?!?!
##############
movin r1    # now last position is correct move it to load-store register
store r6    # store last position back to memory location 8


###### second to last position

dec r6      # now r6 is at 7
load r6     # loading 2nd to last position of final product into special
            # load-store register
movout r2   # r2 now contains 2nd to last position of final product
negate r2   # flip the bits of r2 
add r2 r5   # adding 0 to r2 if there was overflow from previous position then
            # this will add 1 to r2
movin r2
store r6    # store 2nd to last position of final product back to memory
            # location 7

###### second position 

dec r6      # r6 now at 6
load r6     # loading 2nd position position of final product into special
            # load-store register 
movout r3   # r3 now contains 2nd position of final product
negate r3   # flip the bits of r3
add r3 r5   # adding 0 to r3 if there was overflow from previous position then
            # this will add 1 to r3
movin r3    # moving 2nd position of final product into special load-store
            # register
store r6    # storing 2nd postion of final product into memory location 6

###### first position

dec r6     # r6 now at 5
load r6    # loading 1st position position of final product into special
           # load-store register
movout r4  # r4 now contains 1st position of final product 
negate r4  # flip the bits of r4
add r4 r5  # adding 0 to r4 if there was overflow from previous position then
           # this will add 1 to r4

movin r4   # moving 1st position of final product into special load-store
           # register
store r6   # storing 1st position of final product into memory location 5

product_sign_correct:

halt



























