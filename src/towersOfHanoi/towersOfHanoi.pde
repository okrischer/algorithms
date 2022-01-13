import java.util.Stack;

Hanoi hanoi;
Stack<Move> moves;
int step = 0;

void setup() {
  size(1000, 400);
  hanoi = new Hanoi(8); // max 8 disks for this visualization
  hanoi.solve();
  moves = hanoi.moves;
  frameRate(8);
}

void draw() {
  if (!moves.empty()) {
    Move move = moves.pop();
    showMove(move);
  } else {
    noLoop();
  }
}

void showMove(Move mv) {
  background(250);
  stroke(50);
  fill(50);
  line(50, 300, 950, 300); 
  rect(200, 100, 20, 200);
  rect(500, 100, 20, 200);
  rect(800, 100, 20, 200);
  Stack A = mv.towerC; // draw target towerC to the left to reverse order from moves
  for (int i = 0; i < A.size(); i++) {
    int d = (int) A.get(i);
    setColor(d);
    rect(210 - d*20, 280 - i*20, d*40, 20);
  }
  Stack B = mv.towerB; // draw temp towerB to the middle
  for (int i = 0; i < B.size(); i++) {
    int d = (int) B.get(i);
    setColor(d);
    rect(510 - d*20, 280 - i*20, d*40, 20);
  }
  Stack C = mv.towerA; // draw start towerA to the right to reverse order from moves
  for (int i = 0; i < C.size(); i++) {
    int d = (int) C.get(i);
    setColor(d);
    rect(810 - d*20, 280 - i*20, d*40, 20);
  }
}

void setColor(int disk) {
  switch (disk) {
    case 1: fill(#FFFF00);
      break;
    case 2: fill(#FFCC00);
      break;
    case 3: fill(#FF6600);
      break;
    case 4: fill(#FF0000);
      break;
    case 5: fill(#CC0066);
      break;
    case 6: fill(#CC00CC);
      break;
    case 7: fill(#9900CC);
      break;
    case 8: fill(#6633CC);
      break;
    default: fill(50);
  }
}
