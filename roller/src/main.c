#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int i;

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

  int rolls[dice_count];
  for (i = 0; i < dice_count; i++) {
    rolls[i] = 1;
  }

  int max_total = dice_count * dice_sides;
  int results_length = (max_total + 1);
  unsigned long *results = (unsigned long *) malloc(sizeof(unsigned long) * results_length);
  for (i = 0; i < results_length; i++) {
    results[i] = 0;
  }

  unsigned long total;
  int rolling;
  rolling = 1;
  while (rolling) {
    total = 0;
    for (i = 0; i < dice_count; i++) {
      total += rolls[i];
    }
    
    results[total]++;

    rolls[0]++;
    for (i = 0; i < dice_count; i++) {
      if (rolls[i] > dice_sides) {
        rolls[i] = 1;
        if (i == dice_count - 1) {
          rolling = 0;
        } else {
          rolls[i + 1]++;
        }
      }
    }
  }

  for (i = 0; i < results_length; i++) {
    printf("%lu\n", results[i]);
  }

  free(results);

  return 0;
}
