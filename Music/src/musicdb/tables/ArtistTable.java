package musicdb.tables;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import musicdb.objects.Album;

import musicdb.objects.Artist;
/**
 * Created by joshuasellers on 6/5/17.
 */
public class ArtistTable {
    public static final String TableName = "artists";

    /**
     * Reads a csv file for data and adds them to the artists table
     * Does not create the table. It must already be created
     *
     * @param conn: database connection to work with
     * @param fileName
     * @throws SQLException
     */

    public static void populateArtistTableFromCSV(Connection conn, String fileName)
            throws SQLException{
        /**
         * Structure to store the data as you read it in
         * Will be used later to populate the table
         */
        ArrayList<Artist> artists = new ArrayList<>();
        ArrayList<String> check = new ArrayList<>();
        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName));

            // Skip the first line which is just the format specifier for the CSV file.
            String line = br.readLine();
            for(int i = 0; i<5; i++){
                line = br.readLine();
                String[] split = line.split("\t");
                if (!check.contains(split[1])){
                    artists.add(new Artist(split));
                    check.add(split[1]);
                }
            }
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /**
         * Creates the SQL query to do a bulk add of all artists
         * that were read in. This is more efficient then adding one
         * at a time
         */
        String sql = createArtistsInsertSQL(artists);

        /**
         * Create and execute an SQL statement
         * execute only returns if it was successful
         */
        Statement stmt = conn.createStatement();
        stmt.execute(sql);
    }

    /**
     * Create the artist table with the given attributes
     *
     * @param conn: the database connection to work with
     */
    public static void createArtistTable(Connection conn){
        try {
            String query = "CREATE TABLE IF NOT EXISTS artists("
                    + "ARTIST_INDEX INT PRIMARY KEY, "
                    + "ARTIST_NAME VARCHAR(255));";

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
     * Adds a single artist to the database
     *
     * @param conn
     * @param name
     */
    public static void addArtist(Connection conn, String name){

        /**
         * SQL insert statement
         */
        String query = String.format("INSERT INTO artists "
                        + "VALUES(%d, \'%s\');",
                name);
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
     * This creates an sql statement to do a bulk add of artists
     *
     * @param artists: list of Artist objects to add
     *
     * @return
     */
    public static String createArtistsInsertSQL(ArrayList<Artist> artists){
        StringBuilder sb = new StringBuilder();

        /**
         * The start of the statement,
         * tells it the table to add it to
         * the order of the data in reference
         * to the columns to add it to
         */
        sb.append("INSERT INTO artists (ARTIST_INDEX, ARTIST_NAME) VALUES");

        /**
         * For each artist append a tuple
         * If it is not the last artist add a comma to separate
         * If it is the last artist add a semi-colon to end the statement
         */
        for(int i = 0; i < artists.size(); i++){
            Artist d = artists.get(i);
            sb.append(String.format("(%d, \'%s\')",
                    d.getIndex(),d.getName()));
            if( i != artists.size()-1){
                sb.append(",");
            }
            else{
                sb.append(";");
            }
        }

        return sb.toString();
    }
}
