package searching;

public class Queens {
  public static boolean isSafe(int[] q, int n) {
    for (int i = 0; i < n; i++) {
      if (q[i] == q[n]) return false;         // same column
      if (q[i] - q[n] == n - i) return false; // same major diagonal
      if (q[n] - q[i] == n - i) return false; // same minor diagonal
    }
    return true;
  }

  public static void printQueens(int[] q) {
    int n = q.length;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (q[i] == j) System.out.print("Q ");
        else           System.out.print("* ");
      }
      System.out.println();
    }
    System.out.println();
  }

  public static void queens(int n) {
    int[] q = new int[n];
    queens(q, 0);
  }

  public static void queens(int[] q, int k) {
    int n = q.length;
    if (k == n) printQueens(q);
    else {
      for (int i = 0; i < n; i++) {
        q[k] = i;
        if (isSafe(q, k)) queens(q, k + 1);
      }
    }
  }

  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);
    queens(n);
  }
}