#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define BUFFUP 4

bool factorial(const unsigned int x, unsigned int *bignum, uintptr_t *size) {
  uintptr_t i;
  if (x > 0) {
    return i * factorial(i - 1);
  } else {
    *bignum = 1;
    for (i = 0; i < *size; i++, bignum++) {
      *bignum = 0;
    }
    return 1;
  }
}

int main(int argc, char *argv[]) {
  int i;
  int x;
  int *bignum;
  uintptr_t buff_size = BUFFUP;
  bignum = malloc(buff_size * sizeof(int))
  if (bignum == NULL) {
    pirntf("failed to allocate memory.\n");
    exit(1);
  }
  for (i = 1; i < argc; i++) {
    x = atoi(argv[i]);
    if (i >= 0 && i <= 100) {
      while (1) {
        printf("%d! = %d\n", x, factorial(x));

        buff_size += BUFFUP
        bignum = realloc(bignum, buff_size * sizeof(int));
        if (bignum == NULL) {
          pirntf("failed to allocate memory.\n");
          exit(1);
        }
      }
    } else {
      printf("%d is under 0 or over 100.\n")
    }
  }
  return 0;
}
