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
  if(argc == 1){
    while(1){
      printf("\n");
      printf("1) description \n2) ahnentafel number (base 10)\n3) ahnentafel number (base 2)\n4) relation (e.g. mother's mother's father)\n5) exit\n");
      printf("\n");
      char buff[holder];
      long inp;
      char *ptr;
      fgets(buff, holder, stdin);
      inp = strtol(buff, &ptr, 10);
      if(inp < 1 || inp > 5 || strncmp(ptr, "\n", holder) != 0){
        fprintf(stderr, "Unknown operation!\n");
      }
      else{
        if(inp == 1){
          printf("The Ahnentafel number is used to determine the relation \nbetween an individual and each of his/her direct ancestors.\n");
        }
        else if(inp == 2){
          char gen[binary_holder];
          long new_inp;
          printf("Enter the ahnentafel number in base-10: ");
          fgets(buff, holder, stdin);
          new_inp = strtol(buff, &ptr, 10);
          if(new_inp <= 0 || new_inp >= 2147483647)
            fprintf(stderr, "Invalid number!\n");
          else{
            Num_To_Bin(new_inp,gen);
            printf("ahnentafel number in binary: %s\n", gen);
            char list_of_gen[holder];
            int count_back = 0;
            int c = getGen(gen,list_of_gen, count_back);
            if(list_of_gen[0] == 's')
              printf("%s\n",list_of_gen );
            else
              printf("family relation: %s\n",list_of_gen );
            printf("generations back: %d\n", c);
          }
        }
        else if(inp == 3){
          bool ok = true;
          printf("Enter the ahnentafel number in binary: ");
          fgets(buff, holder, stdin);
          int siz = strlen(buff);
          for (int i = 0; i < siz; i++) {
            if(i+1<siz){
              if(buff[i] != '0' && buff[i] != '1'){
                ok = false;
              }
            }
          }
          if(ok == false)
            fprintf(stderr, "Invalid string!\n");
          else{
            long converted = strtol(buff, &ptr, 2);
            printf("base-10 value: %ld\n", converted);
            char generation[binary_holder];
            int c = getGen(buff, generation, c);
            if(generation[0] == 's')
              printf("%s\n",generation );
            else
              printf("family relation: %s\n",generation );
            printf("generations back: %d\n", c);
          }
        }
        else if(inp == 4){
          printf("Enter family relation (e.g.) \"father's mother\": ");
          fgets(buff, holder, stdin);
          char s[2] = " ";
          char *family_relation;
          family_relation = strtok(buff,s);
          while (family_relation != NULL) {
            printf("%s\n", family_relation );
            family_relation = strtok (NULL, s);
          }
        }
        else{
          printf("Goodbye.\n");
          return EXIT_SUCCESS;
        }
      }
    }
  }
  else{

  }
	return EXIT_SUCCESS;
}
