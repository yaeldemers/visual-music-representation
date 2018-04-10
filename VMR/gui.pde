import java.util.ArrayList;
import java.util.List;

  
  XML xml;
  XML [] measureList;
  XML [] noteList;
  XML attributes;
  boolean isFlat = false;
  boolean isSharp = false;
  boolean isNat = false;
  int division = 0;
  String step = " ";
  String mode = " ";
  float data[][] = new float [1][1];
  float modeList [][] = new float [2][5];
  int c = 0;
  int loopMod = 0;
  int loopMod2 = 0;
  float scale =1;
  float xPan = 500;
  float yPan = 500;
  float zoomSpeed = 1.1;
  float panSpeed =7;
  boolean zoomIn = false;
  boolean zoomOut = false;
  boolean up = false;
  boolean down = false;
  boolean left = false;
  boolean right = false;
  String noteName1;
  String noteName2;
  int signature;
  String [] signaNotes;
  String filename;
  String partnumber;
boolean ifdraw = false;
public void imgButton1_click1(GImageButton source, GEvent event) { //_CODE_:imgButton1:849244:
} //_CODE_:imgButton1:849244:

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:789174:
  folderSelected();
}
public void folderSelected() {
 
  filename = textfield1.getText();
  partnumber = textfield2.getText();
  xml = loadXML(filename);
  if (xml == null) {
    println("XML could not be parsed.");
  } 
  else {
    
    XML[] part = xml.getChildren("part");
    
    measureList = part[int(partnumber)-1].getChildren("measure");
    
    signature = measureList[0].getChild("attributes").getChild("key").getChild("fifths").getIntContent();
    if (signature !=0){
    signaNotes = noteModif(signature);
    }
    attributes = measureList[0].getChild("attributes");
    division = attributes.getChild("divisions").getIntContent();
    
    noteList = measureList[0].getChildren("note");
    for(int i=1; i<measureList.length ; i++){
     noteList = (XML[]) concat(noteList , measureList[i].getChildren("note")); 
    }
    
    data = new float[3][noteList.length];
    
     for(int j=0; j<noteList.length; j++){
       if(noteList[j].getString("default-x") == null){
       data[0][j]= 0;
       data[1][j]= float(noteList[j].getChild("duration").getIntContent())/division;
       data[2][j]= j;
       }
       else if(noteList[j].getChild("grace") == null){
         
         if(j>0 && noteList[j].getFloat("default-x") < noteList[j-1].getFloat("default-x")){
          for(int f=0; f<modeList[1].length; f++){
            for(int l=0; l<modeList.length; l++){
              modeList[l][f]=0;
            }
          }
          isFlat = false;
          isSharp = false;
          isNat = false;
         }
         
         step = noteList[j].getChild("pitch").getChild("step").getContent();
         
         data[1][j]= float(noteList[j].getChild("duration").getIntContent())/division;
         data[2][j]= noteList[j].getFloat("default-x");
          
         if(noteList[j].getChild("accidental") == null){
           for(int w=0; w<modeList[1].length; w++){
            if(modeList[0][w] == 1){
             if(modeList[1][w] == noteList[j].getFloat("default-y")){
              isFlat = true;
             }
            }
            if(modeList[0][w] == 2){
             if(modeList[1][w] == noteList[j].getFloat("default-y")){
              isSharp = true;
             }
            }
            if(modeList[0][w] == 3){
             if(modeList[1][w] == noteList[j].getFloat("default-y")){
              isNat = true;
             }
            }
           }
         }
         else{
         mode = noteList[j].getChild("accidental").getContent();
         
         switch (mode){
           case "flat":
           for(int y=0; y<modeList[1].length;y++){
             if(modeList[0][y] == 0){
               c = y;
               break;
             }
           }
           modeList[0][c] = 1;
           modeList[1][c] = noteList[j].getFloat("default-y");
             isFlat = true;
           for(int d=0; d<modeList[1].length;d++){
             if(modeList[0][d] == 3){
               isFlat = false;
               break;
             }
           }
           
           break;
           case "sharp":
             for(int u=0; u<modeList[1].length;u++){
             if(modeList[0][u] == 0){
               c = u;
               break;
             }
           }
           modeList[0][c] = 2;
           modeList[1][c] = noteList[j].getFloat("default-y");
             isSharp = true;
             for(int e=0; e<modeList[1].length;e++){
             if(modeList[0][e] == 3){
               isSharp = false;
               break;
             }
           }
           break;
           case "natural":
             for(int w=0; w<modeList[1].length;w++){
             if(modeList[0][w] == 0){
               c = w;
               break;
             }
           }
           modeList[0][c] = 3;
           modeList[1][c] = noteList[j].getFloat("default-y");
             isNat = true;
           break;
           
         }
         }
           
         
         switch (step){
          case "A":
          data[0][j] = 1;
          if(signature != 0){
          for(int t=0; t<signaNotes.length; t++){
             if(signature<0 && step == signaNotes[t] && isNat != true){
              data[0][j] -= 1; 
             }
             else if (signature>0 && step == signaNotes[t] && isNat != true){
               data[0][j] += 1;
             }
            }
          }
            if (isFlat == true){
              if(isNat != true){
                data[0][j] += 11;
              }
            }
            else if (isSharp == true){
              if(isNat != true){
                data[0][j] += 1;
              }
            }
            
          break;
          case "B":
            data[0][j] = 3;
            if(signature != 0){
            for(int t=0; t<signaNotes.length; t++){
             if(signature<0 && step == signaNotes[t] && isNat != true){
              data[0][j] -= 1; 
             }
             else if (signature>0 && step == signaNotes[t] && isNat != true){
               data[0][j] += 1;
             }
            }
            }
            if (isFlat == true){
              if(isNat != true){
                data[0][j]-= 1;
              }
            }
            else if (isSharp == true){
              if(isNat != true){
              
                data[0][j]+= 1;
              }
            }
          break;
          case "C":
            data[0][j] = 4;
            if(signature != 0){
            for(int t=0; t<signaNotes.length; t++){
             if(signature<0 && step == signaNotes[t] && isNat != true){
              data[0][j] -= 1; 
             }
             else if (signature>0 && step == signaNotes[t] && isNat != true){
               data[0][j] += 1;
             }
            }
            }
            if (isFlat == true){
              if(isNat != true){
               
                data[0][j]-= 1;
              }
            }
            else if (isSharp == true){
              if(isNat != true){
               
                data[0][j] += 1;
              }
            }
          
          break;
          case "D":
            data[0][j] = 6;
            if(signature != 0){
            for(int t=0; t<signaNotes.length; t++){
             if(signature<0 && step == signaNotes[t] && isNat != true){
              data[0][j] -= 1; 
             }
             else if (signature>0 && step == signaNotes[t] && isNat != true){
               data[0][j] += 1;
             }
            }
            }
            if (isFlat == true){
              if(isNat != true){
               
                data[0][j] -= 1;
              }
            }
            else if (isSharp == true){
              if(isNat != true){
               
                data[0][j] += 1;
              }
            }
          break;
          case "E":
            data[0][j] = 8;
            if(signature != 0){
            for(int t=0; t<signaNotes.length; t++){
             if(signature<0 && step == signaNotes[t] && isNat != true){
              data[0][j] -= 1; 
             }
             else if (signature>0 && step == signaNotes[t] && isNat != true){
               data[0][j] += 1;
             }
            }
            }
            if (isFlat == true){
              if(isNat != true){
               
                data[0][j] -= 1;
              }
            }
            else if (isSharp == true){
              if(isNat != true){
              
                data[0][j] += 1;
              }
            }
          break;
          case "F":
            data[0][j] = 9;
            if(signature != 0){
            for(int t=0; t<signaNotes.length; t++){
             if(signature<0 && step == signaNotes[t] && isNat != true){
              data[0][j] -= 1; 
             }
             else if (signature>0 && step == signaNotes[t] && isNat != true){
               data[0][j] += 1;
             }
            }
            }
            if (isFlat == true){
              if(isNat != true){
               
                data[0][j] -= 1;
              }
            }
            else if (isSharp == true){
              if(isNat != true){
               
                data[0][j] += 1;
              }
            }
          break;
          case "G":
            data[0][j] = 11;
            if(signature != 0){
            for(int t=0; t<signaNotes.length; t++){
             if(signature<0 && step == signaNotes[t] && isNat != true){
              data[0][j] -= 1; 
             }
             else if (signature>0 && step == signaNotes[t] && isNat != true){
               data[0][j] += 1;
             }
            }
            }
            if (isFlat == true){
              if(isNat != true){
               
                data[0][j] -= 1;
              }
            }
            else if (isSharp == true){
              if(isNat != true){
               
                data[0][j] += 1;
              }
            }
          break;
         }
        }
         
       }
    
  }
 ifdraw = true;
}
String noteDeterm(int Data){
  switch (Data){
   case 0:
   return "R";
   case 1:
   return "A";
   case 2:
   return "A#";
   case 3:
   return "B";
   case 4:
   return "C";
   case 5:
   return "C#";
   case 6:
   return "D";
   case 7:
   return "D#";
   case 8:
   return "E";
   case 9:
   return "F";
   case 10:
   return "F#";
   case 11:
   return "G";
   case 12:
   return "G#";
   default:
   return "R";
  }
}

