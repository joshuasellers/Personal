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


int main(int argc, char const *argv[]) {
	/*
	This is MileSplits' main function.  It takes in three args and outputs the mile
  splits or times depending on the input.
	*/
  if(argc == 3){
    if (strcmp(argv[0],"split") == 0) {
      
    }
    else if (strcmp(argv[0],"time") == 0){

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
