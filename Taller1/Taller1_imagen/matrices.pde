int[][] edge = {
  {-1, -1, -1},
  {-1,  8, -1},
  { 0,  1,  0}
};

int[][] sharpen = {
  {-1, -1, -1, -1, -1},
  {-1,  2,  2,  2, -1},
  {-1,  2,  8,  2, -1},
  {-1,  2,  2,  2, -1},
  {-1, -1, -1, -1, -1},
};

int[][] emboss = {
  {-1, -1, -1, -1, 0},
  {-1, -1, -1,  0, 1},
  {-1, -1,  0,  1, 1},
  {-1,  0,  1,  1, 1},
  { 0,  1,  1,  1, 1}
};
