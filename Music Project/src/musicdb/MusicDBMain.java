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
    public static void song(DB db, Scanner scan){
        System.out.println("Type in keywords:");
        String s = scan.next();
        String song = SongTable.printPossibleSongs(db.getConnection(), s, scan);
        //while (scan.hasNext()) inp += " " +scan.next();
        if (!song.equals("q")) {
            System.out.println("Length of playlist:");
            int l = Integer.parseInt(scan.next());
            SongTable.createPlaylist(db.getConnection(),song,l);
        }

    }
    public static void artist(DB db, Scanner scan){

    }
    public static void genre(DB db, Scanner scan){

    }
    public static void mood(DB db, Scanner scan){

    }


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
            System.out.println("  s: playlist based on song");
            System.out.println("  a: playlist based on artist");
            System.out.println("  g: playlist based on genre");
            System.out.println("  m: playlist based on mood");
            System.out.println("  q: quit database");
            String s = scan.next();
            if(s.equals("q")){running = false;}
            else if (s.equals("s")) {song(db, scan);}
            else if (s.equals("a")) {artist(db, scan);}
            else if (s.equals("g")) {genre(db, scan);}
            else if (s.equals("m")) {mood(db, scan);}
            else {
                System.out.println("ERROR");
                running = false;
            }
        }
        db.closeConnection();
    }
}
