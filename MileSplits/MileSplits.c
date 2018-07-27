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
  int seconds =
  return (split * dist);
}

float Race_Split(float dist, float time){
  return (time/dist);
}

int main(int argc, char const *argv[]) {
	/*
	This is MileSplits' main function.  It takes in three args and outputs the mile
  splits or times depending on the input.
	*/
  //TODO make strings for the argvs and interate through them
  printf("argc = %d\n", argc);
  if(argc == 4){
    if (strcmp(argv[0],"split")) {
      printf("Your mile split for %s miles over %s minutes is %.2f\n", argv[2],argv[3], Race_Split(atof(argv[2]),atof(argv[3])));
    }
    else if (strcmp(argv[0],"time")){
      printf("Your time for %s miles with a split of %s is %.2f\n", argv[2],argv[3], Race_Time(atof(argv[2]),atof(argv[3])));
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
