//number i 0-100
//number j 0-100
//number k 0-100
//number h 0-100
//number m 0-100
//number b 0-100
//vector a 1x10-1x20
//vector d 1x10-1x20
//end of variables descriptions

while (d[m] < b) ++m;
while (--m >= 0){
  k = d[m];
  for (i=k; i<b; i++){
     j=i;
     h=a[i];
     while ((j >= k) && (a[j-k] > h)){  
          a[j]=a[j-k];
          j =  j-k;
     }
     a[j] = h;
  }
}
