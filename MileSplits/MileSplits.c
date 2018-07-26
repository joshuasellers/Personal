///
/// File: ahnentafel.c
///
/// A program to get mile splits.
///
///
/// @author Josh Sellers
///
// // // // // // // // // // // // // // // // // // // // // // // //

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#define marathon 26.2
#define half 13.1
#define tenk 6.2
#define fivek 3.1

float Race_Time(float dist, float split){
  return (split * dist);
}

float Race_Split(float dist, float time){
  return (dist/time);
}

int main(int argc, char const *argv[]) {
	/*
	This is MileSplits' main function.  It takes in three args and outputs the mile
  splits or times depending on the input.
	*/
  printf("argc = %d\n", argc);
  if(argc == 4){
    if (strcmp(argv[0],"split")) {
      printf("%s\n", argv[1]);
      printf("%f\n", Race_Split(atof(argv[1]),atof(argv[2])));
    }
    else if (strcmp(argv[0],"time")){
      printf("%s\n", argv[1]);
      printf("%f\n", Race_Time(atof(argv[1]),atof(argv[2])));
    }
    else{
      return EXIT_FAILURE;
    }
  }
  else{
    return EXIT_FAILURE;
  }
  printf("Incorrect Number of args\n");
	return EXIT_SUCCESS;
}
