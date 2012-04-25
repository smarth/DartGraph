
// auto scale according to canvas width and height 
// a method to set data and set labels

num find_max(List<num> data){
  num max=data[0];
  int i=0;
  for(i=0;i<data.length;++i){
      if(data[i]>max){
        max=data[i];
      }
  }
  return max;
}

num find_max_graph(num max){
  int n = max;
  int count = 0;
  
  while(n != 0)
  {
    n = (n/10).toInt();
    count++;
  }
  
  int mult = Math.pow(10, count-1);
  
  num maxceil = ((max/mult).toInt() + 1) * mult;
  if((maxceil-0.5*mult)>max)
      return maxceil-(0.5*mult);
  else
      return maxceil;
  
}

void plotbars(List<num> Data,List<String> Labels,List<String> Colors,CanvasRenderingContext2D ctx,num width,num height){
    num avail_width=0.675*width;
    num avail_height=0.85*height;
    num max=find_max(Data);
    num max_graph=find_max_graph(max);
    num total_bars=Data.length;
    num bar_width=avail_width/total_bars;
    num scale_factor=(avail_height/max_graph);
    int i;
    for(i=0;i<Data.length;++i){
      num bar_height= scale_factor*Data[i];
      
      ctx.fillStyle=Colors[i];
      ctx.textAlign="center";
      ctx.strokeText(Labels[i], (0.25*width)+(i*bar_width)+0.375*bar_width, 0.91*height-bar_height);
      ctx.fillRect((0.25*width)+(i*bar_width),0.93*height-bar_height-2,0.75*bar_width ,bar_height);  
    }
}



void plotscale(List<num> Data, CanvasRenderingContext2D ctx,num width,num height){
  num max=find_max(Data);
  num max_graph=find_max_graph(max);
  num division=max_graph/10;
  ctx.font="10px Sans-Serif";
  ctx.font="10px Sans-Serif";
  ctx.setLineWidth(1);
  int i;
    
  for(i=0;i<10;++i){
    String x=(division*(10-i)).toString();
    print(x);
    ctx.strokeText(x,0.13*width,0.08*height+(0.085*i*height));
    ctx.beginPath();
    ctx.moveTo(0.175*width, 0.08*height + (0.085*(i)*height));
    ctx.lineTo(0.2*width, 0.08*height + (0.085*i*height));
    print(i);
    ctx.stroke();
  }
}


class Bar extends DartGraph{
  List<num> Data;
  List<String> Labels;
  String X_Title;
  String Y_Title;
  
  Bar(String CanvasID,[String Title="Bar Graph"]){
    this.X_Title="";
    this.Y_Title="";
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
    
    
    //draw x-axis
    ctx.textAlign="center";
    ctx.strokeText(this.X_Title,width/2,0.97*height);    
    
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
    ctx.lineTo(0.2*width, height - 0.07*height);
    ctx.lineTo(width-0.07*width, height - 0.07*height);
    ctx.stroke();
    
    

    
    /*
    *plotting max for graph
    */
    plotscale(this.Data,ctx,width,height);
    plotbars(this.Data,this.Labels,this.colors,ctx,width,height);
    
    //print(this.GraphTitle);
  }
  
}