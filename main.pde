ArrayList<Boid> boids = new ArrayList<Boid>();
int boid_number = 200;
float max_vel = 10;
float separation_factor = 200;
float boid_size = 7;
float neighbour_range = 100;

void setup() 
{
  fullScreen();
  //size(1200, 1000);
  background(0);
  for(int i=0; i< boid_number; ++i)
  {
    boids.add(new Boid(boid_size, max_vel));
  }
}


void Separation()
{
  for(int i=0; i< boid_number; ++i)
  {
    Boid boid1 = boids.get(i);
    boid1.Separation = new PVector(0, 0);
    
    PVector dir;
    float dm;
    
    
    PVector mouse = new PVector(mouseX, mouseY);
    
    dir = mouse.copy().sub(boid1.pos);
    dm = dir.mag() / separation_factor;
    dir.mult(-1).normalize();
    dir.mult(20f / (dm * dm));
    boid1.Separation.add(dir);
    
    dir = mouse.copy().add(width, 0).sub(boid1.pos);
    dm = dir.mag() / separation_factor;
    dir.mult(-1).normalize();
    dir.mult(20f / (dm * dm));
    boid1.Separation.add(dir);
    
    dir = mouse.copy().add(-width, 0).sub(boid1.pos);
    dm = dir.mag() / separation_factor;
    dir.mult(-1).normalize();
    dir.mult(20f / (dm * dm));
    boid1.Separation.add(dir);
    
    dir = mouse.copy().add(0, height).sub(boid1.pos);
    dm = dir.mag() / separation_factor;
    dir.mult(-1).normalize();
    dir.mult(20f / (dm * dm));
    boid1.Separation.add(dir);
    
    dir = mouse.copy().add(0, -height).sub(boid1.pos);
    dm = dir.mag() / separation_factor;
    dir.mult(-1).normalize();
    dir.mult(20f / (dm * dm));
    boid1.Separation.add(dir);
    
    for(int j=0; j< boid_number; ++j)
    {
      if(i==j) continue;
      Boid boid2 = boids.get(j);
      
      dir = boid2.pos.copy().sub(boid1.pos);
      dm = dir.mag() / separation_factor;
      dir.mult(-1).normalize();
      dir.mult(1f / (dm * dm));
      boid1.Separation.add(dir);
      
      dir = boid2.pos.copy().add(width, 0).sub(boid1.pos);
      dm = dir.mag() / separation_factor;
      dir.mult(-1).normalize();
      dir.mult(1f / (dm * dm));
      boid1.Separation.add(dir);
      
      dir = boid2.pos.copy().add(-width, 0).sub(boid1.pos);
      dm = dir.mag() / separation_factor;
      dir.mult(-1).normalize();
      dir.mult(1f / (dm * dm));
      boid1.Separation.add(dir);
      
      dir = boid2.pos.copy().add(0, height).sub(boid1.pos);
      dm = dir.mag() / separation_factor;
      dir.mult(-1).normalize();
      dir.mult(1f / (dm * dm));
      boid1.Separation.add(dir);
      
      dir = boid2.pos.copy().add(0, -height).sub(boid1.pos);
      dm = dir.mag() / separation_factor;
      dir.mult(-1).normalize();
      dir.mult(1f / (dm * dm));
      boid1.Separation.add(dir);
    }
    
    boid1.Separation.mult(0.2);
  }
}

void Alignment()
{
  for(int i=0; i< boid_number; ++i)
  {
    Boid boid1 = boids.get(i);
    boid1.Alignment = new PVector(0, 0);
    boid1.closeNeighbours = 0;
    
    for(int j=0; j< boid_number; ++j)
    {
      if(i==j) continue;
      Boid boid2 = boids.get(j);
      
      //println(boid1.pos.dist(boid2.pos));
      
      if(boid1.pos.dist(boid2.pos) < neighbour_range)
      {
        boid1.Alignment.add(boid2.vel);
        boid1.closeNeighbours ++;
      }
    }
    
    if(boid1.closeNeighbours != 0)
      boid1.Alignment.mult(1f/boid1.closeNeighbours);
  }
}

void Cohesion()
{
  for(int i=0; i< boid_number; ++i)
  {
    Boid boid1 = boids.get(i);
    boid1.Cohesion = new PVector(0, 0);
    
    for(int j=0; j< boid_number; ++j)
    {
      if(i==j) continue;
      Boid boid2 = boids.get(j);
      
      //println(boid1.pos.dist(boid2.pos));
      
      if(boid1.pos.dist(boid2.pos) < neighbour_range)
      {
        boid1.Cohesion.add(boid2.pos);
      }
    }
    
    if(boid1.closeNeighbours != 0)
      boid1.Cohesion.mult(1f/boid1.closeNeighbours);
  }
}

void draw()
{
  println(frameRate);
  
  Separation();
  Alignment();
  Cohesion();
  
  background(0);
  
  for(int i=0; i< boid_number; ++i)
  {
    Boid boid = boids.get(i);
    boid.update(1f/frameRate);
    boid.render();
  }
}
