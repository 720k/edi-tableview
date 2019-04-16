import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import App.Class 0.1 as Class
import "Global.js" as Global

Window {
    id: root
    visible: true
    width: 640
    height: 400
    title: "EDI-TABLEVIEW"
    color: "#aaa"
    RowLayout {
        anchors.fill: parent
        spacing: 5
        CellView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            model:  tableModel
        }
        CellView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            model:  tableModel
            delegate: CellDisplayText {
                value: model.cellData
            }
        }
        ColumnLayout {
            Layout.fillHeight: true
            Button {
                text: "Clear"
                onClicked: tableModel.clear()
            }
            Button {
                text: "Test data"
                onClicked: tableModel.testData()
            }
            Item { Layout.fillHeight: true }
        }
    }

    Class.TableModel {
        id: tableModel
    }
    Component.onCompleted: Global.mainWindow = root
}
