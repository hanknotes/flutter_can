import 'dart:ui';

class Particle {
  double x;
  double y;
  double z;
  double vx;
  double vy;
  double vz;
  double ax;
  double ay;
  double az;
  double radius; // 粒子旋转半径
  double angle; // path倾斜
  double rotate; // 自身旋转
  double initRotate; // 初始旋转角度
  double cur;// 当前路径点举例
  double curStep;// path.length的递增值，粒子旋转时 是沿着path前进的
  Offset center;// 粒子沿着path旋转时每个step的中心点

  Particle(
      {this.x = 0,
      this.y = 0,
      this.z = 0,
      this.vx = 0,
      this.vy = 0,
      this.vz = 0,
      this.ax = 0,
      this.ay = 0,
      this.az = 0,
      this.radius = 1,
      this.angle = 0,
      this.rotate = 0,
      this.initRotate =0,
        this.cur = 0,
        this.center = Offset.zero,
        this.curStep = 0
      });
}
