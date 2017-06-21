/**
 *
 * @author Goldo
 */
public class AlgorithmData {
    int question_number;
    String output_data;
    
    public AlgorithmData(){
        question_number = 1;
        output_data = "";
    }
    
    private void incQuestionNumber(){
        question_number++;
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
