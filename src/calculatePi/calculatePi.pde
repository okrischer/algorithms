double numerator = 4.0;
double denominator = 1.0;
double sign = 1.0;
double pi = 0.0;

void setup() {
  calculatePi();
  noLoop();
}

void calculatePi() {
  for (int i = 0; i < 1000000; i++) {
    pi += sign * (numerator / denominator);
    denominator += 2.0;
    sign *= -1.0;
  }
  println(pi);
}
