#import('dart:html');

#source('Bar.dart');
#source('Line.dart');
#source('Pie.dart');


/*
* Gives list of supported types
*/



class DartGraph {
  
  /*
  * Supported Types for the library
  * Bar ,Line And Pie
  */  
  
  /*
  * Default colours to be used for graph
  */
  List<String> colors;  
  /*
  * Tells the type of Graph
  * We van have bar,pie etc.
  */
  //String type;
  /*
  * ID of canvas used for drawing graphs
  */
  String CanvasID;

  /*
  * Main Title for Graph 
  */
  String GraphTitle;
    

  
  DartGraph() {
    this.colors = ["#f00","#0f0","#00f","#0ff","#ff0","#f0f"];
   
  }


  
  static bar(String CanvasID){
  
    return new Bar(CanvasID);
    
  }
  static line(String CanvasID){
    return new Line(CanvasID);
  }
  
  static pie(String CanvasID){
    return new Pie(CanvasID);
  }
  
}

void main(){
  //Bar Graph Example
  Bar b=DartGraph.bar("canvas1");
  b.Labels=["Australia","India","Pakistan","AA","BBB","C","DDD","E"];
  b.Data=[10,20,30,40,50,60,70,80];
  b.colors=["#f00","green","#00f","#0ff","#ff0","#f0f","#000","#ccc"];
  b.GraphTitle="GDP growth Or whatever";
  b.Y_Title="Percentage of Growth in last 10 years";
  b.X_Title="Countries";
  b.draw();
  
  //Pie Graph Example
  Bar p=DartGraph.pie("canvas2");
  p.Labels=["Australia","India","Pakistan","AA","BBB","C","DDD","E"];
  p.Data=[10,20,30,40,50,60,70,80];
  p.colors=["#f00","green","#00f","#0ff","#ff0","#f0f","#000","#ccc"];
  p.GraphTitle="GDP growth In Last 10 years";
  p.draw();
  
  //Line Graph Example
  Bar l=DartGraph.line("canvas3");
  l.Labels=["Australia","India","Pakistan"];
  l.Data=[[10,20,30,40,50,60,70,80],[25,25,35,45,55,57,75,77,95,105],[17,20,27,30,45,40,55,65,75,90,97,100]];
  l.colors=["#f00","green","#00f"];
  l.GraphTitle="Salaries And Ages Groups in Various Countries";
  l.Y_Title="Average Salary in Thousands";
  l.X_Title="Age Groups";
  l.draw();
  
}

