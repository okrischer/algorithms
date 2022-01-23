import java.util.Stack;

// only needed for visualization with processing
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