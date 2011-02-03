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
