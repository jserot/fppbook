// Listing 5.1

#ifdef DEBUG
#include <stdio.h>
#endif

int pgcd(int a, int b) {
  while ( a != b ) {
#ifdef DEBUG
    printf("\ta=%3d  b=%3d\n", a, b);
#endif
    if ( a > b )
      a = a-b;
    else 
      b = b-a;
  }
  return a;
}