String[] noteModif(int noteSigna){
  String[] tempNotes;
  switch(noteSigna){
   case 1:
   tempNotes = new String[] {"F"};
   return tempNotes;
   case 2:
   tempNotes = new String[] {"F", "C"};
   return tempNotes;
   case 3:
   tempNotes = new String[] {"F", "C", "G"};
   return tempNotes;
   case 4:
   tempNotes = new String[] {"F", "C", "G", "D"};
   return tempNotes;
   case 5:
   tempNotes = new String[] {"F", "C", "G", "D", "A"};
   return tempNotes;
   case 6:
   tempNotes = new String[] {"F", "C", "G", "D", "A", "E"};
   return tempNotes;
   case 7:
   tempNotes = new String[] {"F", "C", "G", "D", "A", "E", "B"};
   return tempNotes;
   case -1:
   tempNotes = new String[] {"B"};
   return tempNotes;
   case -2:
   tempNotes = new String[] {"B", "E"};
   return tempNotes;
   case -3:
   tempNotes = new String[] {"B", "E", "A"};
   return tempNotes;
   case -4:
   tempNotes = new String[] {"B", "E", "A", "D"};
   return tempNotes;
   case -5:
   tempNotes = new String[] {"B", "E", "A", "D", "G"};
   return tempNotes;
   case -6:
   tempNotes = new String[] {"B", "E", "A", "D", "G", "C"};
   return tempNotes;
   case -7:
   tempNotes = new String[] {"B", "E", "A", "D", "G", "C", "F"};
   return tempNotes;
   default:
   tempNotes = new String[] {"R"};
   return tempNotes;
  }
}

