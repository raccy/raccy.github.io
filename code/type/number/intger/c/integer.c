#include <stdio.h>
#include <limits.h>
#include <stddef.h>
#include <stdint.h>
#include <wchar.h>

int main(int argc, char *argv[]) {
  // int a = INT_MAX-20;
  //int a = INT_MIN;
  //int b = 1;
  //printf("a = %d\n", a);
  //printf("b = %d\n", b);
  //printf("a + b - b = %d\n", a + b);
  //printf("a - b + b = %d\n", a - b);
  //printf("a / b * b + a %% b = %d\n", a / b * b + a % b);
  printf("PTRDIFF_MIN = %ld\n", PTRDIFF_MIN);
  printf("PTRDIFF_MAX = %ld\n", PTRDIFF_MAX);
  printf("SIZE_MAX = %lu\n", SIZE_MAX);
  return 0;
}
