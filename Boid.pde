class Boid
{
  PVector pos, vel, StartVel;
  PVector Separation, Alignment, Cohesion;
  float Tsize, maxVel;
  int closeNeighbours;
  float rotate_angle = 0;
  
  Boid (float size, float maxV)
  {
    Tsize = size;
    maxVel = maxV;
    
    Separation = new PVector(0, 0);
    Alignment = new PVector(0, 0);
    Cohesion = new PVector(0, 0);
    
    pos = new PVector(random(0, width), random(0, height));
    
    vel = new PVector(random(-1, 1), random(-1, 1));
    vel.normalize().mult(100);
    StartVel = vel;
    
    vel.limit(100);
    //radius = size;
    //println(vel);
  }
  
  void update(float timeElapsed)
  {
    int r = int(random(1, 100));
    if(r == 1)
      vel.rotate(random(-PI/60, PI/60));
    
    if(closeNeighbours != 0)
      vel.add(Alignment).mult(0.5);
      
    vel.add(Separation);
    
    vel.add(Cohesion.sub(pos).normalize().mult(10));
    
    // add vel relative to delta time
    pos.add(vel.copy().mult(timeElapsed));
    
    while(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height)
    {
      if(pos.x < 0)
        pos.x = width + pos.x;
      if(pos.x > width)
        pos.x = pos.x - width;
      if(pos.y < 0)
        pos.y = height + pos.y;
      if(pos.y > height)
        pos.y = pos.y - height;
    }
  }
  
  void render()
  {
    PShape new_tria = createShape(TRIANGLE, 0, 0, -Tsize, -Tsize*3, Tsize, -Tsize*3);
    new_tria.setFill(color(255, 255, 255));
    new_tria.setStroke(false);
    if(vel.x > 0)
      new_tria.rotate(2*PI - abs(PVector.angleBetween(vel, new PVector(0, 1) ) ) );
    else
      new_tria.rotate(abs(PVector.angleBetween(vel, new PVector(0, 1) ) ) );
    shape(new_tria, pos.x, pos.y);
  }
}
