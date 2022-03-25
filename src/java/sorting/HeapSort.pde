import java.util.Random;

public class HeapSort {

    private int[] a; // array to sort
  
    public HeapSort(int n) {
        a = new int[n];
        Random rand = new Random(42);
        for (int i = 0; i < n; i++) {
            a[i] = rand.nextInt(100);
        }
    }

    public void hSort(int[] a, int r) {
        for (int k = r/2; k >= 0; k--)
            heapify(a, k, r);
        while (r > 0) {
            swap(a, 0, r);
            heapify(a, 0, --r);
        }
    }

    void heapify(int[] a, int k, int r) {
        int j;
        while (2*k <= r) {
            j = 2*k;
            if (j < r && a[j] < a[j+1]) j++;
            if (a[k] >= a[j]) break;
            swap(a, k, j);
            k = j;
        }
    }

    void swap(int[] nums, int i, int j) {
    int temp = nums[i];
    nums[i] = nums[j];
    nums[j] = temp;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (var i : a) {
            sb.append(i + " ");
        }
        return sb.toString();
    }
}
