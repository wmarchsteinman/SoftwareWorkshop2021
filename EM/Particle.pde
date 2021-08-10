class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector forces;
  float G, K;
  float mass;
  PVector c;
  float temp;
  float charge;
  //generates a particle with mass m.  
  //Randomly assigns position and initial velocity
  Particle(float m) {
    position = new PVector(0, 0, 0);
    position.x = random(1, width);
    position.y = random(1, height);
    position.z = random(-50, 50);
    mass = m;
    charge = 0;
    c = new PVector(255, 255, 255);
    temp = 0;
    //change the random values here for different 
    // high-level behavior.
    velocity = PVector.random3D().mult(0);
    //velocity = new PVector(0,0,0);
    acceleration = new PVector(0, 0, 0);
    forces = new PVector (0, 0, 0);
    G = 0.0001; //strength of gravity
    K = 9; //strength of electrostatic force
  }

  //shows particle on 3D grid as a sphere
  //with radius m^(1/3).  
  //Red for negative charge, blue for positive charge.
  //Neutral-ish, white.
  void show() {
    if (charge>0.20) {
      c.z = 255;
      c.x = 0;
      c.y = 0;
    }
    else if (charge < -0.20) {
      c.z = 0;
      c.y = 0;
      c.x = 255;
    }
    else{
      c.z = 255;
      c.y = 255;
      c.x = 255;
    }
    fill(c.x, c.y, c.z);
    //float modSize = map(position.z + 0.1*mass, -50, 50, 1, 10);
    pushMatrix();
    noStroke();
    translate(position.x, position.y, position.z);
    lights();
    sphere(pow(mass, 1.0/3));
    popMatrix();
  }

  //enables movement of all objects.
  void move() {
    acceleration = forces.copy();
    forces = new PVector(0, 0, 0);
    acceleration.div(mass);
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
  }
  
  //transfer charges based on proximity
  void exchange(Particle p) {
    if (PVector.dist(this.position, p.position)-(pow(p.mass, 1.0/3)+pow(this.mass,1.0/3))< 10) {
      int ex = (int)random(1, 100);
      if (ex % 2 == 0) {
        this.charge+=0.05;
        p.charge-=0.05;
      } else {
        this.charge-=0.05;
        p.charge+=0.05;
      }
    }
  }
  
  //gravitational and electrostatic force interactions
  void attract(Particle p) {
    float d = PVector.dist(this.position, p.position);

    float emForce = (-1 * K * this.charge * p.charge)/(d*d);
    float gravForce = (G * this.mass * p.mass)/(d*d);
    PVector resultant = p.position.copy().sub(this.position);
    if (d > 0.001) {
      resultant.mult(gravForce + emForce);
    }
    forces.add(resultant);
  }
  
  //color shifting with temperature, not used.
  void colorShift() {
    float r = random(0.5, 1.5);
    if (r > 1) {
      c.z ++;
      c.y --;
      temp+=10000;
    }
    if (r < 1) {
      c.z--;
      c.y++;
      temp -=10000;
    }
  }

  //explosion method, unused.
  ArrayList<Particle> explode(int val) {
    int r = val;
    ArrayList<Particle> plosion = new ArrayList<Particle>(r);

    for (int i = 0; i < r; i++) {
      Particle p = new Particle(random(this.mass/val, this.mass/(val/2)));
      p.position.x = this.position.x;
      p.position.y = this.position.y;
      p.position.z = this.position.z;
      p.velocity = PVector.random3D().mult(5);
      plosion.add(p);
    }
    Particle p = new Particle(random(this.mass/2, this.mass/1.5));
    p.position.x = this.position.x;
    p.position.y = this.position.y;
    p.position.z = this.position.z;
    plosion.add(p);
    return plosion;
  }
  
  //combines particles in contact
  void fuse(Particle p){
    velocity = (velocity.mult(this.mass).add(p.velocity.mult(p.mass))).div(p.mass+this.mass);
      if (this.mass != max(this.mass, p.mass)){
        this.position = p.position;
      }
    this.mass += (p.mass);
    this.temp += p.temp;
    this.charge += p.charge;
  }
}
