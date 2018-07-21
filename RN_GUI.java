/**
 * Created by joshuasellers on 7/15/18.
 */

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.HPos;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.geometry.VPos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.ColumnConstraints;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
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
        /*
        Button btn = new Button("Sign in");
        HBox hbBtn = new HBox(10);
        hbBtn.setAlignment(Pos.BOTTOM_RIGHT);
        hbBtn.getChildren().add(btn);
        grid.add(hbBtn, 1, 9);

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
