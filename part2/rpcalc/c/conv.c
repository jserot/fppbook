#include <stdio.h>
#include <stdlib.h>


int chars_to_int(char s[])
{
  int acc=0;
  int i=0;
  while ( s[i] >= '0' && s[i] <= '9' ) {
    acc = acc*10 + (s[i]-'0');
    i++;
    }
  return acc;
}

int int_to_chars(int n, char s[], int m)
{
  int i=m-1;
  s[m]=0;
  do {
    s[i] = '0'+n%10;
    n = n/10;
    i = i-1;
    } while ( n != 0 );
  return i+1;
}

int main(int argc, char **argv)
{
  int n, m, i;
  char *s;
  if ( argc != 3 || sscanf(argv[1], "%d", &m) != 1 ) {
    printf("Usage: %s <ndigits> <string>\n", argv[0]);
    return 1;
    }
  n = chars_to_int(argv[2]);
  s = (char *)malloc(m+1);
  i = int_to_chars(n, s, m);
  printf("conv(%s)=%d=\"%s\"\n", argv[2], n, s+i);
  return 0;
}
