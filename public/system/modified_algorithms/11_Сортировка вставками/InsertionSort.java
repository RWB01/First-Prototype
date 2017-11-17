public class InsertionSort {
	
 private static int value;
 private static int[] input_array;
private static AlgorithmData ad;
    public static void main(String[] args) {
ad = new AlgorithmData();
ad.parseJSON(args[0]);
 input_array = ad.getVectorFromJSON("input_array");
 
		
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
			ad.store(input_array,"input_array");
			ad.store(value,"value");
			ad.printAllData(1);
			
		}

	    
    }
}