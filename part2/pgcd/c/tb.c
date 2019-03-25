#include <stdio.h>
#include "pgcd.h"

typedef struct {
  int m, n;  // arguments;
  int r;  // Resultat attendu
  } test_pattern;

test_pattern test_patterns[] = {
  {24, 30,  6},
  {12, 5,  1},
  {120, 96, 24},
  {96, 120, 24},
  {255, 255, 255}
};


int main(void) 
{
  int i, nerr=0;
  int r;
  for ( i=0; i<sizeof(test_patterns)/sizeof(test_pattern); i++ ) {
    r = pgcd(test_patterns[i].m, test_patterns[i].n);
    if ( r != test_patterns[i].r ) {
      printf("Erreur: m=%d n=%d: valeur attendue: %d - valeur calculee: %d\n", 
             test_patterns[i].m, test_patterns[i].n, test_patterns[i].r, r);
      nerr++;
      }
    }
  printf("Test termine. %d erreur(s) detectee(s)\n", nerr);
}

