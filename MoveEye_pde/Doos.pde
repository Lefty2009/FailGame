public class Doos
{
  float x1, y1, z1, x2, y2, z2;
  int colour;
  public Doos(float a1, float b1, float c1, float a2, float b2, float c2, int col)
  {
    this.x1 = a1;
    this.y1 = b1;
    this.z1 = c1;
    this.x2 = a2;
    this.y2 = b2;
    this.z2 = c2;
    this.colour = col;
  }
  public Doos(float x, float z, float r, int col)
  {
    this.x1 = x - r;
    this.y1 = -r;
    this.z1 = z - r;
    this.x2 = x + r;
    this.y2 = r;
    this.z2 = z + r;
    this.colour = col;
  }
  public void draw(float x, float y, float z)
  {
    beginShape();
      vertex(this.x1 - x, this.y1 - y, this.z1 - z);
      vertex(this.x1 - x, this.y1 - y, this.z2 - z);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z);
    endShape();
    beginShape();
      vertex(this.x1 - x, this.y1 - y, this.z1 - z);
      vertex(this.x1 - x, this.y1 - y, this.z2 - z);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z);
      vertex(this.x1 - x, this.y2 - y, this.z1 - z);
    endShape();
    beginShape();
      vertex(this.x1 - x, this.y1 - y, this.z1 - z);
      vertex(this.x1 - x, this.y2 - y, this.z1 - z);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z);
    endShape();
    
    beginShape();
      vertex(this.x1 - x, this.y2 - y, this.z1 - z);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z);
    endShape();
    beginShape();
      vertex(this.x2 - x, this.y1 - y, this.z1 - z);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z);
    endShape();
    beginShape();
      vertex(this.x1 - x, this.y1 - y, this.z2 - z);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z);
    endShape();
  }
  
  boolean inDoos(float x, float y, float z)
  {
    boolean a = x < max(this.x1, this.x2);
    boolean b = x > min(this.x1, this.x2);
    boolean c = z < max(this.z1, this.z2);
    boolean d = z > min(this.z1, this.z2);
    boolean e = y < max(this.y1, this.y2);
    boolean f = y > min(this.y1, this.y2);
    return a && b && c && d && e && f;
  }
}
