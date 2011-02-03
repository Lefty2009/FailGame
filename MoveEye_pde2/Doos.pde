public class Doos extends Weirdo
{
  public Doos(float a1, float b1, float c1, float a2, float b2, float c2)
  {
    super(a1, b1, c1, a2, b2, c2);
  }
  public Doos(float x, float z, float r)
  {
    super((x-r),-r,(z-r),(x+r),r,(z+r));
  }
  public void draw(float x, float y, float z)
  {
    beginShape();
//      texture(this.skin);
      vertex(this.x1 - x, this.y1 - y, this.z1 - z);
      vertex(this.x1 - x, this.y1 - y, this.z2 - z);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z);
    endShape();
    beginShape();
//      texture(this.skin);
      vertex(this.x1 - x, this.y1 - y, this.z1 - z);
      vertex(this.x1 - x, this.y1 - y, this.z2 - z);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z);
      vertex(this.x1 - x, this.y2 - y, this.z1 - z);
    endShape();
    beginShape();
//      texture(this.skin);
      vertex(this.x1 - x, this.y1 - y, this.z1 - z);
      vertex(this.x1 - x, this.y2 - y, this.z1 - z);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z);
    endShape();
    
    beginShape();
//      texture(this.skin);      
      vertex(this.x1 - x, this.y2 - y, this.z1 - z);
      vertex(this.x1 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z);
    endShape();
    beginShape();
//      texture(this.skin);
      vertex(this.x2 - x, this.y1 - y, this.z1 - z);
      vertex(this.x2 - x, this.y1 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z2 - z);
      vertex(this.x2 - x, this.y2 - y, this.z1 - z);
    endShape();
    beginShape();
//      texture(this.skin);
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
    boolean e = (y + 10) < max(this.y1, this.y2);
    boolean f = (y + 10 )> min(this.y1, this.y2);
    return a && b && c && d && e && f;
  }
}
