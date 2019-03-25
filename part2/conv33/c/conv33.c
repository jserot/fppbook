#include "conv33.h"
#include <stdio.h>

void conv33(img_t is, img_t ir, pixel h[3][3], pixel_t v, float norm)
{
  int i, j, k, l;
  pixel acc;
  int M = is.nrows;
  int N = is.ncols;
  for ( i=0; i<M; i++ ) {
    for ( j=0; j<N; j++ ) {
      if ( i>0 && i<M-1 && j>0 && j<N-1 ) {
        acc = 0;
        for ( k=-1; k<=1; k++ ) {
          for ( l=-1; l<=1; l++ ) {
            acc += h[k+1][l+1] * is.pixels[i+k][j+l];
          }
        }
        ir.pixels[i][j] = (pixel_t)(acc*norm);
      }
      else
        ir.pixels[i][j] = v;
    }
  }
}
