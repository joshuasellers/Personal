package musicdb.objects;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * Created by joshuasellers on 6/5/17.
 */
public class Genre {
    private final SimpleStringProperty name;

    public Genre(SimpleStringProperty name, SimpleIntegerProperty genre_index){
        // Initialize based on input
        this.name = name;
    }

    public Genre(String[] data)
    {
        // Initialize based on array
        this.name = new SimpleStringProperty(data[5]);
    }

    public Genre(ResultSet rowData) throws SQLException
    {
        // Initialize fields based on the row data
        this.name = new SimpleStringProperty(rowData.getString(1));
    }

    public String getName() { return name.get(); }
}
