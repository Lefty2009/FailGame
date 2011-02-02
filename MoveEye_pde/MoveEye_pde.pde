/**
 * Test Game Shizzle
 */

float x, y, z;
Doos[] objects;
float yawhoek, pitchhoek;
float gravity = 0.75;
float terminal_speed = 4;
float jump_speed = -5;
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
  objects = new Doos[7];
  
  objects[0] = new Doos(500.0, 400.0, 300.0, 0);
  objects[1] = new Doos(-300.0, -400.0, 100.0, 0);  
  objects[2] = new Doos(-200.0, 600.0, 250.0, 0);
  objects[3] = new Doos(200.0, -610.0 , 200.0, 0);
  objects[4] = new Doos(-600.0, 2000.0, 300.0, 0);
  objects[5] = new Doos(0.0, 0.0, 10.0, 0);
  objects[6] = new Doos(-10000.0, 0.0, -10000.0, 10000.0, 1.0, 10000.0, 204);

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
  if (arrows[0])
  {
    pitchhoek += radians(3);
  }
  if (arrows[1])
  {
    pitchhoek -= radians(3);
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
  jump = false;
  y += dy;
  camera(0.0, -20.0, 0.0,
         0.0, -19.0, 5.0,
         0.0, 1.0, 0.0);
  drawObjects();
}

void drawObjects()
{
  rotateY(yawhoek);
  for (Doos d : objects)
  {
    d.draw(x, y, z);
  }
}

boolean collision()
{
  for (Doos d : objects)
  {
    if (d.inDoos(x, y, z)) return true;
  }
  return false;

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
