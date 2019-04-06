class Star{
  /*星星在屏幕坐标系直径的最大值
    用于控制星星在屏幕上的整体大小*/
  final float MAX_DIAM = 16;

  /*星星里屏幕最远的距离
    用来控制星域的立体感*/
  final float MAX_DEPTH = width / 2;

  /*进行坐标变换时候的
    用来控制星星在屏幕上的分布范围*/
  final float SCALE = MAX_DEPTH;

  /*星星在三个坐标系下的坐标
    记录它们在不同参考系下的位置*/
  PVector worldPosition, screenPosition, viewPosition;

  /*星星在屏幕坐标系下的直径
    确定星星在屏幕上的大小*/
  float diam;

  Star(){
    /*在一个长方体区域内随机生成一个点
      返回它在世界坐标系下的坐标*/
    worldPosition = new PVector(random(0, width), random(0, height), random(0, MAX_DEPTH));
  }
  
  void move(float speed){
     worldPosition.z -= speed;

     /*限制星星世界坐标系的位置
       防止出现星星移动到屏幕外的情况*/
     worldPosition.z = constrain(worldPosition.z, 0, MAX_DEPTH);
  }
  
  void transform(PVector endpoint){
    /*将星星的坐标从世界世界坐标系变换到消失点坐标系
      以下代码等同于：
      viewPosition.x = (worldPosition.x - endpoint.x) / worldPosition.z * SCALE;
      viewPosition.y = (worldPosition.y - endpoint.y) / worldPosition.z * SCALE;
      */
    viewPosition = PVector.sub(worldPosition, endpoint).div(worldPosition.z).mult(SCALE);

    /*将星星的坐标从消失点坐标系变换到屏幕坐标系
      以下代码等同与：
      screenPosition.x = endpoint.x + viewPosition.x;
      screenPosition.y = endpoint.y + viewPosition.y;
      */
    screenPosition = PVector.add(endpoint, viewPosition);

    /*根据世界坐标z的大小来确定星星的直径
      z越小，说明越靠近屏幕，所以星星越大*/
    diam = map(worldPosition.z, 0, MAX_DEPTH, MAX_DIAM, 0);
  }
  
  void checkEdge(){
    if(screenPosition.x <= 0 || screenPosition.x >= width || screenPosition.y <=0 || screenPosition.y >= height){
      /*如果这个点已经在屏幕外了，那么将其裁剪，
        同时在相同的长方体区域随机生成一个新的点*/
      worldPosition.set(random(0, width), random(0, height), MAX_DEPTH); 
    } 
  }
 
  void display(){
    /*在屏幕上绘制该星星
      每一个星星是一个白色的、没有边的圆*/
    fill(255);
    noStroke();
    ellipse(screenPosition.x, screenPosition.y, diam, diam);
  }
  
}
