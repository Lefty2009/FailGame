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
  size(1000, 400, P3D);

  objects = new Weirdo[16];
  
  objects[0] = new Doos(500.0, 400.0, 220.0);
  objects[1] = new Doos(-300.0, -400.0, 150.0);
  objects[2] = new Doos(-200.0, 600.0, 250.0);
  objects[3] = new Doos(200.0, -610.0 , 200.0);
  objects[4] = new Doos(-600.0, 2000.0, 300.0);
  objects[5] = new Doos(0.0, 0.0, 50.0);
  objects[6] = new Doos(4000.0, -50.0, 4000.0, 8000.0, -1000.0, 8000.0);
  objects[7] = new Doos(550.0, -320.0, 450.0, 650.0, -350.0, 550.0);
  objects[8] = new Doos(600.0, -350.0, 750.0, 680.0, -380.0, 810.0);
  objects[9] = new Doos(650.0, -380.0, 1050.0, 710.0, -410.0, 1070.0);
  objects[10] = new Doos(700.0, -410.0, 1350.0, 740.0, -440.0, 1330.0);
  objects[11] = new Doos(750.0, -440.0, 1650.0, 770.0, -470.0, 1590.0);
  objects[12] = new Doos(800.0, -470.0, 1950.0, 1500.0, -500.0, 3000.0);
  objects[13] = new Doos(1530.0, -500.0, 3320.0, 3800.0, -530.0, 3900.0);
  objects[14] = new Doos(5000.0, -50.0, 6000.0, 5100.0, -150.0, 6100.0);
  objects[15] = new XZPlane(-5000.0, 0.0,  -5000.0, 5000.0, 0.0, 5000.0);

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
  noCursor();
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
  camera(0.0, -40.0, 0.0,
         0.0, -39.0, 5.0,
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
