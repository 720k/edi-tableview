import QtQuick 2.14
import App.Class 0.1 as Class
import Qt.labs.qmlmodels 1.0

DelegateChooser {
//    id: chooser
//    role: "cellEditor"
    DelegateChoice {
        roleValue: Class.Property.PathEditor
        CellText {
            value: model.cellData
            type: model.cellType
            option: model.cellOption
            flags: model.cellFlags
            readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
            editor: 'CellPathEditor.qml'
        }
    }
    DelegateChoice {
        roleValue: Class.Property.ListEditor
        CellList {
            value: model.cellData
            type: model.cellType
            option: model.cellOption
            flags: model.cellFlags
            readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
        }
    }
    DelegateChoice {
        roleValue: Class.Property.ColorEditor
        CellColor {
            value: model.cellData
            type: model.cellType
            option: model.cellOption
            flags: model.cellFlags
            readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
        }
    }
    DelegateChoice {
        roleValue: Class.Property.TextEditor
        CellText {
            value: model.cellData
            type: model.cellType
            option: model.cellOption
            flags: model.cellFlags
            readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
        }
    }
    DelegateChoice {
        roleValue: Class.Property.BoolEditor
        CellBool {
            value: model.cellData
            type: model.cellType
            option: model.cellOption
            flags: model.cellFlags
            readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
        }
    }
    DelegateChoice {
        roleValue: Class.Property.NumberEditor
        CellNumber {
            value: model.cellData
            type: model.cellType
            option: model.cellOption
            flags: model.cellFlags
            readOnly: root.interactive ? cellFlags & Class.Property.ReadOnly : true
        }
    }
}
