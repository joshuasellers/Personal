package musicdb.tables;

import java.io.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Year;
import java.util.*;

import musicdb.objects.Song;

import org.apache.poi.hssf.record.StringRecord;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

/**
 * Created by joshuasellers on 6/5/17.
 */
public class SongTable {
    public static final String TableName = "songs";

    /**
     * Reads a csv file for data and adds them to the albums table
     *
     * Does not create the table. It must already be created
     *
     * @param conn: database connection to work with
     * @param fileName
     * @throws SQLException
     */

    public static void populateSongTableFromCSV(Connection conn, String fileName)
            throws SQLException{

        /**
         * Structure to store the data as you read it in
         * Will be used later to populate the table
         */
        try {
            POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(fileName));
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            HSSFSheet sheet = wb.getSheetAt(0);
            HSSFRow row;

            ArrayList<String> check = new ArrayList<>();

            int rows; // No of rows
            rows = sheet.getPhysicalNumberOfRows();

            int cols = 0; // No of columns
            int tmp = 0;

            // get the data even if it doesn't start from first few rows
            for (int i = 0; i < 10 || i < rows; i++) {
                row = sheet.getRow(i);
                if (row != null) {
                    tmp = sheet.getRow(i).getPhysicalNumberOfCells();
                    if (tmp > cols) cols = tmp;
                }
            }
            int counter = 0;
            for (int r = 1; r < rows; r++) {
                row = sheet.getRow(r);
                if (row != null) {
                    HSSFCell song = row.getCell((short) 0);
                    HSSFCell artist = row.getCell((short) 1);
                    HSSFCell album = row.getCell((short) 3);
                    HSSFCell genre = row.getCell((short) 4);
                    HSSFCell time = row.getCell((short) 5);
                    HSSFCell t_num = row.getCell((short) 8);
                    HSSFCell d_added = row.getCell((short) 12);
                    HSSFCell plays = row.getCell((short) 13);
                    HSSFCell l_played = row.getCell((short) 14);
                    HSSFCell skips = row.getCell((short) 15);
                    HSSFCell l_skipped = row.getCell((short) 16);
                    if (song != null && artist != null &&
                            album != null && genre != null && time != null &&
                            t_num != null && d_added != null && plays != null &&
                            l_played != null && skips != null && l_skipped != null)
                    {
                        if (!check.contains(song.toString())) {
                            check.add(song.toString());
                            String new_song = song.toString().replaceAll("'", "''");
                            String new_artist = artist.toString().replaceAll("'", "''");
                            String new_album = album.toString().replaceAll("'", "''");
                            String new_genre = genre.toString().replaceAll("'", "''");
                            String new_time = time.toString().replaceAll("\\.0*$", "");
                            String new_t_num = t_num.toString().replaceAll("\\.0*$", "");
                            String new_d_added = d_added.toString().replaceAll("'", "''");
                            String new_plays = plays.toString().replaceAll("\\.0*$", "");
                            String new_l_played = l_played.toString().replaceAll("'", "''");
                            String new_skips = skips.toString().replaceAll("\\.0*$", "");
                            String new_l_skipped = l_skipped.toString().replaceAll("'", "''");
                            addSong(conn,
                                    new Song(counter, new_song, new_artist, new_album, new_genre,
                                            Integer.parseInt(new_time), Integer.parseInt(new_t_num),
                                            new_d_added, Integer.parseInt(new_plays), new_l_played,
                                            Integer.parseInt(new_skips),new_l_skipped));
                            counter++;
                        }
                    }
                }
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Create the song table with the given attributes
     *
     * @param conn: the database connection to work with
     */
    public static void createSongTable(Connection conn){
        try {
            String query = "CREATE TABLE IF NOT EXISTS songs("
                    + "SONG_ID INT PRIMARY KEY,"
                    + "SONG_NAME VARCHAR(255),"
                    + "ARTIST_ID INT,"
                    + "ALBUM_ID INT,"
                    + "GENRE_ID INT,"
                    + "SONG_TIME INT,"
                    + "TRACK_NUM INT,"
                    + "DATE_ADDED VARCHAR(255),"
                    + "PLAYS INT,"
                    + "LAST_PLAYED VARCHAR(255),"
                    + "SKIPS INT,"
                    + "LAST_SKIPPED VARCHAR(255),"
                    + "FOREIGN KEY (ARTIST_ID) REFERENCES artists,"
                    + "FOREIGN KEY (ALBUM_ID) REFERENCES albums,"
                    + "FOREIGN KEY (GENRE_ID) REFERENCES genres);" ;

            /**
             * Create a query and execute
             */
            Statement stmt = conn.createStatement();
            stmt.execute(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Adds a single song to the database
     *
     */
    public static void addSong(Connection conn, Song s){
        /**
        * SQL insert statement
        */
        try {
            /**
             * create and execute the query
             */
            String query1 = "SELECT ARTIST_INDEX FROM artists WHERE ARTIST_NAME=\'"+s.getArtist_ID()+"\';";
            Statement stmt1 = conn.createStatement();
            ResultSet result = stmt1.executeQuery(query1);
            String query2 = "SELECT G_ID FROM genres WHERE GENRE=\'"+s.getGenre_ID()+"\';";
            Statement stmt2 = conn.createStatement();
            ResultSet result1 = stmt2.executeQuery(query2);
            String query3 = "SELECT ALBUM_ID FROM albums WHERE ALBUM_NAME=\'"+s.getAlbum_ID()+"\';";
            Statement stmt3 = conn.createStatement();
            ResultSet result2 = stmt3.executeQuery(query3);
            if (result.next() && result1.next() && result2.next()){
                String query = String.format("INSERT INTO songs "
                                + "VALUES(%d,\'%s\',%d,%d,%d,%d,%d,\'%s\',%d,"
                                + "\'%s\',%d,\'%s\');",
                        s.getSong_ID(),s.getName(),result.getInt(1),result2.getInt(1),result1.getInt(1),
                        s.getTime(),s.getTrack_Num(),s.getDate_Added(),s.getPlays(),s.getLast_Played(),
                        s.getSkips(),s.getLast_Skipped());
                Statement stmt = conn.createStatement();
                stmt.execute(query);
            }
            /**
             * create and execute the query
             */
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static String printPossibleSongs(Connection conn, String inp, Scanner scan) {
        String new_inp1 = inp.replaceAll("'", "''");
        String new_inp2 = new_inp1.replaceAll("\\.0*$", "");
        String query = "SELECT SONG_NAME FROM songs " +
                    "WHERE SONG_NAME LIKE \'%"+ new_inp2 +"%\'";
        int num = 0;
        String[] holder = new String[10];
            try {
                Statement stmt = conn.createStatement();
                ResultSet result = stmt.executeQuery(query);
                int count = 0;
                while(result.next()){
                    System.out.println("**************");
                    System.out.format(count+ ": %-5s\n",

                            result.getString(1)  //name
                    );
                    System.out.println("**************");
                    holder[count] = result.getString(1);
                    count++;
                    if (count%10==0){
                        System.out.println("Print next ten results (Y/N)?");
                        String s = scan.next();
                        if (s.equals("Y")) {
                            count = 0;
                        }
                        else {
                            System.out.println("Quit (Y/N)?");
                            inp = scan.next();
                            if (inp.equals("Y")) return "q";
                            else{
                                System.out.println("Choose number:");
                                num = Integer.parseInt(scan.next());
                                if (num>9) System.out.println("INVALID NUMBER");
                                else return holder[num];
                            }
                        }
                    }
                }
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        return "q";
        }

        public static void createPlaylist(Connection conn, String song, int length, Scanner scan){
            int counter = 0;
            String new_inp1 = song.replaceAll("'", "''");
            String new_inp2 = new_inp1.replaceAll("\\.0*$", "");
            String query = "SELECT * FROM songs " +
                    "WHERE SONG_NAME = \'"+new_inp2+"\'";
            try {
                Statement stmt = conn.createStatement();
                ResultSet result = stmt.executeQuery(query);
                while (result.next()) {
                    int id = result.getInt(1);
                    String name = result.getString(2);
                    int artist_id = result.getInt(3);
                    int album_id = result.getInt(4);
                    int genre_id = result.getInt(5);
                    int song_time = result.getInt(6);
                    int track_num = result.getInt(7);
                    String date_added = result.getString(8);
                    int plays = result.getInt(9);
                    String last_played = result.getString(10);
                    int skips = result.getInt(11);
                    String last_skipped = result.getString(12);
                    System.out.println("Discovery or Comfort: (D/C)");
                    String dc = scan.next();
                    if (dc.equals("D")){
                        Map<Integer, Integer> artist_tracker = new HashMap<>();
                        Map<Integer, Integer> year_tracker = new HashMap<>();
                        String query2 = "SELECT * FROM songs " +
                                "WHERE GENRE_ID ="+genre_id+" " +
                                "ORDER BY PLAYS ASC, (SKIPS/PLAYS) ASC";
                        Statement stm = conn.createStatement();
                        ResultSet resul = stm.executeQuery(query2);

                        PrintWriter pw = null;

                        try {
                            pw = new PrintWriter(new File(song+"_playlist.csv"));

                            StringBuilder sb = new StringBuilder();
                            sb.append("song");
                            sb.append(',');
                            sb.append("artist");
                            sb.append('\n');

                            while (resul.next() && length > counter) {
                                String query4 = "SELECT ALBUM_YEAR FROM albums " +
                                        "WHERE ALBUM_ID =" + resul.getInt(4);
                                Statement s = conn.createStatement();
                                ResultSet res = s.executeQuery(query4);
                                res.next();
                                int year = res.getInt(1);
                                try {
                                    if (resul.getInt(1)==id) {
                                        if (!artist_tracker.containsKey(id)) {
                                            if (!year_tracker.containsKey(year)) {
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(id, (int) Math.round(length * .1));
                                                else artist_tracker.put(id, 1);
                                                year_tracker.put(year,1);
                                                counter++;
                                            }
                                            else if (year_tracker.get(year)<length*.25){
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(id, (int) Math.round(length * .1));
                                                else artist_tracker.put(id, 1);
                                                year_tracker.replace(year,year_tracker.get(year)+1);
                                                counter++;
                                            }
                                        }
                                        else if (artist_tracker.containsKey(id) && artist_tracker.get(id) < length*.1){
                                            if (!year_tracker.containsKey(year)) {
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(id, (int) Math.round(length * .1));
                                                else artist_tracker.replace(id, artist_tracker.get(id) + 1);
                                                counter++;
                                                year_tracker.put(year,1);
                                            }
                                            else if (year_tracker.get(year)<length*.25){
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(id, (int) Math.round(length * .1));
                                                else artist_tracker.replace(id, artist_tracker.get(id) + 1);
                                                counter++;
                                                year_tracker.replace(year,year_tracker.get(year)+1);
                                            }
                                        }
                                        else continue;
                                    }
                                    else {
                                        if (!artist_tracker.containsKey(resul.getInt(3))) {
                                            if (!year_tracker.containsKey(year)) {
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(resul.getInt(3), (int) Math.round(length * .1));
                                                else artist_tracker.put(resul.getInt(3), 1);
                                                counter++;
                                                year_tracker.put(year,1);
                                            }
                                            else if (year_tracker.get(year)<length*.25){
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(resul.getInt(3), (int) Math.round(length * .1));
                                                else artist_tracker.put(resul.getInt(3), 1);
                                                counter++;
                                                year_tracker.replace(year,year_tracker.get(year)+1);
                                            }
                                        }
                                        else if (artist_tracker.containsKey(resul.getInt(3)) && artist_tracker.get(resul.getInt(3)) < length*.1){
                                            if (!year_tracker.containsKey(year)) {
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(resul.getInt(3), (int) Math.round(length * .1));
                                                else
                                                    artist_tracker.replace(resul.getInt(3), artist_tracker.get(id) + 1);
                                                counter++;
                                                year_tracker.put(year,1);
                                            }
                                            else if (year_tracker.get(year)<length*.25){
                                                String query3 = "SELECT ARTIST_NAME FROM artists " +
                                                        "WHERE ARTIST_INDEX =" + resul.getInt(3);
                                                Statement st = conn.createStatement();
                                                ResultSet resu = st.executeQuery(query3);
                                                resu.next();
                                                sb.append("\""+resu.getString(1)+"\"");
                                                sb.append(",");
                                                sb.append("\""+resul.getString(2)+"\"");
                                                sb.append("\n");
                                                if (resul.getInt(6) > 480)
                                                    artist_tracker.put(resul.getInt(3), (int) Math.round(length * .1));
                                                else
                                                    artist_tracker.replace(resul.getInt(3), artist_tracker.get(id) + 1);
                                                counter++;
                                                year_tracker.replace(year,year_tracker.get(year)+1);
                                            }
                                        }
                                        else continue;
                                    }
                                }
                                catch (Exception e) {}
                            }
                            pw.write(sb.toString());
                            pw.close();
                            System.out.println("playlist made");
                        }
                        catch (IOException e){}
                    }
                }
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
}
