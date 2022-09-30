module com.example.battleship_gui {
    requires javafx.controls;
    requires javafx.fxml;

    requires com.dlsc.formsfx;

    opens com.example.battleship_gui to javafx.fxml;
    exports com.example.battleship_gui;
}