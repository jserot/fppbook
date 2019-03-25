#ifndef _img_h
#define _img_h

typedef int pixel_t;

typedef struct {
  int nrows;
  int ncols;
  pixel_t maxv;
  pixel_t **pixels;
} img_t;

int create_img(int nr, int nc, int maxv, img_t *im);
int read_pgm(char *fname, img_t *im);
int write_pgm(char *fname, img_t *im);

#endif
