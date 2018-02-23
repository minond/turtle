class Turtle {
  protected float deg = 0;
  protected float x, y = 0;

  Turtle(int width, int height) {
    x = width/2;
    y = height/2;
  }

  void walk(int steps) {
    float startx = x;
    float starty = y;

    x = x + cos(radians(deg))*steps;
    y = y + sin(radians(deg))*steps;

    line(startx, starty, x, y);
  }

  void turn(float _deg) {
    deg += _deg;
    deg = abs(deg);
    deg %= 360;
  }
}

class Trip {
  protected Walker walker;
  protected int max;
  protected int counter;
  protected float step;

  Trip(int _max, float _step, Walker _walker) {
    walker = _walker;
    max = _max;
    step = _step;
    counter = max;
  }

  boolean step() {
    if (counter <= 0) {
      return false;
    }

    walker.step(max, counter);
    counter -= step;
    return true;
  }
}

abstract class Walker {
  abstract public void step(int max, int counter);
}

Turtle turtle;
Trip trip;

void setup() {
  size(500, 500);
  background(240);
  colorMode(RGB, 255);
  smooth();
  frameRate(35);

  turtle = new Turtle(500, 500);

  trip = new Trip(300, .999, new Walker() {
    public void step(int max, int counter) {
      stroke(255, (100+counter)%255, 100);
      turtle.walk(max-counter);
      turtle.turn(80);
    }
  }
  );

  trip = new Trip(250, QUARTER_PI, new Walker() {
    public void step(int max, int counter) {
      stroke((100+counter)%255, 0, 255);
      turtle.walk(max-counter);
      turtle.turn(91+TAU);
    }
  }
  );

  trip = new Trip(250, .1, new Walker() {
    public void step(int max, int counter) {
      stroke((100+counter)%150, random(100)+10, 55);
      turtle.walk(max-counter);
      turtle.turn(92);
      turtle.walk(5);
      turtle.turn(TAU);
    }
  }
  );

  trip = new Trip(275, .25, new Walker() {
    public void step(int max, int counter) {
      stroke(random(counter, 40)+50, (100+counter)*2%35, random(30)+25);
      turtle.walk(max-counter);
      turtle.turn(92);
      turtle.walk(5);
      turtle.turn(TAU*2);
    }
  }
  );
}

void draw() {
  if (!trip.step()) {
    // System.out.println("Saving...");
    // save("out/t00005.png");
    // System.out.println("Saved");
    noLoop();
    return;
  }
}