//vector a 1x20-1x20
//number fromIndex 1-20
//number toIndex 1-20
//number key 1-20
//number low 1-20
//number high 0-19
//number mid 0-19
//number midVal -100-100
//end of variables descriptions

private static int binarySearch0(int[] a, int fromIndex, int toIndex, int key) {
int low = fromIndex;
int high = toIndex - 1;
 
while (low <= high) {
    int mid = (low + high) >>> 1;
    int midVal = a[mid];
 
    if (midVal < key)
    low = mid + 1;
    else if (midVal > key)
    high = mid - 1;
    else
    return mid; // key found
    }
return -(low + 1);  // key not found.
}
