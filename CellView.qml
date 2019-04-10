import QtQuick 2.12
import QtQuick.Window 2.11
import App.Class 0.1 as Class
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

GridLayout {
    id: root
    property Class.TableModel model
    rows: 2
    columns: 2
    // 1
    Rectangle {
        id: corner
        width: rowHeader.width
        height:columnHeader.height
        color: "#EEEDA1"
    }
    ResizableColumnHeader {             // COLUMN HEADER
        id: columnHeader
        Layout.fillWidth: true
        height:30
        spacing: 1
        model: root.model.columnNames
        contentX: table.contentX
        interactive: false
        defaultWidth: 100
        onColumnWidthChanged: table.forceLayout()
    }
    // 2
    ListView {                          // ROW HEADER
        id: rowHeader
        Layout.fillHeight:  true
        width: 100
        spacing: 1
        clip:true
        model: root.model.rowNames
        delegate: CellDelegate { text: "<b>"+modelData+"</b>"; color:"#eec" }
        contentY:  table.contentY
        interactive: false
    }
    TableView {
        id: table
        Layout.fillWidth: true
        Layout.fillHeight: true
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        columnWidthProvider: columnHeader.columnWidthProvider
        rowHeightProvider: function (column) { return  30 }
        model:root.model
        delegate: CellDelegate {
            id:cell
            text : cellData
            onClicked: inPlaceEditor.edit(cell, function onAccepted(value) {cellData = value})
        }
        ScrollBar.horizontal: ScrollBar { orientation: Qt.Horizontal }
        ScrollBar.vertical: ScrollBar { }
        CellEditor {id: inPlaceEditor;  z:10 }
    }
}
