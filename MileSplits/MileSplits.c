///
/// File: ahnentafel.c
///
/// A program for race times.
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

// Used for buffering in string conversions
#define MAX 100

float string_convert(const char* arg){
  /*
    This method converts a min:sec string into a min with the sec in decimal.
    It returns this as a float.
  */
  // Mark where the ':' is in the string
  int i = 0;
  int colon = 0;
  while (arg[i] != '\0') {
    if (arg[i] == ':') {colon = i;}
    i++;
  }
  if (colon == 0) {colon = i;}
  char* holder;
  char* min_str;
  // Separate minutes
  min_str = (char*)malloc((colon+1)*sizeof(char));
  for (size_t j = 0; j < colon; j++) {min_str[j] = arg[j];}
  min_str[colon] = '\0';
  long min_f = strtol(min_str, &holder, 10);
  char* sec_str;
  // Separate seconds
  sec_str = (char*)malloc((i-colon)*sizeof(char));
  for (size_t k = 0; k < 2; k++) {sec_str[k] = arg[k+colon+1];}
  sec_str[3] = '\0';
  long sec_f = strtol(sec_str, &holder, 10);
  float correct_time = min_f +(sec_f/60.0);
  return correct_time;
}

char* time_convert(float t){
  /*
  Convert a float representation of a time into a min:sec string.
  Returns a string of the time.
  */
  // Convert float to string
  char* time_str = (char*)malloc(MAX*sizeof(char));
  gcvt(t, 6, time_str);
  int i = 0;
  int period = 0;
  // Get '.' location
  while (time_str[i] != '\0') {
    if (time_str[i] == '.') {period = i;}
    i++;
  }
  if (period == 0) {period = i;}
  char* holder;
  char* min_str;
  // Separate minutes
  min_str = (char*)malloc((period+1)*sizeof(char));
  for (size_t j = 0; j < period; j++) {min_str[j] = time_str[j];}
  min_str[period] = '\0';
  char* sec_str;
  // Separate seconds
  sec_str = (char*)malloc((i-period+1)*sizeof(char));
  for (size_t k = period; k < i; k++) {sec_str[k-period] = time_str[k];}
  sec_str[i-period] = '\0';
  // Convert to sec
  float sec_f = atof(sec_str)*60.0;
  char* final_sec = (char*)malloc(MAX*sizeof(char));
  gcvt(sec_f, 4, final_sec);
  char *result = malloc(strlen(min_str) + strlen(final_sec) + 2);
  strcpy(result, min_str);
  strcat(result, ":");
  if (strlen(final_sec)==1) {strcat(result,"0");}
  strcat(result, final_sec);
  return result;
}

char* Race_Time(float dist, const char* split){
  /*
  Gets the time for a race given its distance and the runner's split.
  Returns a string of the time.
  */
  float split_correct = string_convert(split);
  return time_convert(split_correct * dist);
}

char* Race_Split(float dist, const char* time){
  /*
  Gets the split for a race given its distance and the runner's time.
  Returns a string of the split
  */
  float time_correct = string_convert(time);
  return time_convert(time_correct/dist);
}

int main(int argc, char const *argv[]) {
	/*
	This is MileSplits' main function.  It takes in three args and outputs the mile
  splits or times depending on the input.
	*/
  //TODO make strings for the argvs and interate through them
  if(argc == 4){
    if (strcmp(argv[1],"split") == 0) {
      printf("Your mile split for %s miles over %s minutes is %s\n", argv[2],argv[3], Race_Split(atof(argv[2]),argv[3]));
    }
    else if (strcmp(argv[1],"time") == 0){
      printf("Your time for %s miles with a split of %s is %s\n", argv[2],argv[3], Race_Time(atof(argv[2]),argv[3]));
    }
    else{
      return EXIT_FAILURE;
    }
  }
  else{
    printf("Incorrect Number of args\n");
    return EXIT_FAILURE;
  }
	return EXIT_SUCCESS;
}
