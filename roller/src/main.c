#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("missing argument(s)\n");
    return 1;
  }

  int n = atoi(argv[1]);
  printf("%d\n", n);

  return 0;
}
