import java.util.Random;

ArrayList<Integer> il = new ArrayList<>();
Random rand = new Random(42);

void setup() {
  size(100, 100);
  for (int i = 0; i < 10; i++)
    il.add(rand.nextInt(100));
  println(il);
  println(GS.ls(il, 25)); // true for linear search
  println(GS.bs(il, 25)); // false for binary search on unsorted list
  Collections.sort(il);
  println(il);
  println(GS.bs(il, 25)); // true for binary search on sorted list
  noLoop();
}

void draw() {
}
