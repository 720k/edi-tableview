import QtQuick 2.12
import QtQuick.Window 2.11
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import App.Class 0.1 as Class

GridLayout {
    id: root
    property Class.TableModel model
    property bool   readOnly : false
    property bool   interactive : true
    property alias  delegate : table.delegate
    rows: 2
    columns: 2
    // 1
    Rectangle {
        id: corner
        width: rowHeader.width
        height:columnHeader.height
        color: "#EEEDA1"
        visible: model.count
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
        width: 50
        spacing: 1
        clip:true
        model: root.model.rowNames
        delegate: HeaderDelegate { width: rowHeader.width; text: modelData; horizontalAlignment: Text.AlignRight }
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
        delegate: CellDisplay {
            id:cell
            value: model.cellData
            type: model.cellType
            readOnly: root.interactive ? cellFlags & Class.Variable.ReadOnly : true
            hasDomain: cellFlags & Class.Variable.DomainList
            domain: model.cellDomain
            onClicked: if (!readOnly) inPlaceEditor.edit(cell, model.cellType, onAccepted)
            function onAccepted(value) { model.cellData = value}
        }
        ScrollBar.horizontal: ScrollBar { orientation: Qt.Horizontal }
        ScrollBar.vertical: ScrollBar { }
        CellEditor {
          id: inPlaceEditor
          z:10
          enabled: !root.readOnly
        }
    }
}
