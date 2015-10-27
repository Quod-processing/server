//v0.5.1

import processing.net.*;

int port = 11084;
int readableCache=1;
Server myServer;        
BufferedReader playerIDPDreader;
PrintWriter playerIDPDwriter;
int worldValid = 111111;
int[] worldValidI = new int[7];
String[] worldValidS = new String[13];
String[] line = new String[100];
StringDict Devicelogin, loginIDPD, DeviceWorld;
StringList Devices;
void setup()
{
  size(100, 100);
  background(0);
  myServer = new Server(this, port);
  playerIDPDreader = createReader("db.txt");
    Devicelogin = new StringDict();
  loginIDPD = new StringDict();
  DeviceWorld = new StringDict();
  Devices = new StringList();
  readText();
  indexText();
  playerIDPDwriter = createWriter("db.txt");


  for (int i=1; i<7; i++) worldValidI[i]=1;
}


void draw()
{
  // Get the next available client
  Client thisClient = myServer.available();
  worldValid = 0;
  for (int i=0; i<6; i++) worldValid=worldValid*10+worldValidI[6-i];
  if (frameCount%10==0) myServer.write("w"+":"+worldValid+"::");

  if (thisClient !=null) {
    String readClient[] = split(thisClient.readString(), "::");
    for (int i=0; i<readClient.length; i++) {
      String lineCache[] = split(readClient[i], ":");
      println(readClient[0]);
      if (lineCache.length>2) {

        if (lineCache[0].equals("1")) {
          if ((Devicelogin.hasKey(lineCache[2])!=true)&&(Devices.hasValue(lineCache[1])!=true)) {
            myServer.write("1"+":"+lineCache[1]+":"+lineCache[2]+":"+"true"+"::");
          } else myServer.write("1"+":"+lineCache[1]+":"+lineCache[2]+":"+"false"+"::");
        } else if (lineCache[0].equals("2")) {

          if ((loginIDPD.hasKey(lineCache[2]))&&loginIDPD.get(lineCache[2]).equals(lineCache[3])) {
            println(lineCache[2]+"loginsuccess!!!!");
            myServer.write("2"+":"+lineCache[1]+":"+lineCache[2]+":"+"true"+"::");
            Devicelogin.set(lineCache[1], lineCache[2]);
          } else myServer.write("2"+":"+lineCache[1]+":"+lineCache[2]+":"+"false"+"::");
        }
        if (lineCache[0].equals("w")) {
          if (lineCache[1]!=null) {
            println("letmein?");
            if (lineCache[1].equals("1")||lineCache[1].equals("2")||lineCache[1].equals("3")||lineCache[1].equals("4")||lineCache[1].equals("5")||lineCache[1].equals("6")) {
              worldCompute(parseInt(lineCache[1]), lineCache[2], lineCache[3]);
            }
            if (lineCache[1].equals("play")) {
              //w+play+worldID+playerID+action+xcoordinate+ycoordinate
              myServer.write("w"+":"+"play"+":"+lineCache[2]+":"+lineCache[3]+":"+lineCache[4]+":"+lineCache[5]+":"+lineCache[6]+"::");
            }
          }
        }
      }
    }
  }
}

void worldCompute(int worldNum, String playerID, String playType) {
  if (playType.equals("join")&&(worldValidI[worldNum]==1)) {
    if ((worldValidS[2*worldNum-1]==null||(worldValidS[2*worldNum-1]!=null&&!worldValidS[2*worldNum-1].equals(playerID))) && (worldValidS[2*worldNum]==null||(worldValidS[2*worldNum]!=null&&!worldValidS[2*worldNum].equals(playerID))) ) { //check if they were exist
      worldValidI[worldNum]++;
      println("hi");
      if (worldValidS[2*worldNum-1]==null) worldValidS[2*worldNum-1]=playerID;
      else worldValidS[2*worldNum]=playerID;
    }
  } else if (playType.equals("join")&&(worldValidI[worldNum]==2)) {
    worldValidI[worldNum]++;
    println("hi");
    if (worldValidS[2*worldNum-1]==null) worldValidS[2*worldNum-1]=playerID;
    else worldValidS[2*worldNum]=playerID;
    myServer.write("w"+":"+"start"+":"+worldNum+":"+worldValidS[2*worldNum-1]+":"+worldValidS[2*worldNum]+"::");
  }
  if (worldValidI[worldNum]==3) {
    if (playType.equals("blok")) {
    }
  }
}