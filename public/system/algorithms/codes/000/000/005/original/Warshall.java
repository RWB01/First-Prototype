//matrix g 5x5-20x20
//number INF 0-1000000000
//string args 1x20-1x20
//number vertexCount 1-20
//number i 1-20
//number j 1-20
//number k 1-20
//end of variables descriptions

public class Solution {
    private static final int INF = 1000 * 1000 * 1000;
    public static void main(String[] args) {
        Solution solution = new Solution();
        solution.solve();
    }
    private void solve() {
        Scanner scanner = new Scanner(System.in);
        PrintWriter printWriter = new PrintWriter(System.out);
        int vertexCount = scanner.nextInt();
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