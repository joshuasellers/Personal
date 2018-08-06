package musicdb.objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Year;
import java.util.Date;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

/**
 * Created by joshuasellers on 6/5/17.
 */
public class Song {
    private final SimpleIntegerProperty song_id;
    private final SimpleStringProperty name;
    private final SimpleStringProperty artist_id;
    private final SimpleStringProperty album_id;
    private final SimpleStringProperty genre_id;
    private final SimpleIntegerProperty time;
    private final SimpleIntegerProperty disc_num;
    private final SimpleIntegerProperty track_num;
    private final Year year;
    private final SimpleStringProperty date_added;
    private SimpleStringProperty comment;
    private final SimpleIntegerProperty plays;
    private final SimpleStringProperty last_played;
    private final SimpleIntegerProperty skips;
    private final SimpleStringProperty last_skipped;
    private SimpleIntegerProperty rating;



    public Song(SimpleIntegerProperty song_id, SimpleStringProperty name,
                SimpleStringProperty artist_id, SimpleStringProperty album_id,
                SimpleStringProperty genre_id, SimpleIntegerProperty time,
                SimpleIntegerProperty disc_num, SimpleIntegerProperty track_num,
                Year year, SimpleStringProperty date_added, SimpleStringProperty comment,
                SimpleIntegerProperty plays, SimpleStringProperty last_played,
                SimpleIntegerProperty skips, SimpleStringProperty last_skipped,
                SimpleIntegerProperty rating){
        // Initialize based on input
        this.song_id = song_id;
        this.name = name;
        this.artist_id = artist_id;
        this.album_id = album_id;
        this.genre_id = genre_id;
        this.time = time;
        this.disc_num = disc_num;
        this.track_num = track_num;
        this.year = year;
        this.date_added = date_added;
        this.comment = comment;
        this.plays = plays;
        this.last_played = last_played;
        this.skips = skips;
        this.last_skipped = last_skipped;
        this.rating = rating;
    }

    public Song(String[] split){
        // Initialize based on array
        this.song_id = new SimpleIntegerProperty(Integer.getInteger(split[26]));
        this.name = new SimpleStringProperty(split[0]);
        this.artist_id = new SimpleStringProperty(split[1]);
        this.album_id = new SimpleStringProperty(split[3]);
        this.genre_id = new SimpleStringProperty(split[5]);
        this.time = new SimpleIntegerProperty(Integer.getInteger(split[7]));
        this.disc_num = new SimpleIntegerProperty(Integer.getInteger(split[8]));
        this.track_num = new SimpleIntegerProperty(Integer.getInteger(split[10]));
        this.year = Year.parse(split[12]);
        this.date_added = new SimpleStringProperty(split[14]);
        this.comment = new SimpleStringProperty(" ");
        this.plays = new SimpleIntegerProperty(Integer.getInteger(split[21]));
        this.last_played = new SimpleStringProperty(split[22]);
        this.skips = new SimpleIntegerProperty(Integer.getInteger(split[23]));
        this.last_skipped = new SimpleStringProperty(split[24]);
        this.rating = new SimpleIntegerProperty(1);
    }

    public Song(ResultSet rowData) throws SQLException
    {
        // Initialize fields based on the row data
        this.song_id = new SimpleIntegerProperty(rowData.getInt(1));
        this.name = new SimpleStringProperty(rowData.getString(2));
        this.artist_id = new SimpleStringProperty(rowData.getString(3));
        this.album_id = new SimpleStringProperty(rowData.getString(4));
        this.genre_id = new SimpleStringProperty(rowData.getString(5));
        this.time = new SimpleIntegerProperty(rowData.getInt(6));
        this.disc_num = new SimpleIntegerProperty(rowData.getInt(7));
        this.track_num = new SimpleIntegerProperty(rowData.getInt(8));
        this.year = Year.parse(rowData.getString(9));
        this.date_added = new SimpleStringProperty(rowData.getString(10));
        this.comment = new SimpleStringProperty(rowData.getString(11));
        this.plays = new SimpleIntegerProperty(rowData.getInt(12));
        this.last_played = new SimpleStringProperty(rowData.getString(13));
        this.skips = new SimpleIntegerProperty(rowData.getInt(14));
        this.last_skipped = new SimpleStringProperty(rowData.getString(15));
        this.rating = new SimpleIntegerProperty(rowData.getInt(16));
    }

    public int getSong_ID(){ return this.song_id.get();}
    public String getName(){return this.name.get();}
    public String getArtist_ID(){return this.artist_id.get();}
    public String getAlbum_ID(){return this.album_id.get();}
    public String getGenre_ID(){return this.artist_id.get();}
    public int getTime(){return this.time.get();}
    public int getDisc_Num(){return this.disc_num.get();}
    public int getTrack_Num(){return this.track_num.get();}
    public Year getYear(){return this.year;}
    public String getDate_Added(){return this.date_added.get();}
    public String getComment(){return this.comment.get();}
    public int getPlays(){return this.plays.get();}
    public String getLast_Played(){return this.last_played.get();}
    public int getSkips(){return this.skips.get();}
    public String getLast_Skipped(){return this.last_skipped.get();}
    public int getRating(){return this.rating.get();}
}
