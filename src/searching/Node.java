public class Node<T> implements Comparable<Node<T>> {
  final T state;
  Node<T> parent;
  double cost;
  double heuristic;

  Node(T state, Node<T> parent) {
    this.state = state;
    this.parent = parent;
  }

  Node(T state, Node<T> parent, double cost, double heuristic) {
    this.state = state;
    this.parent = parent;
    this.cost = cost;
    this.heuristic = heuristic;
  }

  public int compareTo(Node<T> other) {
    Double mine = cost + heuristic;
    Double theirs = other.cost + other.heuristic;
    return mine.compareTo(theirs);
  }

} // end of Node
