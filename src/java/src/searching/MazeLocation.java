// package searching;

public class MazeLocation {
  public final int row;
  public final int col;

  public MazeLocation(int row, int col) {
    this.row = row;
    this.col = col;
  }

  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime*result + col;
    result = prime*result + row;
    return result;
  }

  public boolean equals(Object obj) {
    if (this == obj) return true;
    if (obj == null) return false;
    if (getClass() != obj.getClass()) return false;
    MazeLocation other = (MazeLocation) obj;
    if (col != other.col) return false;
    if (row != other.row) return false;
    return true;
  }
}
