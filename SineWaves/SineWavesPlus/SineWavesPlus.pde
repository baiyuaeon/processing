GridSystem gs;
void setup(){
  size(500, 500);
  colorMode(HSB, 100);
  //三个参数分别是格子的行数、列数以及边框的宽度。
  gs = new GridSystem(10, 10, 50); 
}

void draw(){
  background(16);
  gs.run();
}

void keyPressed(){
  gs.changeRenderMode();
}

class GridSystem{
  ArrayList<Grid> grids;
  float gridSize, border;
  
  GridSystem(float row, float col, float _border){
    border = _border;
    
    //根据容器的宽度和边框宽度计算每一个格子的大小。
    gridSize = (width - border * 2) / col;
    
    //对每一个格子进行初始化。
    grids = new ArrayList<Grid>();
    for(int i = 0 ; i < row; i++){
      for(int j = 0; j < col; j++){
      
    //三个参数分别是：行号、列号、格子大小。
        grids.add(new Grid(i, j, gridSize));
      }
    }
  }
  
  void run(){
    //改变绘制的坐标原点。
    translate(border, border);
    for(Grid g : grids){
    //更新并绘制每一个格子内的波动图案。
      g.update();
      g.display();
    }
  }
  
  void changeRenderMode(){
    //改变每一个波动图像的渲染模式
    for(Grid g : grids){
      g.changeRenderMode();
    }
  }
}

class Grid{
    //声明一些控制波动图案展现的参数。
    float waveWidth, size;
    float xPos, yPos;
    float phase, startPhase, phaseStep;
    float theta, amplitude, period;
    float c;
    final int STROKE_MODE = 0, FILL_MODE = 1;
    float mode = STROKE_MODE;
  
  Grid(float rowIndex, float colIndex, float _size){
    //格子和波动的大小
    size = _size;
    waveWidth = size * 0.8;
  
    //每个格子的中心位置
      xPos = colIndex * size + size / 2;
      yPos = rowIndex * size + size / 2;
  
    //周期
      period = TAU * pow(2, random(5));
  
    //振幅
     amplitude = map(montecarlo(), 0, 1, 0, size / 2 * 0.7);
  
    //初相
      startPhase = 0;
  
    //移动方向
      if(random(1) < 0.5){
        phaseStep = TAU / 128;
      }else{
        phaseStep = -TAU / 128;
      }
  
    //旋转角度
    theta = randomGaussian() * 2;
     
    //颜色
    c = map(noise(rowIndex / 10, colIndex / 10), 0, 1, 0, 100);
      

   }

  void update(){
    //更新初相startPhase
    //如果phaseStep > 0，startPhase变大，图像向左移动
    //如果phaseStep < 0，startPhase变小，图像向右移动
    startPhase += phaseStep;
    phase = startPhase;
  }

  void display(){
     pushMatrix();
     
     //绘制的原点为每一个格子的中心。
     translate(xPos, yPos);
  
     //颜色
    if(mode == STROKE_MODE){
       noFill();
       stroke(c, 100, 100);
    }else if(mode == FILL_MODE){
       noStroke();
       fill(c, 100, 100);
    }
  
     //旋转角度
     rotate(theta);
  
     //自定义图形
     beginShape();
     
     //根据指定Asin(Tx+P)函数在区间[-waveWidth/2, waveWidth/2]生成一系列的点。
     for(float x = -waveWidth / 2; x < waveWidth / 2; x++){
       float y = sin(x * period + phase) * amplitude;
       vertex(x, y);
     }
     endShape();
     popMatrix();
  }
  
  void changeRenderMode(){
     //mode在0和1之间切换
     mode++;
     mode %= 2;
  }
  
  float montecarlo() {
    while (true) {
      float r1 = random(1);
      float probability = r1;
      float r2 = random(1);
      if (r2 < probability) {
        return r1;
      }
    }
  }
  
}
