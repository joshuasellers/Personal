package musicdb.tables;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import musicdb.objects.Album;
/**
 * Created by joshuasellers on 6/5/17.
 */
public class AlbumTable {
    public static final String TableName = "albums";

    /**
     * Reads a csv file for data and adds them to the albums table
     *
     * Does not create the table. It must already be created
     *
     * @param conn: database connection to work with
     * @param fileName
     * @throws SQLException
     */

    public static void populateAlbumTableFromCSV(Connection conn, String fileName)
            throws SQLException{
        /**
         * Structure to store the data as you read it in
         * Will be used later to populate the table
         */
        ArrayList<Album> albums = new ArrayList<>();
        ArrayList<String> check = new ArrayList<>();
        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName));

            // Skip the first line which is just the format specifier for the CSV file.
            String line = br.readLine();
            while((line = br.readLine()) != null){
                String[] split = line.split("\t");
                if (!check.contains(split[3])){
                    albums.add(new Album(split));
                    check.add(split[3]);
                }
                albums.add(new Album(split));
            }
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /**
         * Creates the SQL query to do a bulk add of all divisions
         * that were read in. This is more efficient then adding one
         * at a time
         */
        String sql = createAlbumsInsertSQL(albums);

        /**
         * Create and execute an SQL statement
         *
         * execute only returns if it was successful
         */
        Statement stmt = conn.createStatement();
        stmt.execute(sql);
    }

    /**
     * Create the division table with the given attributes
     *
     * @param conn: the database connection to work with
     */
    public static void createAlbumTable(Connection conn){
        try {
            String query = "CREATE TABLE IF NOT EXISTS albums("
                    + "ALBUM_ID VARCHAR(255) PRIMARY KEY,"
                    + "ARTIST_ID VARCHAR(255),"
                    + "NAME VARCHAR(255)"
                    + "YEAR INT"
                    + "TRACK_COUNT INT,"
                    + "FOREIGN KEY (ARTIST_ID) REFERENCES artists);" ;

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
     * Adds a single album to the database
     *
     * @param conn
     * @param album_id
     * @param artist_id
     * @param name
     * @param year
     * @param track_count
     */
    public static void addAlbum(Connection conn, String album_id, String artist_id,
                                String name, int year, int track_count){

        /**
         * SQL insert statement
         */
        String query = String.format("INSERT INTO divisions "
                        + "VALUES(\'%s\', \'%s\',\'%s\', %d, %d);",
                album_id, artist_id, name, year, track_count);
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
     * This creates an sql statement to do a bulk add of albums
     *
     * @param albums: list of Album objects to add
     *
     * @return
     */
    public static String createAlbumsInsertSQL(ArrayList<Album> albums){
        StringBuilder sb = new StringBuilder();

        /**
         * The start of the statement,
         * tells it the table to add it to
         * the order of the data in reference
         * to the columns to add it to
         */
        sb.append("INSERT INTO albums (ALBUM_ID, ARTIST_ID, NAME, YEAR, TRACK_COUNT) VALUES");

        /**
         * For each album append a tuple
         * If it is not the last album add a comma to separate
         * If it is the last album add a semi-colon to end the statement
         */
        for(int i = 0; i < albums.size(); i++){
            Album d = albums.get(i);
            sb.append(String.format("(\'%s\', \'%s\',\'%s\', %d, %d)",
                    d.getAlbum_ID(), d.getArtist_ID(), d.getName(), d.getYear(), d.getTrack_Count()));
            if( i != albums.size()-1){
                sb.append(",");
            }
            else{
                sb.append(";");
            }
        }

        return sb.toString();
    }
}
