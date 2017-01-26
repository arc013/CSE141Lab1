char a1 = array[1]; 
char a2 = array[2];
char b1 = array[3];
char b2 = array[4];

array[0] = 0; /*check final product positive or negative
               * odd is negative 
               * even is positvie
               */

char mask  = 0x1000 0000
//char ones  = 0x1111 1111
//char zeros = 0x0000 0000


// if a is negative then negate a
//
char check = 0; //store into array[5] to indicate positive or negative;

//negate logic needs fixing (a1a2 is negative) 
if ( (a1 & mask) == mask ) {
  a1 = ~a1; 
  a2 = ~a2;

  a2 += 1; //carry out
  a1 += carry_out;
  check += 1;
}


if ( (b1 & mask) == mask ) {
  b1 = ~b1;
  b2 = ~b2;

  b2 += 1;
  b1 += carry_out;
  check += 1;
}

array[0] = check;



char final_upper1 = 0;
char final_upper2 = 0;
char final_lower1 = 0;
char final_lower2 = 0;

//a2b2 (low low) 
//
//
char lower_a2b2=0;
char upper_a2b2=0;
mask = mask > 7; //mask is 0x00000001
int i; 
for (i=0; i<8; i++){

  char tempb = b2 > i; //getting the bit in b2
  tempb2 = tempb2 & mask;

  //if bit is 1
  if tempb != 0 {
    //lower part
    tempb = a2 < i;
    lower_a2b2 += tempb; //carry out


    
    array[7] += tempb;


    //upper part 
    upper_a2b2 += carry_out;
    tempb = a2 > (8-i) ; 
    upper_a2b2 += tempb;
    array[8] += tempb;



  } 
}

//store back to memory
//final_lower2 += lower_a2b2;
//final_lower1 += upper_a2b2;
//array[7] = final_lower1;
//array[8] = final_lower2;



//load mem 1 and 4

//high low

char lower_a1b2=0;
char upper_a1b2=0;

for (i=0; i<8; i++){

  char tempb = b2 > i;
  tempb = tempb & mask;
  if tempb != 0 {
    //lower part
    tempb = a1 < i;
    lower_a1b2 += tempb; //carry out

    //upper part
    upper_a1b2 += carry_out;
    tempb = a1 > (8-i) ; 
    upper_a1b2 += tempb;
  } 
}


//store back
final_lower1 += lower_a1b2; //carry out
final_upper2 += carry_out; 
final_upper2 += upper_a1b2; //carry out
final_upper1 += carry_out;
array[5] = final_upper1;
array[6] = final_upper2;
array[7] = final_lower1;




// low high
char lower_a2b1=0;
char upper_a2b1=0;

for (i=0; i<8; i++){

  char tempb = b1 > i;
  tempb = tempb & mask;
  if tempb != 0 {
    //lower part
    tempb = a2 < i;
    lower_a2b1 += tempb; //carry out

    //upper part
    upper_a1b2 += carry_out;
    tempb = a2 > (8-i) ; 
    upper_a2b1 += tempb;
  } 
}

//store back
final_lower1 += lower_a2b1; //carry out
final_upper2 += carry_out; 
final_upper2 += upper_a2b1; //carry out
final_upper1 += carry_out;
array[5] = final_upper1;
array[6] = final_upper2;
array[7] = final_lower1;


//high high

char lower_a1b1=0;
char upper_a1b1=0;

for (i=0; i<8; i++){

  char tempb = b1 > i;
  tempb = tempb & mask;
  if tempb != 0 {
    //lower part
    tempb = a1 < i;
    lower_a1b1 += tempb; //carry out

    //upper part
    upper_a1b2 += carry_out;
    tempb = a1 > (8-i) ; 
    upper_a1b1 += tempb;
  } 
}


//store back
final_upper2 += lower_a1b1; //carry out
final_upper1 += carry_out;
final_upper1 += upper_a1b1;
array[5] = final_upper1;
array[6] = final_upper2;



//reuse ones, zeros, and mask registers for final storing 


/*check even or odd 
 * even means positive odd is negative
 * if it's negative then need to negate 
 */
if (array[0] %2 != 0){
  final_upper1 = ~final_upper1;
  final_upper2 = ~final_upper2;
  final_lower1 = ~final_lower1;
  final_lower2 = ~final_lower2;
  final_lower2 += 1; //carry out
  final_lower1 += carry_out; //carry out
  final_upper2 += carry_out; //carry out
  final_upper1 += carry_out; //carry out
  array[5] = final_upper1;
  array[6] = final_upper2;
  array[7] = final_lower1;
  array[8] = final_lower2;
}







