public class BubbleSort {
	
private static int[] input_array;
private static AlgorithmData ad;
    public static void main(String[] args) {
ad = new AlgorithmData();
ad.parseJSON(args[0]);
input_array = ad.getVectorFromJSON("input_array");
		
		BubbleSort solution = new BubbleSort();
ad.store(input_array,"input_array");
ad.printAllData(1);
		
        solution.solve();
    }
	
    private void solve() {
		for (int i = 0; i < input_array.length; i++) {
			int min = 0;
ad.store(input_array,"input_array");
ad.printAllData(2);
			for (int j = 0; j < input_array.length - 1; j++) {
				if (input_array[j] > input_array[j+1]) {
					min = input_array[j+1];
					input_array[j+1] = input_array[j];
					input_array[j] = min;
ad.store(input_array,"input_array");
ad.printAllData(3);
				}
			}
		}
    }
ad.store(input_array,"input_array");
ad.printAllData(4);
}