//} //_CODE_:button1:789174:

public void textfield1_change1(GTextField source, GEvent event) { //_CODE_:textfield1:470135:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield1:470135:

public void textfield2_change1(GTextField source, GEvent event) { //_CODE_:textfield2:264927:
  println("textfield2 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield2:264927:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  imgButton1 = new GImageButton(this, 0, 40, new String[] { "VMR_logo.png", "VMR_logo.png", "VMR_logo.png" } );
  imgButton1.addEventHandler(this, "imgButton1_click1");
  button1 = new GButton(this, 70, 340, 110, 30);
  button1.setText("Vizualise File");
  button1.setTextBold();
  button1.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  button1.addEventHandler(this, "button1_click1");
  label1 = new GLabel(this, 0, 410, 250, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("C. Barre. Y.J. Demers. F.A. Johnson - 2018");
  label1.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label1.setLocalColor(2, color(255));
  label1.setOpaque(false);
  togGroup1 = new GToggleGroup();
  textfield1 = new GTextField(this, 40, 210, 170, 20, G4P.SCROLLBARS_NONE);
  textfield1.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  textfield1.setOpaque(true);
  textfield1.addEventHandler(this, "textfield1_change1");
  label2 = new GLabel(this, 30, 180, 190, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Insert the chosen file name");
  label2.setTextBold();
  label2.setLocalColor(2, color(255));
  label2.setOpaque(false);
  label3 = new GLabel(this, 20, 260, 210, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Insert the chosen part number");
  label3.setTextBold();
  label3.setLocalColor(2, color(255));
  label3.setOpaque(false);
  textfield2 = new GTextField(this, 70, 290, 110, 20, G4P.SCROLLBARS_NONE);
  textfield2.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  textfield2.setOpaque(true);
  textfield2.addEventHandler(this, "textfield2_change1");
}

// Variable declarations 
// autogenerated do not edit
GImageButton imgButton1; 
GButton button1; 
GLabel label1; 
GToggleGroup togGroup1; 
GTextField textfield1; 
GLabel label2; 
GLabel label3; 
GTextField textfield2; 
