import java.awt.Dimension;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ScrollPaneConstants;

import org.antlr.v4.gui.TreeViewer;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;


public class Main {
 public static void main(String[] args) {
        String fileName = "C:\\Users\\L E N O V O - K P S\\Desktop\\test.LULU2";
        File file = new File(fileName);
        FileInputStream fis = null;

        try {
            fis = new FileInputStream(file);

            @SuppressWarnings("deprecation")
   ANTLRInputStream input = new ANTLRInputStream(fis);

            LULU2Lexer lexer = new LULU2Lexer(input);

            CommonTokenStream tokens = new CommonTokenStream(lexer);

            LULU2Parser parser = new LULU2Parser(tokens);

            ParseTree tree = parser.program();


        } catch (IOException e) {
            e.printStackTrace();
        }
    }}