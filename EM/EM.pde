/**
*
* This simulation can be modified to demonstrate the role of
* gravity, electrostatics, and inverse-square laws in general.
* Different initial conditions will lead to very different results;
* define randomized speeds and distances in the Particle
* class.  A massive "sun" can be turned on and off in the setup code below.
*
* @author Woody March-Steinman, BWL
*/

ArrayList<Particle> particles;
Particle sun;
int initS;
int count;
boolean out;
int time;
void setup() {
  size(800, 800, P3D);
  //************
  //number of starting particles.
  initS = 500; 
  //************
  particles = new ArrayList<Particle>(initS);
  for (int i = 0; i < initS; i++) {
    particles.add(new Particle(random(1, 5)));
  }
  //makeSun(); //remove this to remove sun.
  count = 0;
  out = false;
  time = millis();
}

//creates a massive particle in the center of the screen.
void makeSun(){
  sun = new Particle(100000);
  sun.position.x = width/2;
  sun.position.y = height/2;
  sun.position.z = 0;
  sun.c.y = 120;
  sun.c.z = 0;
  sun.velocity = new PVector(0,0,0);
  particles.add(sun);
}
//drawing method.
void draw() {
  background(0);
  for (int i = particles.size()-1; i >= 0; i--) {
    particles.get(i).show();
    
    //for non-sticky (clicked) particles, move.
    if (abs(particles.get(i).charge) < 1000) {
      particles.get(i).move();
    }
    //particles.get(i).colorShift();
    //particles go nova if temp is too high.
    if (particles.get(i).temp >100000 && particles.get(i).mass > 1000) {
      particles.addAll(particles.get(i).explode(1000));
      particles.remove(i);
    }
    for (int j = i-1; j >=0; j--) {
      if (i != j) {
        //enables charge exchange
        if (abs(particles.get(i).charge)<1000 && abs(particles.get(j).charge)<1000) {
          particles.get(i).exchange(particles.get(j));
        }
        //enables interactions.
        particles.get(i).attract(particles.get(j));
        
        //handles particle fusion.
        if (PVector.dist(particles.get(i).position, particles.get(j).position) < max(pow(particles.get(i).mass, 1.0/3), pow(particles.get(j).mass,1.0/3))) {
          particles.get(i).fuse(particles.get(j));
          particles.remove(j);
          break;
        }
      }
    }
  }
  fill(255);
  
  printInfo();
  if (count%200 == 0) {
    PVector COM = calcCOM();
    println("Center of Mass: (" + (int)COM.x + ", " + (int)COM.y + ", " + (int)COM.z + ")");
  }
  count++;
}

//Adds a charged particle of charge 1000.
//negative if space is pressed when clicked, positive otherwise.
void mouseClicked() {
  Particle p = new Particle(100);
  p.position.x = mouseX;
  p.position.y = mouseY;
  p.position.z = 0;
  p.velocity = new PVector (0, 0, 0);
  if (keyCode == 32) {
    p.charge = -1000;
  } else {
    p.charge = 1000;
  }
  particles.add(p);
}

//calculates the average charge of all particles.
float avgCharge() {
  float avg = 0;
  for (Particle p : particles) {
    avg += p.charge;
  } 
  return avg/particles.size();
}

//calculates the average mass of all particles.
float avgMass() {
  float avg = 0;
  for (Particle p : particles) {
    avg += p.mass;
  } 
  return avg/particles.size();
}

//calculates the center of mass of all particles.
PVector calcCOM() {
  PVector COM = new PVector(0, 0, 0);
  for (Particle p : particles) {
    COM.add(p.position.copy().mult(p.mass));
  }
  COM.div(totalMass());
  return COM;
}

//finds the mass of the particle with largest mass.
float biggestMass() {
  float biggest = particles.get(0).mass;
  for (Particle p : particles) {
    if (p.mass > biggest) {
      biggest = p.mass;
    }
  } 
  return biggest;
}
//finds the value of the biggest positive charge.
float biggestCharge() {
  float biggest = particles.get(0).charge;
  for (Particle p : particles) {
    if (p.charge > biggest) {
      biggest = p.charge;
    }
  } 
  return biggest;
}

//finds the [negative] charge of the particle with the lowest charge.
float smallestCharge() {
  float smallest = particles.get(0).charge;
  for (Particle p : particles) {
    if (p.charge < smallest) {
      smallest = p.charge;
    }
  } 
  return smallest;
}

//Prints to the screen a summary of interesting information.
void printInfo() {
  text("Particles: " + particles.size(), 10, 10);
  text("Time Elapsed: " + (millis()-time)/1000, 10, 20);
  text("Average charge: " + (int)avgCharge(), 10, 30);
  text("Average mass: " + (int)avgMass(), 10, 40);
  //PVector COM = calcCOM();
  //text("Center of Mass: (" + (int)COM.x + ", " + (int)COM.y + ", " + (int)COM.z + ")",10,50);
  text("Biggest Mass: " + (int)biggestMass(), 300, 10);
  text("Biggest Charge: " + (int)biggestCharge(), 300, 20);
  text("Smallest Charge: " + (int)smallestCharge(), 300, 30);
}

//sums the mass of all particles.
float totalMass() {
  float sum = 0;
  for (Particle p : particles){
    sum+=p.mass;
  }
  return sum;
}
