public class BubbleSort {
	
 private static int temp;
 private static int[] input_array;
private static AlgorithmData ad;
    public static void main(String[] args) {
ad = new AlgorithmData();
ad.parseJSON(args[0]);
 input_array = ad.getVectorFromJSON("input_array");
 
		
		BubbleSort solution = new BubbleSort();
		
        solution.solve();
    }
	
    private void solve() {
		for (int i = 0; i < input_array.length - 1; i++) {
			for (int j = 0; j < input_array.length - 1 - i; j++) {
				if (input_array[j] > input_array[j+1]) {
					temp = input_array[j];
					input_array[j] = input_array[j+1];
ad.store(input_array,"input_array");
ad.store(temp,"temp");
ad.printAllData(1);
					input_array[j+1] = temp;
				}
			}
ad.store(input_array,"input_array");
ad.store(temp,"temp");
ad.printAllData(2);
		}
    }
}