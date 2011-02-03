import processing.opengl.*;
/**
 * Test Game Shizzle
 */

float x, y, z;
Weirdo[] objects;
float yawhoek, pitchhoek;
float gravity = 0.5;
float terminal_speed = 8;
float jump_speed = -10;
float dy = 0;
float dx = 5.0;
boolean jump = false;
boolean landed = true;
boolean[] keys;
boolean[] arrows;

void setup() {
  x = 0.0;
  y = -200.0;
  z = -2000.0;
  fill(204);
  size(1000, 400, OPENGL);
  PImage skin = loadImage("grasstexture.jpg");
  PImage skin2 = loadImage("woodtexture2.jpg");
  objects = new Weirdo[7];
  
  objects[0] = new Doos(500.0, 400.0, 220.0, skin2);
  objects[1] = new Doos(-300.0, -400.0, 150.0, skin2);
  objects[2] = new Doos(-200.0, 600.0, 250.0, skin2);
  objects[3] = new Doos(200.0, -610.0 , 200.0, skin2);
  objects[4] = new Doos(-600.0, 2000.0, 300.0, skin2);
  objects[5] = new Doos(0.0, 0.0, 50.0, skin2);
  objects[6] = new XZPlane(-5000.0, 0.0,  -5000.0, 5000.0, 0.0, 5000.0, skin);

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
  noStroke();
}

void draw() {
  spotLight(200,200,200, -3000, -2000, -3000, 1, 1, 1, radians(180), 10);
  landed = false;
  if ((keys['w']) || (keys['W']))
  {
    x += dx * sin(-yawhoek);
    z += dx * cos(-yawhoek);
  }
  if ((keys['s']) || (keys['S']))
  {
    x -= dx * sin(-yawhoek);
    z -= dx * cos(-yawhoek);
  }
  if ((keys['a']) || (keys['A']))
  {
    x += dx * sin(-yawhoek + PI * 0.5);
    z += dx * cos(-yawhoek + PI * 0.5);
  }
  if ((keys['d']) || (keys['D']))
  {
    x -= dx * sin(-yawhoek + PI * 0.5);
    z -= dx * cos(-yawhoek + PI * 0.5);
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
  if ((y >= -10) || collision())
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
  camera(0.0, -30.0, 0.0,
         0.0, -29.0, 5.0,
         0.0, 1.0, 0.0);
  drawObjects();
}

void drawObjects()
{
  rotateY(yawhoek);
  for (Weirdo d : objects)
  {
    d.draw(x, y, z);
  }
}

boolean collision()
{
  for (Weirdo d : objects)
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
    if ((keyCode == SHIFT) && landed) dx = 10.0;
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
    if (keyCode == SHIFT) dx = 5.0;
  }
  else
  {
    keys[key] = false;
  }
}
