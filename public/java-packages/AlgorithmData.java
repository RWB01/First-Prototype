/**
 *
 * @author Goldo
 */
import org.json.*;

public class AlgorithmData {
    int question_number;
    String output_data;
    JSONObject jsonObject;
    
    public AlgorithmData(){
        question_number = 1;
        output_data = "";
    }
        
    private void incQuestionNumber(){
        question_number++;
    }
    
    public void parseJSON(String json_data){
         jsonObject = new JSONObject(json_data);
    }

    public int getNumberFromJSON(String var_name){
        return jsonObject.getInt(var_name);
    }
    
    public String getStringFromJSON(String var_name){ 
        return jsonObject.getString(var_name);
    }
    
    public int[] getVectorFromJSON(String var_name){
        JSONArray vector_array = (JSONArray) jsonObject.get(var_name);
        int length = vector_array.length();
        int[] result = new int[length];
        for(int i = 0; i < length; i++){
            result[i] = vector_array.getInt(i);
        }
        
        return result;
    }
    
    public int[][] getMatrixFromJSON(String var_name){ 
        JSONArray matrix_rows = (JSONArray) jsonObject.get(var_name);
        int rows = matrix_rows.length();
        int columns = matrix_rows.getJSONArray(0).length();
        int[][] result = new int[rows][columns];
        for (int i = 0; i < rows; i++) {
            JSONArray temp_row = matrix_rows.getJSONArray(i);
            for (int j = 0; j < columns; j++) {
                result[i][j] = temp_row.getInt(j);
            }
        }
        return result;
    }
    
    public void printAllData(int step_number){
        if (!output_data.equals("")){
            output_data = "{ \"QuestionNumber\":" + String.valueOf(question_number) + 
                ", \"StepNumber\":" +  String.valueOf(step_number) +
                ", " + "\"Variables\":" + "{" + output_data + "}" + " }";
            System.out.println(output_data);
            output_data = "";
            incQuestionNumber();
        }
    }
    
    
    
    public void store(int number, String var_name){
        if (!output_data.equals("")){
            output_data += ",";
        }
        output_data += " "+ "\"" + var_name + "\":" + String.valueOf(number);
    }
    
    public void store(double number, String var_name){
        if (!output_data.equals("")){
            output_data += ",";
        }
        output_data += " "+ "\"" + var_name + "\":" + String.valueOf(number);
    }
    
    public void store(String str, String var_name){
        if (!output_data.equals("")){
            output_data += ",";
        }
        output_data += " "+ "\"" + var_name + "\":" + "\"" + str + "\"";
    }
    
    public void store(int[] vector, String var_name){
        String result = "[";
        for (int i = 0; i < vector.length; i++) {
            if (i != 0){
                result += ",";
            }
            result +=  String.valueOf(vector[i]);
        }
        result += "]";
        if (!output_data.equals("")){
            output_data += ",";
        }
        output_data += " "+ "\"" + var_name + "\":" + result;
    }
    
    public void store(int[][] matrix, String var_name){
        String result = "[";
        for (int i = 0; i < matrix.length; i++) {
            if (i != 0){
                result += ",";
            }
            result += "[";
            for (int j = 0; j < matrix[0].length; j++) {
                if (j != 0){
                    result += ",";
                }
                result +=  String.valueOf(matrix[i][j]);
            }
            result += "]";
        }
        result += "]";
        if (!output_data.equals("")){
            output_data += ",";
        }
        output_data += " "+ "\"" + var_name + "\":" + result;
    }
}