public class BubbleSort {
	
private static String input_string;
private static int[][] input_array;
private static int input_integer;
private static int[] input_vector;
private static AlgorithmData ad;
    public static void main(String[] args) {
ad = new AlgorithmData();
ad.parseJSON(args[0]);
input_vector = ad.getVectorFromJSON("input_vector");
input_integer = ad.getNumberFromJSON("input_integer");
input_array = ad.getMatrixFromJSON("input_array");
input_string = ad.getStringFromJSON("input_string");
		
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
		
		input_string = "aaaaaa";
		input_integer = 10;
		for (int i = 0; i < input_array.length; i++) {
			for (int j = 0; j < input_array[i].length; j++) {
				input_array[i][j] = input_array[i][j] + 1;
			}
		}
		
		int bb = 0;
ad.store(input_vector,"input_vector");
ad.store(input_integer,"input_integer");
ad.store(input_array,"input_array");
ad.store(input_string,"input_string");
ad.printAllData(2);
    }
}