class GooBall extends Creature {
  
  public GooBall(int x, int y, int r) {
    super(x, y, r);
    ellipseMode(RADIUS);
  }

  public void draw_shape(){
    fill(255, 100);
    strokeWeight(2);
    stroke(255);
    ellipse(0, 0, radius(), radius());
    fill(255); 
    ellipse(radius()/4*-1, radius()/3*-1, radius()/5, radius()/5); 
    ellipse(radius()/4*-1, radius()/3, radius()/5, radius()/5); 
  }

  public boolean inside(int mx, int my) {    
    if(dist(mx, my, position().x, position().y) < radius()) return true;
    return false;
  }
  
};
