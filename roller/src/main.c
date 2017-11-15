#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  if (argc < 3) {
    printf("missing argument(s)\n");
    return 1;
  }

  int dice_count = atoi(argv[1]);
  if (dice_count == 0) {
    printf("cannot roll zero dice\n");
    return 1;
  }

  int dice_sides = atoi(argv[2]);
  if (dice_sides == 0) {
    printf("I rolled this zero-sided die for you. You got a 1.\n");
    return 1;
  }

  printf("I am rolling %dd%d", dice_count, dice_sides);

  return 0;
}
