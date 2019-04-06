class StarField{
  /*该粒子系统包含的星星的个数
    星星越多画面越密*/
  final int STAR_COUNT = width / 2;

  /*分别代表星星移动的最大速度，最小速度，
    用来控制星星移动速度的范围*/
  final int MAX_SPEED = 11, MIN_SPEED = 1;

  /*速度改变的步长
    每一次增加或者减小速度的时速度改变的最小值*/
  final int SPEED_STEP = 1;

  /*数据类型为Star object的动态数组
    存储该星域中所有的星星*/
  ArrayList<Star> stars;

  /*消失点
    用来控制视角*/
  PVector endpoint;

  /*星星移动的速度
    控制星星移动快慢*/
  int speed;
  
  StarField(){

    /*将初始消失点设置在鼠标最开始的位置*/
    endpoint = new PVector(mouseX, mouseY);

    /*初始化所有的星星*/
    stars = new ArrayList();
    for(int i = 0; i < STAR_COUNT; i++){
      stars.add(new Star());
    }

    /*初始化星星的移动速度
      让移动速度不用太快和太慢*/
    speed = (MAX_SPEED + MIN_SPEED) / 2;
  }

  
  void run(){
   for(Star s : stars){
    /*更新在世界坐标系的坐标
      让星星飞向观察者*/
     s.move(speed);

    /*对星星进行坐标变换
      获得星星在屏幕坐标系的坐标
      用于之后的星星的渲染*/
     s.transform(endpoint);

    /*对超过超出屏幕的星星重新设置一个新的位置
      使得星星可以源源不断的出现*/
     s.checkEdge();

    /*依据屏幕坐标系渲染星星，
      使得星星在屏幕上出现*/
     s.display();
   }
  }
  
  void updateEndpoint(float x, float y){
    endpoint.x = x;
    endpoint.y = y;
  }
  
  void speedUP(){
    speed += SPEED_STEP;

    /*限制speed在最大和最小值之间
      防止速度太快*/
    speed = constrain(speed, MIN_SPEED, MAX_SPEED);
  }
  
  void speedDown(){
    speed -= SPEED_STEP;

    /*限制speed在最大和最小值之间
      防止速度小于零*/
    speed = constrain(speed, MIN_SPEED, MAX_SPEED);
  }
  
}
