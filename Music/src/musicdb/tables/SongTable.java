package musicdb.tables;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import musicdb.objects.Artist;

import musicdb.objects.Song;

/**
 * Created by joshuasellers on 6/5/17.
 */
public class SongTable {
    public static final String TableName = "songs";

    /**
     * Reads a csv file for data and adds them to the songs table
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
        ArrayList<Song> songs = new ArrayList<>();
        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName));

            // Skip the first line which is just the format specifier for the CSV file.
            String line = br.readLine();
            while((line = br.readLine()) != null){
                String[] split = line.split("\t");
                songs.add(new Song(split));
            }
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /**
         * Creates the SQL query to do a bulk add of all songs
         * that were read in. This is more efficient then adding one
         * at a time
         */
        String sql = createSongsInsertSQL(songs);

        /**
         * Create and execute an SQL statement
         * execute only returns if it was successful
         */
        Statement stmt = conn.createStatement();
        stmt.execute(sql);
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
                    + "NAME VARCHAR(255),"
                    + "ARTIST_ID VARCHAR(255),"
                    + "ALBUM_ID VARCHAR(255),"
                    + "GENRE_ID VARCHAR(255),"
                    + "TIME INT,"
                    + "DISC_NUM INT,"
                    + "TRACK_NUM INT,"
                    + "YEAR INT,"
                    + "DATE_ADDED VARCHAR(255),"
                    + "COMMENT VARCHAR(255),"
                    + "PLAYS INT,"
                    + "LAST_PLAYED VARCHAR(255),"
                    + "SKIPS INT,"
                    + "LAST_SKIPPED INT,"
                    + "RATING INT);";

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
    public static void addSong(Connection conn, int song_id,String name, String artist_id,
                               String album_id,String genre_id,int time,int disc_num,int track_num,String year,
                               String date_added,String comment,int plays,String last_played,int skips,
                               String last_skipped,int rating){

        /**
         * SQL insert statement
         */
        String query = String.format("INSERT INTO songs "
                        + "VALUES(%d,\'%s\',\'%s\',\'%s\',\'%s\',%d,%d,%d,\'%s\',\'%s\',"
                        + "\'%s\',%d,\'%s\',%d,\'%s\',%d);",
                song_id,name,artist_id,album_id,genre_id,time,disc_num,track_num,year,
                date_added,comment,plays,last_played,skips,last_skipped,rating);
        try {
            /**
             * create and execute the query
             */
            Statement stmt = conn.createStatement();
            stmt.execute(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    /**
     * This creates an sql statement to do a bulk add of songs
     *
     * @param songs: list of Song objects to add
     *
     * @return
     */
    public static String createSongsInsertSQL(ArrayList<Song> songs){
        StringBuilder sb = new StringBuilder();

        /**
         * The start of the statement,
         * tells it the table to add it to
         * the order of the data in reference
         * to the columns to add it to
         */
        sb.append("INSERT INTO songs (SONG_ID,NAME STRING,ARTIST_ID INT,ALBUM_ID INT,GENRE_ID INT,"
                + "TIME,DISC_NUM,TRACK_NUM,YEAR,DATE_ADDED,COMMENT,PLAYS,LAST_PLAYED,"
                + "SKIPS,LAST_SKIPPED,RATING) VALUES");

        /**
         * For each song append a tuple
         * If it is not the last artist add a comma to separate
         * If it is the last artist add a semi-colon to end the statement
         */
        for(int i = 0; i < songs.size(); i++){
            Song d = songs.get(i);
            sb.append(String.format("(%d,\'%s\',\'%s\',\'%s\',\'%s\',%d,%d,%d,\'%s\',\'%s\',"
                            + "\'%s\',%d,\'%s\',%d,\'%s\',%d)",
                    d.getSong_ID(), d.getName(), d.getArtist_ID(), d.getAlbum_ID(),
                    d.getGenre_ID(), d.getTime(),d.getDisc_Num(),d.getTrack_Num(),
                    d.getYear(), d.getDate_Added(), d.getComment(), d.getPlays(),
                    d.getLast_Played(), d.getSkips(), d.getLast_Skipped(), d.getRating()));
            if( i != songs.size()-1){
                sb.append(",");
            }
            else{
                sb.append(";");
            }
        }

        return sb.toString();
    }
}
