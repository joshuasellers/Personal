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
  return split * dist;
}

float Race_Split(float dist, float time){
  return dist/time;
}

int main(int argc, char const *argv[]) {
	/*
	This is MileSplits' main function.  It takes in three args and outputs the mile
  splits or times depending on the input.
	*/
  if(argc == 3){
    if (strcmp(argv[0],"split") == 0) {
      printf("%f\n", Race_Split(atof(argv[1]),atof(argv[2]));
    }
    else if (strcmp(argv[0],"time") == 0){
      printf("%f\n", Race_Time(atof(argv[1]),atof(argv[2])));
    }
    else{
      return EXIT_FAILURE;
    }
  }
  else{
    return EXIT_FAILURE;
  }
	return EXIT_SUCCESS;
}
