import java.util.List; // base interface for ordered collections
import java.util.Collections; // static methods on collections
import java.util.ArrayList;

public static class GS {
  public static <T extends Comparable<T>> boolean ls(List<T> list, T other) {
    for (T item : list) {
      if (item.compareTo(other) == 0) return true;
    }
    return false;
  }
  
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
}
