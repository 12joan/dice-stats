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

  int rolls[dice_count];
  for (int i = 0; i < dice_count; i++) {
    rolls[i] = 1;
  }

  int max_total = dice_count * dice_sides;
  int results[max_total];
  for (int i = 0; i < max_total; i++) {
    results[i] = 0;
  }

  int total;
  int rolling;
  rolling = 1;
  while (rolling) {
    total = 0;
    for (int i = 0; i < dice_count; i++) {
      total += rolls[i];
    }
    
    results[total]++;

    rolls[0]++;
    for (int i = 0; i < dice_count; i++) {
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

  for (int i = 0; i <= max_total; i++) {
    printf("%d\n", results[i]);
  }

  return 0;
}
