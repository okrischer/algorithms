import java.util.Stack;

public class Hanoi {
    private final int numDisks;
    public final Stack<Integer> towerA = new Stack<>();
    public final Stack<Integer> towerB = new Stack<>();
    public final Stack<Integer> towerC = new Stack<>();
    public final Stack<Move> moves = new Stack<>(); // visualization
    
    public Hanoi(int discs) {
        numDisks = discs;
        for (int i = discs; i >= 1; i--)
            towerA.push(i);
    }
    
    private void move(Stack<Integer> start, Stack<Integer> target, 
                      Stack<Integer> temp, int n) {
        if (n == 1) {
            target.push(start.pop());
            moves.push(new Move(towerA, towerB, towerC)); //visualization
        } else {
            move(start, temp, target, n-1);
            move(start, target, temp, 1);
            move(temp, target, start, n-1);
        }
    }
    
    public void solve() {
        moves.push(new Move(towerA, towerB, towerC)); // visualization
        move(towerA, towerC, towerB, numDisks);
    }
}

public class Move {
  Stack<Integer> towerA = new Stack<>();
  Stack<Integer> towerB = new Stack<>();
  Stack<Integer> towerC = new Stack<>();
  
  public Move(Stack<Integer> A, Stack<Integer> B, Stack<Integer> C) {
    for (int d : A) towerA.push(d);
    for (int d : B) towerB.push(d);
    for (int d : C) towerC.push(d);
  }
}
