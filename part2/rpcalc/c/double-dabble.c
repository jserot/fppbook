#include <stdio.h>
#include <stdlib.h>

typedef unsigned int uint8;
typedef unsigned int uint32;

void bits_of_int(int v, int n, char *b)
{
  b[n]=0;
  for ( int i=n-1; i>=0; i--, v>>=1 )
    b[i] = v & 1 ? '1' : '0'; 
}

void double_dabble(uint8 v, char s[], int n, int m)
{
  uint32 r;
  uint8 q;
  char b8[9];
  char b20[21];
  r = v; 
  int i, j;
  for ( i=0; i<8; i++ ) {
    bits_of_int(r, 20, b20);
    printf("i=%d r=%s\n", i, b20);
    for ( j=0; j<m; j++ ) {
      q = (r >> (8+j*4)) & 0xF;
      if ( q > 4 ) q += 3;
      r = (r & ~(0xF << (8+4*j))) | (q << (8+4*j));
      }
    r = r<<1;
    }
  s[m]=0;
  for ( i=m-1,j=0; j<m; j++,i-- ) {
    q = (r >> (8+j*4)) & 0xF;
    s[i] = q != 0 || j==0 ? q+'0' : ' ';
    }
}

int main(int argc, char **argv)
{
  int n;
  char s[4];
  if ( argc != 2 || sscanf(argv[1], "%d", &n) != 1 ) {
    printf("Usage: %s <n>\n", argv[0]);
    return 1;
    }
  double_dabble(n, s, 8, 3);
  printf("conv(%d)=\"%s\"\n", n, s);
  return 0;
}
