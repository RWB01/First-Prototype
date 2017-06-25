import com.public.java_sys_libs.AlgorithmData;
public class Solution {
    private static final int INF = 1000 * 1000 * 1000;
    public static void main(String[] args) {
AlgorithmData ad = new AlgorithmData();
        Solution solution = new Solution();
ad.store(g,"g");
ad.store(vertexCount,"vertexCount");
ad.printAllData(1);
        solution.solve();
ad.store(g,"g");
ad.store(args,"args");
ad.store(i,"i");
ad.printAllData(2);
    }
    private void solve() {
        Scanner scanner = new Scanner(System.in);
        PrintWriter printWriter = new PrintWriter(System.out);
        int vertexCount = scanner.nextInt();
ad.store(vertexCount,"vertexCount");
ad.store(j,"j");
ad.store(k,"k");
ad.printAllData(3);
        int[][] g = new int[vertexCount][vertexCount];
        for (int i = 0; i < vertexCount; i++) {
            for (int j = 0; j < vertexCount; j++) {
                g[i][j] = scanner.nextInt();
                if (g[i][j] == 0) {
                    g[i][j] = INF;
                }
            }
        }
        for (int k = 0; k < vertexCount; k++) {
            for (int i = 0; i < vertexCount; i++) {
                for (int j = 0; j < vertexCount; j++) {                
                    g[i][j] = Math.min(g[i][j], g[i][k] + g[k][j]);
                }
            }
        }
        for (int i = 0; i < vertexCount; i++) {
            for (int j = 0; j < vertexCount; j++) {
                if (g[i][j] == INF) {
                    printWriter.print(0 + " ");
                } else {
                    printWriter.print(g[i][j] + " ");
                }
            }
            printWriter.println();
        }
        scanner.close();
        printWriter.close();
    }
}