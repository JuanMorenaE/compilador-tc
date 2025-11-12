import java_cup.runtime.*;
import java.io.FileReader;

public class Main {
    static public void main(String argv[]) {
        /* Start the parser */
        try {
            Scanner lexer = new Scanner(new FileReader(argv[0]));
            parser parser = new parser(lexer);
            parser.parse();
        } catch (Exception e) {
            /* do cleanup here -- possibly rethrow e */
            e.printStackTrace();
        }
    }
}
