/**
 * Test Game Shizzle
 */

float x, y, z;
float objects[][];
float yawhoek, pitchhoek;
float gravity = 0.75;
float terminal_speed = 5;
float jump_speed = -6;
float dy = 0;
boolean jump = false;
boolean landed = true;
boolean[] keys;
boolean[] arrows;

void setup() {
  x = 0.0;
  y = -200.0;
  z = -1000.0;
  fill(204);
  size(1000, 400, P3D);
  objects = new float[6][3];
  
  objects[0][0] = 500.0;
  objects[0][1] = 400.0;
  objects[0][2] = 300.0;
  
  objects[1][0] = -300.0;
  objects[1][1] = -400.0;
  objects[1][2] = 100.0;
  
  objects[2][0] = -200.0;
  objects[2][1] = 600.0;
  objects[2][2] = 250.0;
  
  objects[3][0] = 200.0;
  objects[3][1] = -610.0;
  objects[3][2] = 200.0;
  
  objects[4][0] = -600.0;
  objects[4][1] = 2000.0;
  objects[4][2] = 300.0;
  
  objects[5][0] = 0.0;
  objects[5][1] = 0.0;
  objects[5][2] = 10.0;
  keys = new boolean[256];
  for (boolean b : keys)
  {
    b = false;
  }
  arrows = new boolean[4];
  for (boolean k : arrows)
  {
    k = false;
  }
}

void draw() {
  landed = false;
  if ((keys['w']) || (keys['W']))
  {
    x += 5.0 * sin(-yawhoek);
    z += 5.0 * cos(-yawhoek);
  }
  if ((keys['s']) || (keys['S']))
  {
    x -= 5.0 * sin(-yawhoek);
    z -= 5.0 * cos(-yawhoek);
  }
  if ((keys['a']) || (keys['A']))
  {
    x += 5.0 * sin(-yawhoek + PI * 0.5);
    z += 5.0 * cos(-yawhoek + PI * 0.5);
  }
  if ((keys['d']) || (keys['D']))
  {
    x -= 5.0 * sin(-yawhoek + PI * 0.5);
    z -= 5.0 * cos(-yawhoek + PI * 0.5);
  }
  if (keys[' '])
  {
    jump = true;
  }
  if (arrows[2])
  {
    yawhoek -= radians(3);
  }
  if (arrows[3])
  {
    yawhoek += radians(3);
  }
  background(100,100,255);
  if ((y >= 0) || collision())
  {
    dy = 0;
    landed = true;
  }
  if (!landed)
  {
    if (dy <= terminal_speed)
    {
      dy += gravity;
    }
  }
  else if (landed && jump)
  {
    dy = jump_speed;
  }
  if (jump)
  {
    jump = false;
  }
  y += dy;
  camera(0.0, -20.0, 0.0,
         0.0, -19.0, 5.0,
         0.0, 1.0, 0.0);
  drawObjects();
}

void drawObjects()
{
  rotateY(yawhoek);
  translate(-x, -y, -z);
  beginShape();
    vertex(-10000.0, -y, -10000.0);
    vertex(-10000.0, -y, 10000.0);
    vertex(10000.0, -y, 10000.0);
    vertex(10000.0, -y, -10000.0);
  endShape();
  fill(255);
  int i = 0;
  while (i <= 5)
  {
    translate((objects[i][0] - x), -y, (objects[i][1] - z));
    box(objects[i][2]);
    translate((x - objects[i][0]), y, (z - objects[i][1]));
    i++;
  }
  translate(x, y, z);
  fill(204);
}

boolean collision()
{
  boolean ret = false;
  for (int i=0; i <= 5; i++)
  {
    float j = objects[i][2] / 2;
    boolean a = (x > (objects[i][0] - j));
    boolean b = (x < (objects[i][0] + j));
    boolean c = (z > (objects[i][1] - j));
    boolean d = (z < (objects[i][1] + j));
    boolean e = ((y + 20) > (objects[i][2] / -2));
    ret |= (a && b && c && d && e);
  }
  return ret;
}

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP) arrows[0] = true;
    if (keyCode == DOWN) arrows[1] = true;
    if (keyCode == LEFT) arrows[2] = true;
    if (keyCode == RIGHT) arrows[3] = true;
  }
  else
  {
    keys[key] = true;
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == UP) arrows[0] = false;
    if (keyCode == DOWN) arrows[1] = false;
    if (keyCode == LEFT) arrows[2] = false;
    if (keyCode == RIGHT) arrows[3] = false;
  }
  else
  {
    keys[key] = false;
  }
}
