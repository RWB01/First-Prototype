public class BubbleSort {
	
private static int[] input_vector;
private static AlgorithmData ad;
    public static void main(String[] args) {
ad = new AlgorithmData();
ad.parseJSON(args[0]);
input_vector = ad.getVectorFromJSON("input_vector");
		
		BubbleSort solution = new BubbleSort();
		
        solution.solve();
    }
	
    private void solve() {
		for (int i = 0; i < input_vector.length; i++) {
			int min = 0;
ad.store(input_vector,"input_vector");
ad.printAllData(1);
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