void readText(){
  int i=0;
  while(readableCache==1){
    
    try {
    line[i] = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line[i] = null;
  }
  if(line[i] == null) readableCache=0;
  i++;
  }
  
}

void indexText(){
  int i=0;
  while(line[i]!=null&&line[i+1]!=null){
    loginIDPD.set(line[i], line[i+1]);
    i+=2;
  }
  println(loginIDPD);

}