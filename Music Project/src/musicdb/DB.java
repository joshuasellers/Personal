package musicdb;

import musicdb.tables.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSetMetaData;
import java.sql.*;
import java.util.ArrayList;

/**
 * Created by joshuasellers on 6/5/17.
 */
public class DB {
    // database connection.
    private final String DatabaseLocation ="./music.db";
    private final String DatabaseUsername = "joshuasellers";
    private final String DatabasePassword = "joshuasellers";
    private Connection conn = null;

    /**
     * Establishes a connection to the database at the specified location.
     * @return true if the connection was successfully established, false otherwise.
     */
    public boolean createConnection()
    {
        // Create the connection using the default database location.
        return createConnection(DatabaseLocation);
    }

    /**
     * Establishes a connection to the database at the specified location.
     * @param location: path of where to place the database
     * @return true if the connection was successfully established, false otherwise.
     */
    public boolean createConnection(String location)
    {
        try
        {
            // Format the database location specifier.
            String url = "jdbc:h2:" + location;

            // Create the connection to the database.
            Class.forName("org.h2.Driver");
            this.conn = DriverManager.getConnection(url);

            // Initialize the database if is has not been initialized yet.
            initializeDatabase();

            // Successfully opened the database connection.
            return true;
        }
        catch (SQLException | ClassNotFoundException e)
        {
            // An error occurred while trying to open/create the database. Just return false
            // and the upper level program will handle displaying an error to the user.
            this.conn = null;
            return false;
        }
    }
    /**
     * Gets the SQL connection object.
     * @return returns class level connection
     */
    public Connection getConnection()
    {
        // Return the sql database connection object.
        return this.conn;
    }

    /**
     * Closes the database connection.
     */
    public void closeConnection()
    {
        try
        {
            // Close the database connection.
            this.conn.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
    }

    private void initializeDatabase()
    {
        try
        {
            // Get a list of table names that already exist in the database.
            ArrayList<String> tableNames = getTablesFromDatabase();

            // Check if the Conferences table exists and if not create it.
            if (!tableNames.contains(GenreTable.TableName))
            {
                // Create the conferences table.
                GenreTable.createGenreTable(this.conn);
                GenreTable.populateGenreTableFromCSV(this.conn,
                        "./test.txt");
            }
            if (!tableNames.contains(ArtistTable.TableName))
            {
                // Create the conferences table.
                ArtistTable.createArtistTable(this.conn);
                ArtistTable.populateArtistTableFromCSV(this.conn,
                        "./test.txt");
            }
            if (!tableNames.contains(AlbumTable.TableName))
            {
                // Create the conferences table.
                AlbumTable.createAlbumTable(this.conn);
                AlbumTable.populateAlbumTableFromCSV(this.conn,
                        "./test.txt");
            }
            if (!tableNames.contains(SongTable.TableName))
            {
                // Create the conferences table.
                SongTable.createSongTable(this.conn);
                SongTable.populateSongTableFromCSV(this.conn,
                        "./test.txt");
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
    }

    /**
     * Gets a list of names of the tables that are present in the database.
     * @return ArrayList of Strings containing the names of the tables in the database.
     */
    public ArrayList<String> getTablesFromDatabase()
    {
        // Create a new array list to store the results in.
        ArrayList<String> tableNames = new ArrayList<String>();

        try
        {
            // Get a list of tables that already exist in the database.
            Statement tableExistsStatement = this.conn.createStatement();
            ResultSet tableResults = tableExistsStatement.executeQuery("show tables");

            // Loop through all the results in the result set and add each one to the list.
            while (tableResults.next() == true)
                tableNames.add(tableResults.getString("TABLE_NAME").toLowerCase());

            // Close the SQL objects.
            tableResults.close();
            tableExistsStatement.close();
        }
        catch (SQLException e)
        {
            // Print a message that we failed to get the table names.
            System.out.println("MusicDB::getTablesFromDatabase(): failed to get table names from database!");
        }

        // Return the list of tables.
        return tableNames;
    }
}
