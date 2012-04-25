
void plotscale_x(List<List<num>> Data, CanvasRenderingContext2D ctx,num width,num height){
  List<num> XData=[];
  int i,j;
  for(i=0;i<Data.length;++i){
    for(j=0;j<Data[i].length;j=j+2){
      XData.add(Data[i][j]);
    }
  }
  num max=find_max(XData);
  num max_graph=find_max_graph(max);
  num division=max_graph/10;
  ctx.font="10px Sans-Serif";
  ctx.setLineWidth(1);
    
  for(i=0;i<10;++i){
    String x=(division*(i+1)).toString();
    ctx.strokeText(x,(0.2*width+(0.07*(i+1)*width)),(0.94*height));
    ctx.beginPath();
    ctx.moveTo(0.2*width+(0.07*(i+1)*width), 0.89*height);
    ctx.lineTo(0.2*width+(0.07*(i+1)*width), (0.91*height));
    ctx.stroke();
  }
}

void plotscale_y(List<List<num>> Data, CanvasRenderingContext2D ctx,num width,num height){
  List<num> YData=[];
  int i,j;
  for(i=0;i<Data.length;++i){
    for(j=1;j<Data[i].length;j=j+2){
      YData.add(Data[i][j]);

    }
  }
  
  num max=find_max(YData);
  num max_graph=find_max_graph(max);
  num division=max_graph/10;
  ctx.font="10px Sans-Serif";
  ctx.setLineWidth(1);
    
  for(i=0;i<10;++i){
    String x=(division*(10-i)).toString();
    ctx.strokeText(x,0.13*width,0.08*height + (0.082*(i)*height));
    ctx.beginPath();
    ctx.moveTo(0.175*width, 0.08*height + (0.082*(i)*height));
    ctx.lineTo(0.2*width, 0.08*height + (0.082*i*height));
    ctx.stroke();
  }
}

num calculate_Xscale(List<List<num>> Data,num width){
  
  List<num> XData=[];
  int i,j;
  for(i=0;i<Data.length;++i){
    for(j=0;j<Data[i].length;j=j+2){
      XData.add(Data[i][j]);
    }
  }
  num avail_width=0.7*width;
  num max=find_max(XData);
  num max_graph=find_max_graph(max);
  num scale_factor=(avail_width/max_graph);
  return scale_factor;
  
}

num calculate_Yscale(List<List<num>> Data,num height){
  
  List<num> YData=[];
  int i,j;
  for(i=0;i<Data.length;++i){
    for(j=1;j<Data[i].length;j=j+2){
      YData.add(Data[i][j]);
      
    }
  }
  
  num max=find_max(YData);
  num max_graph=find_max_graph(max);
  num avail_height=0.82*height;
  //print("Max Graph : $max_graph");
  num scale_factor=(avail_height/max_graph);
  return scale_factor;
      
}

void plotline(List<num> Data, CanvasRenderingContext2D ctx,num width,num height,num Xscale,num Yscale){
  
  ctx.beginPath();
  ctx.setLineJoin("round");
  ctx.moveTo(0.2*width+(Data[0]*Xscale), 0.9*height-(Data[1]*Yscale));
  ctx.arc(0.2*width+(Data[0]*Xscale), 0.9*height-(Data[1]*Yscale), 3, 0, Math.PI*2, false);
  ctx.fill();
  ctx.setLineWidth(3);

  int i=2,j=3;
 // print("Plotting ${Data.length}");
  
  while(j<(Data.length)){
    ctx.lineTo(0.2*width+Data[i]*Xscale, 0.9*height-Data[j]*Yscale);
    ctx.arc(0.2*width+(Data[i]*Xscale), 0.9*height-(Data[j]*Yscale), 3, 0,  Math.PI*2, false);
    ctx.fill();
    print("${Data[i]},${Data[j]},${0.2*width+80*Xscale},${0.9*width}");
    j=j+2;
    i=i+2;    
  }
  ctx.stroke();
  
}



class Line extends DartGraph{
  List<List<num>> Data;
  List<String> Labels;
  String X_Title;
  String Y_Title;
  
  Line(String CanvasID,[String Title="Line Graph"]){
    this.CanvasID=CanvasID;
    this.GraphTitle=Title;
    this.X_Title="";
    this.Y_Title="";
  }
  
  void draw(){
    print("---------------------");
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
    
    
    //draw x-axis
    ctx.textAlign="center";
    ctx.strokeText(this.X_Title,width/2,0.98*height);    
    
    //draw y-axis
    ctx.save();
    ctx.translate(0.075*width,0.5*height);
    ctx.rotate(-Math.PI/2);
    ctx.textAlign="center";
    ctx.font="14px Sans-Serif";
    ctx.fillText(this.Y_Title, 0, 0 );
    ctx.restore();
    
    //draw axis
    ctx.beginPath();
    ctx.setLineWidth(4);
    ctx.moveTo(0.2*width, 0.07*height);
    ctx.lineTo(0.2*width, height - 0.1*height);
    ctx.lineTo(width-0.07*width, height - 0.1*height);
    ctx.stroke();
    
    

    
    /*
    *plotting max for graph
    */
    plotscale_x(this.Data,ctx,width,height);
    plotscale_y(this.Data,ctx,width,height);
    num Yscale=calculate_Yscale(this.Data,height);
    num Xscale=calculate_Xscale(this.Data,width);
    print("$Yscale $Xscale");
    ctx.save();
    for(int i=0;i<this.Data.length;++i){
      ctx.setStrokeColor(this.colors[i]);
      ctx.fillStyle=this.colors[i];
      plotline(this.Data[i],ctx,width,height,Xscale,Yscale);
    }
    ctx.restore();
   
    //drawlabels;
    
    ctx.strokeRect(0.8*width, 0.05*height, 0.18*width, (0.05+(this.Data.length/30))*height);
    
    for(int i=0;i<this.Data.length;++i){
      ctx.fillStyle=this.colors[i];
      ctx.fillRect(0.82*width, ((0.05+((i+1)/30))*height), 0.02*width, 0.02*height);
      ctx.textAlign="start";
      ctx.textBaseline="top";
      ctx.fillText(this.Labels[i], 0.85*width, ((0.05+((i+1)/30))*height)-0.01*height);
    }
    
    //print(this.GraphTitle);
  }
  
}