#include <stdio.h>
#include "img.h"
#include "conv33.h"

int main(int argc, char **argv) 
{
  img_t is, ir;
  int i, j;
  pixel_t h[3][3] = {
    1, 1, 1, 
    1, 1, 1, 
    1, 1, 1
    };
  if ( argc != 3 ) {
    fprintf(stderr, "Usage: %s ifile ofile\n", argv[0]);
    return 1;
    }
  if ( read_pgm(argv[1], &is) != 0 ) return 2;
  if ( create_img(is.nrows, is.ncols, is.maxv, &ir) != 0 ) return 3;
  conv33(is, ir, h, 0, 1/9.0);
  if ( write_pgm(argv[2], &ir) != 0 ) return 4;
  return 0;
}

