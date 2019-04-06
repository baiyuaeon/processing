/*这个是一个由星星构成的粒子系统
  拥有星星的所有状态和行为*/
StarField sf;
void setup(){
  size(400, 400);
  sf = new StarField();
}

void draw(){
  background(0);
  /*运行星域系统
    更新星星的状态和绘制星星*/
  sf.run();
}

/*鼠标按下时调用的函数
  用来改变星域的速度*/
void mousePressed(){
  if(mouseButton == LEFT){
    /*如果是鼠标左键按下了
     提高星域的速度*/
    sf.speedUP();
  }else if(mouseButton == RIGHT){
    /*如果是鼠标右键按下了
     降低星域的速度*/
    sf.speedDown();
  }
}

/*鼠标移动的时候调用的函数
  用来改变视角*/
void mouseMoved(){
  /*根据鼠标的位置来更新消失点的位置
    达到改变视角的目的*/
  sf.updateEndpoint(mouseX, mouseY);
}
