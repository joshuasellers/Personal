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
#define MAX 100

float string_convert(char* arg){
  int i = 0;
  colon = 0;
  while (arg[i] != '\0') {
    if (arg[i] == ':') {
      colon = i;
    }
    i++;
  }
  char* min;
  min = (char*)malloc(colon*sizeof(char));
  for (size_t j = 0; j < colon; j++) {
    min[j] = arg[j];
  }
  char* sec;
  sec = (char*)malloc((i-colon)*sizeof(char));
  for (size_t k = colon+1; k <= i; k++) {
    sec[k] = arg[k];
  }
  return (atof(min)+(atof(sec)/60.0));
}

char* time_convert(float t){
  char buf[MAX];
  gcvt(t, 6, buf);
  return buf
}

char* Race_Time(float dist, char* split){
  float split_correct = string_convert(split);
  return time_convert(split_correct * dist);
}

char* Race_Split(float dist, char* time){
  float time_correct = string_convert(time);
  return time_convert(time/dist);
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
      printf("Your mile split for %s miles over %s minutes is %s\n", argv[2],argv[3], Race_Split(atof(argv[2]),argv[3]));
    }
    else if (strcmp(argv[0],"time")){
      printf("Your time for %s miles with a split of %s is %s\n", argv[2],argv[3], Race_Time(atof(argv[2]),argv[3]));
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
