//vector input_array 1x5-0x9
//number temp 0-9
//end of variables descriptions

public class BubbleSort {
	
    public static void main(String[] args) {
		
		BubbleSort solution = new BubbleSort();
		
        solution.solve();
    }
	
    private void solve() {
		for (int i = 0; i < input_array.length - 1; i++) {
			for (int j = 0; j < input_array.length - 1 - i; j++) {
				if (input_array[j] > input_array[j+1]) {
					temp = input_array[j];
					input_array[j] = input_array[j+1];
					input_array[j+1] = temp;
				}
			}
		}
    }
}