// package searching;

import java.util.List;
import java.util.PriorityQueue;
import java.util.Stack;
import java.util.Queue;
import java.util.LinkedList;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.ToDoubleFunction;


public class GenericSearch {

  // for visualization only
  public static Set exploredDFS = new HashSet<>();
  public static Set exploredBFS = new HashSet<>();
  public static Map exploredAstar = new HashMap<>();

  // linear search
  public static <T extends Comparable<T>> boolean ls(List<T> list, T other) {
    for (T item : list) {
      if (item.compareTo(other) == 0) return true;
    }
    return false;
  }
  
  // binary search
  public static <T extends Comparable<T>> boolean bs(List<T> list, T other) {
    int low = 0;
    int high = list.size() - 1;
    while (low <= high) {
      int mid = (low + high) / 2;
      int cr = list.get(mid).compareTo(other);
      if (cr < 0) low = mid + 1;
      else if (cr > 0) high = mid - 1;
      else return true;
    }
    return false;
  }

  // depth first search
  public static <T> Node<T> dfs(T initial, Predicate<T> goalTest,
                Function<T, List<T>> successors) {

    Stack<Node<T>> frontier = new Stack<>();
    frontier.push(new Node<T>(initial, null));
    Set<T> explored = new HashSet<>();
    exploredDFS = explored; // visualization only
    explored.add(initial);

    while (!frontier.isEmpty()) {
      Node<T> currentNode = frontier.pop();
      T currentState = currentNode.state;
      if (goalTest.test(currentState)) {
        return currentNode;
      }
      for (T next : successors.apply(currentState)) {
        if (explored.contains(next)) {
          continue;
        }
        explored.add(next);
        frontier.push(new Node<>(next, currentNode));
      }
    }
    return null;
  }
  
  // breadth first search
  public static <T> Node<T> bfs(T initial, Predicate<T> goalTest,
                Function<T, List<T>> successors) {

    Queue<Node<T>> frontier = new LinkedList<>();
    frontier.offer(new Node<T>(initial, null));
    Set<T> explored = new HashSet<>();
    exploredBFS = explored; // visualization only
    explored.add(initial);

    while (!frontier.isEmpty()) {
      Node<T> currentNode = frontier.poll();
      T currentState = currentNode.state;
      if (goalTest.test(currentState)) {
        return currentNode;
      }
      for (T next : successors.apply(currentState)) {
        if (explored.contains(next)) {
          continue;
        }
        explored.add(next);
        frontier.offer(new Node<>(next, currentNode));
      }
    }
    return null;
  }

  // A* search with heuristic and cost function
  public static <T> Node<T> astar(T initial, Predicate<T> goalTest,
                Function<T, List<T>> successors, ToDoubleFunction<T> heuristic) {

    PriorityQueue<Node<T>> frontier = new PriorityQueue<>();
    frontier.offer(new Node<T>(initial, null, 0.0, heuristic.applyAsDouble(initial)));
    Map<T, Double> explored = new HashMap<>();
    exploredAstar = explored; // visualization only
    explored.put(initial, 0.0);

    while (!frontier.isEmpty()) {
      Node<T> currentNode = frontier.poll();
      T currentState = currentNode.state;
      if (goalTest.test(currentState)) {
        return currentNode;
      }
      for (T next : successors.apply(currentState)) {
        double newCost = currentNode.cost + 1;
        if (!explored.containsKey(next) || explored.get(next) > newCost) {
          explored.put(next, newCost);
          frontier.offer(new Node<>(next, currentNode, newCost, heuristic.applyAsDouble(next)));
        }
      }
    }
    return null;
  }
  // path to goal
  public static <T> List<T> nodeToPath(Node<T> node) {
    List<T> path = new ArrayList<>();
    path.add(node.state);
    while (node.parent != null) {
      node = node.parent;
      path.add(0, node.state);
    }
    return path;
  }

}
