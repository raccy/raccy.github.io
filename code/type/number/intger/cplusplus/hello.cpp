#include <iostream>
#include <cstdint>

int main(int argc, char *argv[]) {
  int a = 1;
  std::cout << u8"こんにちは、世界！" << std::endl;
  std::cout << a << std::endl;
  std::cout << u8"こんにちは、世界！" << std::endl;
  return 0;
}
