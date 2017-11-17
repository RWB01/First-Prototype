//vector input_array 1x5-0x9
//number value 0-9
//end of variables descriptions

public class InsertionSort {
	
    public static void main(String[] args) {
		
		InsertionSort solution = new InsertionSort();
		
        solution.solve();
    }
	
    private void solve() {
		for (int i = 1; i < input_array.length; i++) {
			value = input_array[i];
    		int j = i - 1;

    		while(j >= 0 && input_array[j] > value){
			    input_array[j + 1] = input_array[j];
			    j = j - 1;
		    }
		    input_array[j + 1] = value;
		}

	    
    }
}

