import teilchen.Physics;
import teilchen.force.Gravity;
import teilchen.force.PlaneDeflector;
import teilchen.force.Spring;
import teilchen.force.ViscousDrag;

final int CANVAS_WIDTH = 1000;
final int CANVAS_HEIGHT = 600;

float gooRadius = 25;

Physics physics;

PlaneDeflector floorDeflector;

ArrayList<Creature> gooBalls = new ArrayList<Creature>();
ArrayList<Spring> connectors = new ArrayList<Spring>();

void setup() {  
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
  background(60, 80, 250);
  frameRate(30);
  
  physics = new Physics();
  
  Gravity mGravity = new Gravity();
  mGravity.force().set(0, 40, 0);  

  physics.add(mGravity);  
  

  floorDeflector = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  floorDeflector.plane().origin.set(width / 2, height - 100, 0);
  floorDeflector.plane().normal.set(0, -1, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  floorDeflector.coefficientofrestitution(0.7f);
  
  physics.add(floorDeflector);
  
}

void draw() {
  
  physics.step(1.0 / frameRate);
  background(20);
  noFill();

  for(int i = 0; i < connectors.size(); i++) {
    Spring connector = connectors.get(i);
    stroke(250, 20);
    strokeWeight(2);
    line( connector.a().position().x, connector.a().position().y,  connector.b().position().x, connector.b().position().y );
  }

  for(int i = 0; i < gooBalls.size(); i++) {
    Creature g = gooBalls.get(i);
    g.display();
  }

  /* draw deflector */
  stroke(250);
  strokeWeight(3);
  line(floorDeflector.plane().origin.x - floorDeflector.plane().normal.y * -width,
  floorDeflector.plane().origin.y + gooRadius,
  floorDeflector.plane().origin.x - floorDeflector.plane().normal.y * width,
  floorDeflector.plane().origin.y + gooRadius);

}

void mousePressed() {
  GooBall g = new GooBall(mouseX, mouseY, 25);
  
  /*
  Creature a1 = g;
  Creature a2 = g; 
  int numConnectors = 0;
  float dist1 = 150;
  float dist2 = 150;*/

  Creature h = g;

  for(int i = 0; i < gooBalls.size(); i++) {
    h = gooBalls.get(i);
    
    if(dist( h.position().x, h.position().y, mouseX, mouseY )< 150){
      Spring spring = physics.makeSpring(g, h, 10.0, 0.1, 100);
      connectors.add(spring);
    }
    /*
    float distTemp = dist( h.position().x, h.position().y, mouseX, mouseY );
    println("distTemp: "+distTemp);
    if ( distTemp < dist1 ) {
      a2 = a1;
      a1 = h;
      dist2 = dist1;
      dist1 = distTemp;
      numConnectors ++;
    }
    else if( distTemp < dist2 ){
      dist2 = distTemp;
      a2 = h;
      numConnectors ++;
    }
    println("numConnectors: "+numConnectors);
    */
  }
  /*
  if( numConnectors >= 1 ){
    Spring spring1 = physics.makeSpring(g, a1);
    spring1.restlength(100);
    connectors.add(spring1);
    //println("added a spring");
  }
  if( numConnectors >= 2 ){
    Spring spring2 = physics.makeSpring(g, a2);
    spring2.restlength(100);
    connectors.add(spring2);
    //println("added a spring");
  }*/

  gooBalls.add(g);
  physics.add(g);
}

void keyPressed(){
  gooBalls.clear();
  connectors.clear();
}
