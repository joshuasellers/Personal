package musicdb.objects;

import java.time.Year;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * Created by joshuasellers on 6/5/17.
 */
public class Artist {
    private final String artist_name;
    private final Integer artist_index;

    public Artist( String name, Integer index){
        // Initialize based on input
        this.artist_index = index;
        this.artist_name = name;
    }

    public Artist(String[] split){
        // Initialize based on array
        this.artist_index = Integer.parseInt(split[26]);
        this.artist_name = split[1];
    }

    public String getName(){return this.artist_name;}
    public Integer getIndex(){return this.artist_index;}
}
