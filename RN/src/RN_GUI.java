/**
 * Created by joshuasellers on 7/15/18.
 */

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.*;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.ColumnConstraints;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import javafx.stage.Stage;


public class RN_GUI extends Application {
    private RNMain backend = new RNMain();
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        // Title /////////////////////////////////////////////
        primaryStage.setTitle("Roman Numeral Calculator"); //
        /////////////////////////////////////////////////////

        // GridPane ////////////////////////////////////
        GridPane grid = new GridPane();
        grid.setAlignment(Pos.TOP_LEFT);
        grid.setHgap(5);
        grid.setVgap(5);
        grid.setPadding(new Insets(10, 10, 10, 10));
        ColumnConstraints column1 = new ColumnConstraints();
        column1.setPercentWidth(20);
        ColumnConstraints column2 = new ColumnConstraints();
        column2.setPercentWidth(20);
        ColumnConstraints column3 = new ColumnConstraints();
        column3.setPercentWidth(20);
        ColumnConstraints column4 = new ColumnConstraints();
        column4.setPercentWidth(20);
        ColumnConstraints column5 = new ColumnConstraints();
        column5.setPercentWidth(20);
        grid.getColumnConstraints().addAll(column1, column2, column3, column4, column5);
        Scene scene = new Scene(grid, 500, 375);
        grid.setStyle("-fx-background-color: #C0C0C0;");
        primaryStage.setScene(scene);
        //grid.setGridLinesVisible(true);
        ////////////////////////////////////////////////



        // Example Interface //
        Label scenetitle = new Label("XVI-84 Plus");
        scenetitle.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        grid.add(scenetitle, 0, 0);
        grid.setColumnSpan(scenetitle,GridPane.REMAINING);
        GridPane.setHalignment(scenetitle, HPos.CENTER);

        final Separator sepHor1 = new Separator();
        sepHor1.setValignment(VPos.CENTER);
        GridPane.setConstraints(sepHor1, 0, 1);
        GridPane.setColumnSpan(sepHor1, GridPane.REMAINING);
        grid.getChildren().add(sepHor1);

        Label eqn = new Label("Enter Equation:");
        eqn.setFont(Font.font("Tahoma",FontWeight.NORMAL,20));
        grid.setColumnSpan(eqn,2);
        grid.add(eqn, 0, 2);
        GridPane.setHalignment(eqn, HPos.CENTER);

        TextField userTextField = new TextField();
        grid.setColumnSpan(userTextField,GridPane.REMAINING);
        grid.add(userTextField, 2, 2);

        final Separator sepHor2 = new Separator();
        sepHor2.setValignment(VPos.CENTER);
        GridPane.setConstraints(sepHor2, 0, 3);
        GridPane.setColumnSpan(sepHor2, GridPane.REMAINING);
        grid.getChildren().add(sepHor2);

        HBox hBox = new HBox(10);
        hBox.setPrefWidth(90);

        VBox vBox = new VBox(10);
        vBox.setPrefWidth(80);
        Button btnq = new Button("(");
        btnq.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btnw = new Button(")");
        btnw.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        btnq.setMinWidth(vBox.getPrefWidth());
        btnw.setMinWidth(vBox.getPrefWidth());
        vBox.getChildren().addAll(btnq,btnw);

        VBox vBox1 = new VBox(10);
        vBox1.setPrefWidth(90);
        Button btn1 = new Button("+");
        btn1.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btn2 = new Button("-");
        btn2.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btn3 = new Button("*");
        btn3.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btn4 = new Button("/");
        btn4.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        btn1.setMinWidth(vBox1.getPrefWidth());
        btn2.setMinWidth(vBox1.getPrefWidth());
        btn3.setMinWidth(vBox1.getPrefWidth());
        btn4.setMinWidth(vBox1.getPrefWidth());
        vBox1.getChildren().addAll(btn1,btn2,btn3,btn4);

        vBox.setMinWidth(hBox.getPrefWidth());
        vBox1.setMinWidth(hBox.getPrefWidth());
        hBox.getChildren().addAll(vBox1,vBox);
        grid.add(hBox,0,4);
        //GridPane.setHalignment(hBox, HPos.RIGHT);

        HBox hBox1 = new HBox(10);
        hBox1.setPrefWidth(100);

        VBox vBox2 = new VBox(10);
        vBox2.setPrefWidth(90);
        Button btna = new Button("I");
        btna.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btnb = new Button("V");
        btnb.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btnc = new Button("X");
        btnc.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btnd = new Button("L");
        btnd.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        btna.setMinWidth(vBox2.getPrefWidth());
        btnb.setMinWidth(vBox2.getPrefWidth());
        btnc.setMinWidth(vBox2.getPrefWidth());
        btnd.setMinWidth(vBox2.getPrefWidth());
        vBox2.getChildren().addAll(btna,btnb,btnc,btnd);

        VBox vBox3 = new VBox(10);
        vBox3.setPrefWidth(90);
        Button btni = new Button("C");
        btni.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btnj = new Button("D");
        btnj.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        Button btnk = new Button("M");
        btnk.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        btni.setMinWidth(vBox2.getPrefWidth());
        btnj.setMinWidth(vBox2.getPrefWidth());
        btnk.setMinWidth(vBox2.getPrefWidth());
        vBox3.getChildren().addAll(btni,btnj,btnk);

        vBox2.setMinWidth(hBox1.getPrefWidth());
        vBox3.setMinWidth(hBox1.getPrefWidth());
        hBox1.getChildren().addAll(vBox2,vBox3);
        grid.add(hBox1,3,4);
        GridPane.setHalignment(hBox1, HPos.CENTER);

        Separator sep = new Separator();
        sep.setOrientation(Orientation.VERTICAL);
        sep.setValignment(VPos.CENTER);
        GridPane.setConstraints(sep, 2, 4);
        grid.getChildren().add(sep);

        final Separator sepHor3 = new Separator();
        sepHor3.setValignment(VPos.TOP);
        GridPane.setConstraints(sepHor3, 0, 9);
        GridPane.setColumnSpan(sepHor3, GridPane.REMAINING);
        grid.getChildren().add(sepHor3);

        Button eq = new Button("=");
        eq.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        grid.setColumnSpan(eq,GridPane.REMAINING);
        grid.add(eq,0,10);
        GridPane.setHalignment(eq, HPos.CENTER);
        /*

        final Text actiontarget = new Text();
        grid.add(actiontarget, 0, 6);
        grid.setColumnSpan(actiontarget, 2);
        grid.setHalignment(actiontarget, HPos.RIGHT);
        actiontarget.setId("actiontarget");

        btn.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent e) {
                actiontarget.setFill(Color.FIREBRICK);
                actiontarget.setText("Sign in button pressed");
            }
        });
        */
        // Display /////////////
        primaryStage.show(); //
        ///////////////////////
    }
}
