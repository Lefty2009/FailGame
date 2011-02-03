import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class MoveEye_pde extends PApplet {


/**
 * Test Game Shizzle
 */

float x, y, z;
Weirdo[] objects;
float yawhoek, pitchhoek;
float gravity = 0.5f;
float terminal_speed = 8;
float jump_speed = -10;
float dy = 0;
float dx = 5.0f;
boolean jump = false;
boolean landed = true;
boolean[] keys;
boolean[] arrows;

public void setup() {
  x = 0.0f;
  y = -200.0f;
  z = -2000.0f;
  fill(204);
  size(1000, 400, OPENGL);
  PImage skin = loadImage("grasstexture.jpg");
  PImage skin2 = loadImage("woodtexture2.jpg");
  objects = new Weirdo[7];
  
  objects[0] = new Doos(500.0f, 400.0f, 220.0f, skin2);
  objects[1] = new Doos(-300.0f, -400.0f, 150.0f, skin2);
  objects[2] = new Doos(-200.0f, 600.0f, 250.0f, skin2);
  objects[3] = new Doos(200.0f, -610.0f , 200.0f, skin2);
  objects[4] = new Doos(-600.0f, 2000.0f, 300.0f, skin2);
  objects[5] = new Doos(0.0f, 0.0f, 50.0f, skin2);
  objects[6] = new XZPlane(-5000.0f, 0.0f,  -5000.0f, 5000.0f, 0.0f, 5000.0f, skin);

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

public void draw() {
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
    x += dx * sin(-yawhoek + PI * 0.5f);
    z += dx * cos(-yawhoek + PI * 0.5f);
  }
  if ((keys['d']) || (keys['D']))
  {
    x -= dx * sin(-yawhoek + PI * 0.5f);
    z -= dx * cos(-yawhoek + PI * 0.5f);
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
  camera(0.0f, -30.0f, 0.0f,
         0.0f, -29.0f, 5.0f,
         0.0f, 1.0f, 0.0f);
  drawObjects();
}

public void drawObjects()
{
  rotateY(yawhoek);
  for (Weirdo d : objects)
  {
    d.draw(x, y, z);
  }
}

public boolean collision()
{
  for (Weirdo d : objects)
  {
    if (d.inDoos(x, y, z)) return true;
  }
  return false;

}

public void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP) arrows[0] = true;
    if (keyCode == DOWN) arrows[1] = true;
    if (keyCode == LEFT) arrows[2] = true;
    if (keyCode == RIGHT) arrows[3] = true;
    if ((keyCode == SHIFT) && landed) dx = 10.0f;
  }
  else
  {
    keys[key] = true;
  }
}

public void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == UP) arrows[0] = false;
    if (keyCode == DOWN) arrows[1] = false;
    if (keyCode == LEFT) arrows[2] = false;
    if (keyCode == RIGHT) arrows[3] = false;
    if (keyCode == SHIFT) dx = 5.0f;
  }
  else
  {
    keys[key] = false;
  }
}
public class Doos extends Weirdo
{
  public Doos(float a1, float b1, float c1, float a2, float b2, float c2, PImage skin)
  {
    super(a1, b1, c1, a2, b2, c2, skin);
  }
  public Doos(float x, float z, float r, PImage skin)
  {
    super((x-r),-r,(z-r),(x+r),r,(z+r),skin);
  }
  public void draw(float x, float y, float z)
  {
    beginShape();
      texture(this.skin);
      vertex(this.x1 - x, this.y1 - y, this.z1 - z, 0, 0);
      vertex(this.x1 - x, this.y1 - y, this.z2 - z, 0, 1080);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z, 1080, 1080);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z, 1080, 0);
    endShape();
    beginShape();
      texture(this.skin);
      vertex(this.x1 - x, this.y1 - y, this.z1 - z, 0, 0);
      vertex(this.x1 - x, this.y1 - y, this.z2 - z, 0, 1080);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z, 1080, 1080);
      vertex(this.x1 - x, this.y2 - y, this.z1 - z, 1080, 0);
    endShape();
    beginShape();
      texture(this.skin);
      vertex(this.x1 - x, this.y1 - y, this.z1 - z, 0, 0);
      vertex(this.x1 - x, this.y2 - y, this.z1 - z, 0, 1080);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z, 1080, 1080);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z, 1080, 0);
    endShape();
    
    beginShape();
      texture(this.skin);
      vertex(this.x1 - x, this.y2 - y, this.z1 - z, 0, 0);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z, 0, 1080);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z, 1080, 1080);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z, 1080, 0);
    endShape();
    beginShape();
      texture(this.skin);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z, 0, 0);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z, 0, 1080);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z, 1080, 1080);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z, 1080, 0);
    endShape();
    beginShape();
      texture(this.skin);
      vertex(this.x1 - x, this.y1 - y, this.z2 - z, 0, 0);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z, 0, 1080);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z, 1080, 1080);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z, 1080, 0);
    endShape();
  }
  
  public boolean inDoos(float x, float y, float z)
  {
    boolean a = x < max(this.x1, this.x2);
    boolean b = x > min(this.x1, this.x2);
    boolean c = z < max(this.z1, this.z2);
    boolean d = z > min(this.z1, this.z2);
    boolean e = (y + 10) < max(this.y1, this.y2);
    boolean f = (y + 10 )> min(this.y1, this.y2);
    return a && b && c && d && e && f;
  }
}
public class Weirdo
{
  float x1, y1, z1, x2, y2, z2;
  PImage skin;
  public Weirdo(float a1, float b1, float c1, float a2, float b2, float c2, PImage skin)
  {
    this.x1 = a1;
    this.y1 = b1;
    this.z1 = c1;
    this.x2 = a2;
    this.y2 = b2;
    this.z2 = c2;
    this.skin = skin;
  }
  public void draw(float x, float y, float z)
  {
  }
  
  public boolean inDoos(float x, float y, float z)
  {
    return false;
  }
}
public class XZPlane extends Weirdo
{
  public XZPlane(float a1, float b1, float c1, float a2, float b2, float c2, PImage skin)
  {
    super(a1, b1, c1, a2, b2, c2, skin);
  }
  public void draw(float x, float y, float z)
  {
    for (float i = min(this.x1, this.x2); i < (max(this.x1, this.x2)); i += 1024)
    {
      for (float j = min(this.z1, this.z2); j < (max(this.z1, this.z2)); j += 1024)
      {
        beginShape();
          texture(this.skin);
          vertex(i - x, this.y1 - y, j - z, 0, 0);
          vertex(i - x, this.y2 - y, j + 1024- z, 0, 1024);
          vertex(i + 1024 - x, this.y2 - y, j + 1024 - z, 1024, 1024);
          vertex(i + 1024 - x, this.y1 - y, j - z, 1024, 0);
        endShape();
      }  
    }
    
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "MoveEye_pde" });
  }
}
