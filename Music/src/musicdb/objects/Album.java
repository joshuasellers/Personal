package musicdb.objects;

import java.time.Year;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * Created by joshuasellers on 6/5/17.
 */
public class Album {
    private final SimpleStringProperty album_id;
    private final SimpleStringProperty name;
    private final SimpleIntegerProperty track_count;
    private final SimpleStringProperty artist_id;
    private final Year year;

    public Album(SimpleStringProperty album_id, SimpleStringProperty name,
                 SimpleIntegerProperty track_count,
                 SimpleStringProperty artist_id, Year year){
        // Initialize based on input
        this.album_id = album_id;
        this.artist_id = artist_id;
        this.name = name;
        this.year = year;
        this.track_count = track_count;
    }

    public Album(String[] split){
        // Initialize based on array
        this.album_id = new SimpleStringProperty(split[3]);
        this.artist_id = new SimpleStringProperty(split[1]);
        this.name = new SimpleStringProperty(split[3]);
        this.year = Year.parse(split[12]);
        this.track_count = new SimpleIntegerProperty(Integer.getInteger(split[11]));
    }

    public Album(ResultSet rowData) throws SQLException
    {
        // Initialize fields based on the row data
        this.album_id = new SimpleStringProperty(rowData.getString(1));
        this.artist_id  = new SimpleStringProperty(rowData.getString(2));
        this.name = new SimpleStringProperty(rowData.getString(3));
        this.year = Year.parse(rowData.getString(4));
        this.track_count = new SimpleIntegerProperty(rowData.getInt(5));
    }

    public String getAlbum_ID(){return this.album_id.get();}
    public String getArtist_ID(){return this.artist_id.get();}
    public String getName(){return this.name.get();}
    public Year getYear(){return this.year;}
    public int getTrack_Count(){return this.track_count.get();}
}
