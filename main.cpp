#include <iostream>
#include <thread>

void print_range(int lower = 0, int upper = 100) {
  for (int i = lower; i <= upper; i++) {
    std::cout << i << '\n';
  }
}

int main(int argc, char **argv) {
  std::thread t1(print_range, 0, 101);

  if (t1.joinable())
    t1.join();
}
