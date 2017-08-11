package musicdb;

import musicdb.tables.AlbumTable;
import musicdb.tables.ArtistTable;
import musicdb.tables.GenreTable;
import musicdb.tables.SongTable;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;
import java.util.Arrays;
/**
 * Created by joshuasellers on 6/5/17.
 */
public class MusicDBMain {
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        DB db = new DB();
        Boolean running = true;

        //Create the database connections, basically makes the database
        db.createConnection();


        Scanner scan = new Scanner(System.in);
        while(running){
            char c = '\n';
            int length = 35;
            char[] chars = new char[length];
            Arrays.fill(chars, c);
            System.out.print(String.valueOf(chars));
            System.out.println(String.join("", Collections.nCopies(50, "*")));
            System.out.printf("%32s\n", "THE PLAYLIST MAKER");
            System.out.println(String.join("", Collections.nCopies(50, "*")));
            System.out.println("Use these commands to run queries on the data:");
            System.out.println("  p: explore player data");
            System.out.println("  t: explore team data");
            System.out.println("  d: explore division data");
            System.out.println("  c: explore conference data");
            System.out.println("  q: quit database");
            String s = scan.next();
            if(s.equals("q")){running = false;}
        }
        db.closeConnection();
    }
}
