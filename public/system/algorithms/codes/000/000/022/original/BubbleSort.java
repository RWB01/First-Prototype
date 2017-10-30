//vector input_vector 1x5-0x9
//number input_integer 1-20
//matrix input_array 2x4:5-17
//string input_string 1-6
//end of variables descriptions

public class BubbleSort {
	
    public static void main(String[] args) {
		
		BubbleSort solution = new BubbleSort();
		
        solution.solve();
    }
	
    private void solve() {
		for (int i = 0; i < input_vector.length; i++) {
			int min = 0;
			for (int j = 0; j < input_vector.length - 1; j++) {
				if (input_vector[j] > input_vector[j+1]) {
					min = input_vector[j+1];
					input_vector[j+1] = input_vector[j];
					input_vector[j] = min;
				}
			}
		}
		
		input_string = "aaaaaa";
		input_integer = 10;
		for (int i = 0; i < input_array.length; i++) {
			for (int j = 0; j < input_array[i].length; j++) {
				input_array[i][j] = input_array[i][j] + 1;
			}
		}
		
		int bb = 0;
    }
}