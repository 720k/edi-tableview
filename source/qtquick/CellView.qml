import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import App.Class 0.1 as Class
import Qt.labs.qmlmodels 1.0
import "./delegate"

GridLayout {
    id: root
    property Class.TableModel model
    property int    defaultRowHeight : 30
    property int    defaultColumnWidth : 130
    property bool   readOnly : false
    property bool   interactive : true
    property alias  delegate : table.delegate

    rows: 2
    columns:2
    rowSpacing: 2
    columnSpacing: 2
    // 1
    RoundRect {
        id: corner
        width: rowHeader.width
        height:columnHeader.height
        color: "#EEEDA1" // "#eec"
        visible: model.count
        topLeftCorner: true
        radius: height / 2
    }
    ResizableColumnHeader {             // COLUMN HEADER
        id: columnHeader
        Layout.fillWidth: true
        height: root.defaultRowHeight
        defaultWidth: root.defaultColumnWidth
        spacing: 1
        model: root.model.columnNames
        contentX: table.contentX
        interactive: false
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
        delegate: HeaderDelegate {
            height: root.defaultRowHeight
            width: rowHeader.width;
            text: modelData;
            horizontalAlignment: Text.AlignRight
        }
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
        rowHeightProvider: function (column) { return  root.defaultRowHeight }
        model:root.model
        delegate: CellDelegate { role:"cellEditor" }

        ScrollBar.horizontal:   ScrollBar { orientation: Qt.Horizontal }
        ScrollBar.vertical:     ScrollBar { }

//        DelegateChooser {
//            id: chooser
//            role: "cellEditor"
//            DelegateChoice {
//                roleValue: Class.Property.PathEditor
//                CellText {
//                    value: model.cellData
//                    type: model.cellType
//                    option: model.cellOption
//                    flags: model.cellFlags
//                    readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
//                    editor: 'CellPathEditor.qml'
//                }
//            }
//            DelegateChoice {
//                roleValue: Class.Property.ListEditor
//                CellList {
//                    value: model.cellData
//                    type: model.cellType
//                    option: model.cellOption
//                    flags: model.cellFlags
//                    readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
//                }
//            }
//            DelegateChoice {
//                roleValue: Class.Property.ColorEditor
//                CellColor {
//                    value: model.cellData
//                    type: model.cellType
//                    option: model.cellOption
//                    flags: model.cellFlags
//                    readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
//                }
//            }
//            DelegateChoice {
//                roleValue: Class.Property.TextEditor
//                CellText {
//                    value: model.cellData
//                    type: model.cellType
//                    option: model.cellOption
//                    flags: model.cellFlags
//                    readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
//                }
//            }
//            DelegateChoice {
//                roleValue: Class.Property.BoolEditor
//                CellBool {
//                    value: model.cellData
//                    type: model.cellType
//                    option: model.cellOption
//                    flags: model.cellFlags
//                    readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
//                }
//            }
//            DelegateChoice {
//                roleValue: Class.Property.NumberEditor
//                CellNumber {
//                    value: model.cellData
//                    type: model.cellType
//                    option: model.cellOption
//                    flags: model.cellFlags
//                    readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
//                }
//            }
//        }
    }
}
