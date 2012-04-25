
class Pie extends DartGraph{
  List<num> Data;
  List<String> Labels;

  
  Pie(String CanvasID,[String Title="Pie Graph"]){
    this.CanvasID=CanvasID;
    this.GraphTitle=Title;
  }
  
  void draw(){
    CanvasElement GraphCanvas=document.query("#${this.CanvasID}");
    CanvasRenderingContext2D ctx = GraphCanvas.getContext("2d");
    int width=GraphCanvas.width;
    int height=GraphCanvas.height;
    ctx.clearRect(0, 0, width, height);
    ctx.font="14px Sans-Serif";
    ctx.textAlign="start";
    ctx.strokeRect(0, 0, width, height);
    
    //draw graph title
    ctx.fillText(this.GraphTitle, 0.05*width + (width-(ctx.measureText(this.GraphTitle).width))/2, 0.05*height);
    
    //labels for Pie Chart
    ctx.strokeRect(0.8*width, 0.05*height, 0.18*width, (0.05+(this.Data.length/30))*height);
 
   
    
    for(int i=0;i<this.Data.length;++i){
      ctx.fillStyle=this.colors[i];
      ctx.fillRect(0.82*width, ((0.05+((i+1)/30))*height), 0.02*width, 0.02*height);
      ctx.textAlign="start";
      ctx.textBaseline="top";
      ctx.fillText(this.Labels[i], 0.85*width, ((0.05+((i+1)/30))*height)-0.01*height);
    }
    

    num avail_width=0.7*width;
    num avail_height=0.85*height;
    num radius=avail_height/2;
    if(avail_width<avail_height){
      radius=avail_width/2;
    }
    num total=0;
    for(int i=0;i<this.Data.length;++i){
      total+=this.Data[i];
    }
    
    num start=0;
    ctx.setLineJoin("round");
    
    for(int i=0;i<this.Data.length;++i){
      print(start);
      ctx.fillStyle=this.colors[i];
     
      
      ctx.beginPath();
      ctx.arc(0.4*width, 0.5*height, radius, start, start+Math.PI*2*(this.Data[i]/total),false);
      ctx.lineTo(0.4*width,0.5*height);
      ctx.closePath();
      
      ctx.fill();       
      start+=Math.PI*2*(this.Data[i]/total); 

    }


    
  
    
  }
  
}