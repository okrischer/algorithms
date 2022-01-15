import java.util.Stack;
import java.util.Random;

public class MergeSort {
  private int[] a; // array to sort
  private int[] aux; // auxiliary array for merging
  private int[] vis; //for visualization only
  public Stack<int[]> stack; //for visualization only
  
  public MergeSort(int n) {
    a = new int[n];
    aux = new int[n];
    vis = new int[n]; //for visualization only
    stack = new Stack<>(); //for visualization only
    Random rand = new Random(42);
    for (int i = 0; i < n; i++) {
      int r = rand.nextInt(400);
      a[i] = r;
      vis[i] = r; //for visualization only
    }
  }
  
  public void mSort(int l, int r) {
    int m = (r + l) / 2; // index of median
    if (l >= r) return; // already sorted
    mSort(l, m); // sort left half
    mSort(m+1, r); // sort right half
    merge(l, m, r); // merge left and right half
    push(); //for visualization only
  }
  
  private void merge(int l, int m, int r) {
    int i, j;
    // copy the left half to aux, leaving i pointing to l
    for (i = m+1; i > l; i--) aux[i-1] = a[i-1];
    // copy the right half in reverse order, j pointing to r
    for (j = m; j < r; j++) aux[r+m-j] = a[j+1];
    // compare first and last value and copy smaller to a
    for (int k = l; k <= r; k++) {
      if (aux[i] < aux[j]) a[k] = aux[i++];
      else a[k] = aux[j--];
    }
  }
  
  public void push() { //for visualization only
    vis = new int[n];
    for (int i = 0; i < n; i++) vis[i] = a[i];
    stack.push(vis);
  }
}
