class Range {
  int l, r;
  Range(int left, int right) {
    l = left;
    r = right;
  }
}

int n = 200;
int step = 0;
int w;
int c = 0;
Boolean paused = false;
int[] q = new int[n];
int[] s = new int[n];
int[] m = new int[n];
Random rand = new Random(42);
Stack<Range> qStack = new Stack<>();
Stack<int[]> mStack = new Stack<>();
MergeSort ms = new MergeSort(n);

void setup() {
  size(1200, 1200);
  stroke(0);
  textSize(24);
  w = width/n;
  for (int i = 0; i < n; i++) {
    int r = rand.nextInt(400);
    q[i] = r;
    s[i] = r;
  }
  qStack.push(new Range(0, n-1));
  ms.mSort(0, n-1);
  ms.push();
  mStack = ms.stack;
  frameRate(10);
}

void swap(int[] nums, int i, int j) {
  int temp = nums[i];
  nums[i] = nums[j];
  nums[j] = temp;
}

void selectionStep(int i) {
  for (int j=i+1; j<n; j++) {
    if (s[j] < s[i]) swap(s, i,j);
  }
}

void drawSelection() {
  for (int i = 0; i < n; i++) {
    if (i == step) fill(200,0,0);
    else fill(s[i]+55, 255-s[i]/2, 0);
    rect(i*w, 400-s[i], w, s[i]);
  }
}

Range quickStep() { // imperative version for visualization
  Range range;
  if (!qStack.empty()) range = qStack.pop();
  else return new Range(0, 0);
  if (range.l >= range.r) return new Range(0, 0);
  int pivot = partition(range.l, range.r);
  qStack.push(new Range(pivot+1, range.r));
  qStack.push(new Range(range.l, pivot-1));
  return range;
}

int partition(int l, int r) {
  int pv = q[l];
  swap(q, l, r);
  int j = l;
  for (int i = l; i < r; i++) {
    if (q[i] < pv) {
      swap(q, i, j);
      j++;
    }
  }
  swap(q, j, r);
  return j;
}

void drawQuick(Range range) {
  for (int i = 0; i < n; i++) {
    if (i >= range.l && i <= range.r)
      fill(200, 0, 0);
    else fill(q[i]+55, 255-q[i]/2, 0);
    rect(i*w, 800-q[i], w, q[i]);
  }
}  

void mergeStep() {
  if (step < mStack.size())
    m = mStack.get(step);
}

void drawMerge() {
  for (int i = 0; i < n; i++) {
    fill(m[i]+55, 255-m[i]/2, 0);
    rect(i*w, height-m[i], w, m[i]);
  }
}

void draw() {
  if (paused) return;
  background(255);
  fill(0);
  text("SelectionSort", 20, 100);
  text("QuickSort", 20, 500);
  text("MergeSort", 20, 900);
  drawMerge();
  drawSelection();
  Range range = quickStep();
  drawQuick(range);
  // if (step % 10 == 0) save("qsAnimation_" + c++ + ".png");
  mergeStep();
  if (step % 3 == 0) quickStep();
  if (step < n) selectionStep(step++);
  else noLoop();
}

void keyPressed() {
  if (key == ' ') paused = !paused;
}
