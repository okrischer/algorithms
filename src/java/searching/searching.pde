import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;

Maze maze;
GenericSearch gs = new GenericSearch();
Set exploredDFS = new HashSet<>();
Set exploredBFS = new HashSet<>();
Map exploredAstar = new HashMap<>();

int cp;

void setup() {
  size(1240, 440);
  background(200);
  MazeLocation start = new MazeLocation(19, 0);
  MazeLocation goal = new MazeLocation(0, 19);
  maze = new Maze(20, 20, start, goal, 0.3);
  cp = 20;
  
  Node<MazeLocation> dfs = gs.dfs(maze.start,
    maze::goalTest, maze::successors);
  exploredDFS = gs.exploredDFS;
    
  if (dfs == null) {
    println("no solution found with dfs");
  } else {
    List<MazeLocation> path = gs.nodeToPath(dfs);
    maze.mark(path);
    drawDFS();
    maze.clear(path);
  }
  
  Node<MazeLocation> bfs = gs.bfs(maze.start,
    maze::goalTest, maze::successors);
  exploredBFS = gs.exploredBFS;
    
  if (bfs == null) {
    println("no solution found with bfs");
  } else {
    List<MazeLocation> path = gs.nodeToPath(bfs);
    maze.mark(path);
    drawBFS();
    maze.clear(path);
  }

  Node<MazeLocation> astar = gs.astar(maze.start,
    maze::goalTest, maze::successors, maze::manhattanDistance);
  exploredAstar = gs.exploredAstar;
    
  if (astar == null) {
    println("no solution found with A* heuristic");
  } else {
    List<MazeLocation> path = gs.nodeToPath(astar);
    maze.mark(path);
    drawASTAR();
    maze.clear(path);
  }

  fill(0);
  textSize(30);
  text("DepthFirst", 140, 430);
  text("BreadthFirst", 550, 430);
  text("A* heuristic", 970, 430);
  
  noLoop();
}

void draw() {
}

void drawDFS() {
  stroke(0);
  for (int y = 0; y < maze.rows; y++) {
    for (int x = 0; x < maze.cols; x++) {
      MazeLocation ml = new MazeLocation(y, x);
      if (exploredDFS.contains(ml) && maze.grid[y][x].name() == "EMPTY") {
        fill(100, 200, 250);
      } else {
        setFill(y, x);
      }
      rect(x * cp, y * cp, cp, cp);
    }
  }
}

void drawBFS() {
  stroke(0);
  for (int y = 0; y < maze.rows; y++) {
    for (int x = 0; x < maze.cols; x++) {
      MazeLocation ml = new MazeLocation(y, x);
      if (exploredBFS.contains(ml) && maze.grid[y][x].name() == "EMPTY") {
        fill(100, 200, 250);
      } else {
        setFill(y, x);
      }
      rect(x*cp + 420, y * cp, cp, cp);
    }
  }
}

void drawASTAR() {
  stroke(0);
  for (int y = 0; y < maze.rows; y++) {
    for (int x = 0; x < maze.cols; x++) {
      MazeLocation ml = new MazeLocation(y, x);
      if (exploredAstar.containsKey(ml) && maze.grid[y][x].name() == "EMPTY") {
        fill(100, 200, 250);
      } else {
        setFill(y, x);
      }
      rect(x*cp + 840, y * cp, cp, cp);
    }
  }
}

void setFill(int r, int c) {
  switch (maze.grid[r][c]) {
    case BLOCKED:
      fill(50);
      break;
    case EMPTY:
      fill(240);
      break;
    case PATH:
      fill(0, 0, 200);
      break;
    case START:
      fill(0, 200, 0);
      break;
    case GOAL:
      fill(200, 0, 0);
      break;
    default:
      fill (100, 100, 0);
  }
}
