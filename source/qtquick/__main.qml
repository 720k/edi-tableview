import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import App.Class 0.1 as Class
import "delegate"
Window {
    id: root
    visible: true
    width: 800
    height: 500
    minimumWidth: 300
    minimumHeight: 200
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
            model:  tableModel
            delegate: CellText {
                value: model.cellData
                readOnly: true
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
            Item { Layout.fillHeight: true } // VerticalStretch
        }
    }

    Class.TableModel {
        id: tableModel
    }

}
