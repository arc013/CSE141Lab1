string = location 9 //set reg1 to zero reg then load

int [] array = location 32  //set reg2 to zero reg then load

int count = 0   // reg 3 to zero  

for (i = 0; i < 64; i++){ //reg 4 as i

  temp = array[i] // load array i to reg 2


 /* for (j = 0; j < 5; j++) {  // reg 5 as j
    temp = temp < (5-j+1) // reg 6 as (5-j+1)
    temp = temp > 4
    if temp == string {
      count = count + 1 
    }
  }*/



  local = temp & 0x0f
  if local == string{
    count += 1;
  }

  temp = temp > 1
  local = temp & 0x0f
   if local == string{
    count += 1;
  }

  local = temp > 1
  local = temp & 0x0f   
   if local == string{
    count += 1;
  }

  local = temp > 1
  local = temp & 0x0f
   if local == string{
    count += 1;
  }

  local = temp > 1
  local = temp & 0x0f
   if local == string{
    count += 1;
  }

  if count == 1  {

    array[10]++

    //load memory location 10 
    //add 1 
    //store back

  } elif count == 2 {
    //load memory location 11 
    //add 1 
    //store back
    array[11]++


  } elif count == 3 {
    //load memory location 12 
    //add 1 
    //store back
    array[12]++

  } elif count == 4 {
    //load memory location 13 
    //add 1 
    //store back
    array[13]++


  } elif count == 5 {
    //load memory location 14 
    //add 1 
    //store back
    array[14]++

  }
  count = 0



}
//9bits 
//
//
//
/
