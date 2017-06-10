//vector A 1x20-1x20
//number low 1-20
//number i 1-20
//number j 1-20
//number x 1-20
//number high 0-19
//number temp 0-19
//end of variables descriptions

public static void qSort(int[] A, int low, int high) {
      int i = low;                
      int j = high;
      int x = A[(low+high)/2]; 
      do {
.          while(A[i] < x) ++i;
          while(A[j] > x) --j;
.          if(i <= j){           
              int temp = A[i];
              A[i] = A[j];
              A[j] = temp;
              i++; j--;
          }
.      } while(i < j);
      if(low < j) qSort(A, low, j);
      if(i < high) qSort(A, i, high);
  }

