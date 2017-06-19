//matrix g 5x5-20x20
//number INF 0-1000000000
//string args 1x20-1x20
//number vertexCount 1-20
//number i 1-20
//number j 1-20
//number k 1-20
//end of variables descriptions

import java.io.PrintWriter;
import java.util.Arrays;
import org.json.*;

public class Warshall {

    private static final int INF = 1000 * 1000 * 1000;

    private int[][] input_array;

    private static final PrintWriter printWriter = new PrintWriter(System.out);

    public static void main(String[] args) {

        Warshall solution = new Warshall();

        solution.get_matrix_from_json(args[0]);

        solution.solve();

        printWriter.close();
    }

    private void solve() {

        int length = input_array.length;

        for (int k = 0; k < length; k++) {

            print_matrix(6 + "-input_array:" + input_array);

            for (int i = 0; i < length; i++) {
                for (int j = 0; j < length; j++) {
                    input_array[i][j] = Math.min(input_array[i][j], input_array[i][k] + input_array[k][j]);
                }
            }
        }



        print_matrix(input_array);

    }

    private void print_matrix(int[][] array) {

        int length = array.length;

        JSONArray external_json_array = new JSONArray();

        for (int i = 0; i < length; i++) {
            JSONArray internal_json_array = new JSONArray();
            for (int j = 0; j < length; j++) {
                if (array[i][j] == INF) {
                    internal_json_array.put(0);
                } else {
                    internal_json_array.put(array[i][j]);
                }
            }
            external_json_array.put(internal_json_array);
        }

        printWriter.print(external_json_array.toString());
        printWriter.println();

    }

    private void get_matrix_from_json(String encoded_array) {

        JSONArray decoded_array = new JSONArray(encoded_array);
        int length = decoded_array.length();

        input_array = new int[length][length];
        for (int i = 0; i < length; i++) {
            JSONArray decoded_row = decoded_array.getJSONArray(i);
            for (int j = 0; j < length; j++) {
                input_array[i][j] = (int) decoded_row.getInt(j);
                if (input_array[i][j] == -1) {
                    input_array[i][j] = INF;
                }
            }
        }

    }
}