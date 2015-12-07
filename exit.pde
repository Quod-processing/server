void exit(){
  loginIDPD.sortKeys();
  String[] loginID = loginIDPD.keyArray();
  String[] loginPD = loginIDPD.valueArray();
  println(loginID);
  println(loginPD);
  for(int i=0; i<loginID.length; i++){
    playerIDPDwriter.println(loginID[i]);
    playerIDPDwriter.println(loginPD[i]);
  }
  playerIDPDwriter.flush();
  playerIDPDwriter.close();
}