import java.util.Arrays;
import java.util.Random;

public enum Cell {
  EMPTY(" "), BLOCKED("X"), START("S"), GOAL("G"), PATH("*");
  private final String code;

  private Cell (String c) {
    code = c;
  }
  public String toString() {
    return code;
  }
}
  
public class Maze {
  
  // members of Maze
  public final int rows, cols;
  public final MazeLocation start, goal;
  public Cell[][] grid;

  public Maze(int rows, int cols, MazeLocation start, MazeLocation goal,
              double sparse) {
    this.rows = rows;
    this.cols = cols;
    this.start = start;
    this.goal = goal;
    grid = new Cell[rows][cols];
    for (var row : grid) {
      Arrays.fill(row, Cell.EMPTY);
    }
    randomlyFill(sparse);
    grid[start.row][start.col] = Cell.START;
    grid[goal.row][goal.col] = Cell.GOAL;
  }

  public Maze() {
    this(10, 10, new MazeLocation(9, 0), new MazeLocation(0, 9), 0.2);
  }

  private void randomlyFill(double sparse) {
    Random rand = new Random();
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (rand.nextDouble() < sparse)
          grid[row][col] = Cell.BLOCKED;
      }
    }
  }

  public boolean goalTest(MazeLocation ml) {
    return goal.equals(ml);
  }

  public List<MazeLocation> successors(MazeLocation ml) {
    List<MazeLocation> locations = new ArrayList<>();
    if (ml.row+1 < rows && grid[ml.row+1][ml.col] != Cell.BLOCKED) {
      locations.add(new MazeLocation(ml.row + 1, ml.col));
    }
    if (ml.row-1 >= 0 && grid[ml.row-1][ml.col] != Cell.BLOCKED) {
      locations.add(new MazeLocation(ml.row - 1, ml.col));
    }
    if (ml.col+1 < cols && grid[ml.row][ml.col+1] != Cell.BLOCKED) {
      locations.add(new MazeLocation(ml.row, ml.col + 1));
    }
    if (ml.col-1 >= 0 && grid[ml.row][ml.col-1] != Cell.BLOCKED) {
      locations.add(new MazeLocation(ml.row, ml.col - 1));
    }
    return locations;
  }

  public double euclideanDistance(MazeLocation ml) {
    int xdist = ml.col - goal.col;
    int ydist = ml.row - goal.row;
    return Math.sqrt(xdist*xdist + ydist*ydist);
  }

  public double manhattanDistance(MazeLocation ml) {
    int xdist = Math.abs(ml.col - goal.col);
    int ydist = Math.abs(ml.row - goal.row);
    return(xdist + ydist);
  }
  
  public void mark(List<MazeLocation> path) {
    for (var ml : path) {
      grid[ml.row][ml.col] = Cell.PATH;
    }
    grid[start.row][start.col] = Cell.START;
    grid[goal.row][goal.col] = Cell.GOAL;
  }

  public void clear(List<MazeLocation> path) {
    for (var ml : path) {
      grid[ml.row][ml.col] = Cell.EMPTY;
    }
    grid[start.row][start.col] = Cell.START;
    grid[goal.row][goal.col] = Cell.GOAL;
  }

  public String toString() {
    StringBuilder sb = new StringBuilder();
    for (var row : grid) {
      for (var cell : row) {
        sb.append(cell.toString());
      }
      sb.append(System.lineSeparator());
    }
    return sb.toString();
  }
}
