//vector input_vector 1x5-0x9
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
    }
}