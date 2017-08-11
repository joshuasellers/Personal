package musicdb.tables;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import musicdb.objects.Artist;

import musicdb.objects.Genre;

/**
 * Created by joshuasellers on 6/5/17.
 */
public class GenreTable {
    public static final String TableName = "genres";

    /**
     * Reads a csv file for data and adds them to the genres table
     * Does not create the table. It must already be created
     *
     * @param conn: database connection to work with
     * @param fileName
     * @throws SQLException
     */

    public static void populateGenreTableFromCSV(Connection conn, String fileName)
            throws SQLException{
        /**
         * Structure to store the data as you read it in
         * Will be used later to populate the table
         */
        ArrayList<Genre> genres = new ArrayList<>();
        ArrayList<String> check = new ArrayList<>();
        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName));

            // Skip the first line which is just the format specifier for the CSV file.
            String line = br.readLine();
            while((line = br.readLine()) != null){
                String[] split = line.split("\t");
                if (!check.contains(split[5])){
                    genres.add(new Genre(split));
                    check.add(split[5]);
                }
            }
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /**
         * Creates the SQL query to do a bulk add of all genres
         * that were read in. This is more efficient then adding one
         * at a time
         */
        String sql = createGenresInsertSQL(genres);

        /**
         * Create and execute an SQL statement
         * execute only returns if it was successful
         */
        Statement stmt = conn.createStatement();
        stmt.execute(sql);
    }

    /**
     * Create the genre table with the given attributes
     *
     * @param conn: the database connection to work with
     */
    public static void createGenreTable(Connection conn){
        try {
            String query = "CREATE TABLE IF NOT EXISTS genres("
                    + "NAME VARCHAR(255) PRIMARY KEY);";

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
    public static void addGenre(Connection conn, String name){

        /**
         * SQL insert statement
         */
        String query = String.format("INSERT INTO divisions "
                        + "VALUES(\'%s\');",
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
     * This creates an sql statement to do a bulk add of genres
     *
     * @param genres: list of Genre objects to add
     *
     * @return
     */
    public static String createGenresInsertSQL(ArrayList<Genre> genres){
        StringBuilder sb = new StringBuilder();

        /**
         * The start of the statement,
         * tells it the table to add it to
         * the order of the data in reference
         * to the columns to add it to
         */
        sb.append("INSERT INTO genres (NAME) VALUES");

        /**
         * For each genre append a tuple
         * If it is not the last genre add a comma to separate
         * If it is the last genre add a semi-colon to end the statement
         */
        for(int i = 0; i < genres.size(); i++){
            Genre d = genres.get(i);
            sb.append(String.format("(\'%s\')",
                    d.getName()));
            if( i != genres.size()-1){
                sb.append(",");
            }
            else{
                sb.append(";");
            }
        }

        return sb.toString();
    }
}
