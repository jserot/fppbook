#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "img.h"

int create_img(int nr, int nc, int maxv, img_t *im)
{
  int i, j;
  im->nrows = nr;
  im->ncols = nc;
  im->maxv = maxv;
  im->pixels = (pixel_t **)malloc(im->nrows * sizeof(pixel_t *));
  if ( im->pixels == NULL ) {
    fprintf(stderr, "read_pgm: can't allocate memory.\n");
    return(1);
    }
  for ( i=0; i<im->nrows; i++ ) {
    im->pixels[i] = (pixel_t *)malloc(im->ncols * sizeof(pixel_t));
    if ( im->pixels == NULL ) {
      fprintf(stderr, "read_pgm: can't allocate memory.\n");
      return(1);
      }
    }
  return 0;
}

int read_pgm(char *fname, img_t *im)
{
  FILE *fp;
  char fmt[80];
  int nr, nc, maxv; 
  int i, j;

  if ((fp = fopen(fname, "r")) == NULL) {
    fprintf(stderr, "read_pgm: can't open file %s.\n", fname); return(1);
    }
  if ( fscanf(fp, "%s %d %d %d", fmt, &nr, &nc, &maxv) != 4 ) {
    fprintf(stderr, "read_pgm: bad header.\n"); return(2);
    }
  if ( strcmp(fmt, "P2" ) != 0 ) {
    fprintf(stderr, "read_pgm: can only read P2 format.\n"); return(3);
    }
  im->nrows = nr;
  im->ncols = nc;
  im->maxv = maxv;
  im->pixels = (pixel_t **)malloc(im->nrows * sizeof(pixel_t *));
  if ( im->pixels == NULL ) {
    fprintf(stderr, "read_pgm: can't allocate memory.\n");
    return(7);
    }
  for ( i=0; i<im->nrows; i++ ) {
    im->pixels[i] = (pixel_t *)malloc(im->ncols * sizeof(pixel_t));
    if ( im->pixels == NULL ) {
      fprintf(stderr, "read_pgm: can't allocate memory.\n");
      return(7);
      }
    }
  for ( i=0; i<im->nrows; i++ ) {
    for ( j=0; j<im->ncols; j++ ) {
      if ( fscanf(fp, "%d", &im->pixels[i][j]) != 1 ) {
        fprintf(stderr, "read_pgm: cant read pixel from image file.\n");
        return(8);
        }
      }
    }
  fclose(fp);
  return 0;
}

int write_pgm(char *fname, img_t *im)
{
  FILE *fp;
  int i, j;
  if ( (fp = fopen(fname, "w")) == NULL ) {
    fprintf(stderr, "write_pgm: can't open image file.\n");
    return 1;
    }
  fprintf(fp, "%s\n%d %d\n%d\n", "P2", im->nrows, im->ncols, im->maxv);
  for ( i=0; i<im->nrows; i++ ) {
    for ( j=0; j<im->ncols; j++ )
      fprintf(fp, "%d ", im->pixels[i][j]);
    fprintf(fp, "\n");
    }
  fclose(fp);
  return 0;
}
