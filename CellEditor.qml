import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1
import App.Class 0.1 as Class
import "Global.js" as Global

Loader {
    id: loader
    property var acceptCallBack : undefined
    property int type : Class.MetaType.UnknownType
    property var value : ""
    property var cell : undefined
    visible: focus
    sourceComponent: {
        switch(type) {
//            case Class.MetaType.QColor:     return colorDelegate
//            case Class.MetaType.QString:    return textDelegate
//            case Class.MetaType.Bool:       return boolDelegate
//            case Class.MetaType.Double:     return numberDelegate
//            case Class.MetaType.Int:        return numberDelegate
            case Class.MetaType.QColor:     return colorEditor
            default:                        return textEditor
        }
    }
    Keys.onEscapePressed:   abortEdit()

    function edit(cellItem, cellType, onAccepted) {
        if (!enabled ) return
        if (visible) hide()
        if (typeof onAccepted === "function")   loader.acceptCallBack = onAccepted
        else                                    console.log("[ERROR] CellEditor::edit(cell, onAccepted) onAccepted is not a function!!")
        value = cellItem.value
        type = cellType
        cell = cellItem
        switch(type) {
            case    Class.MetaType.QColor:
                break
            default:    cloneCellGeometry()
        }
        forceActiveFocus()
    }
    function cloneCellGeometry() {
        x = cell.x
        y = cell.y
        width = cell.width
        height = cell.height
    }
    function abortEdit() {
        focus = false
    }
    Component {
        id: textEditor
        TextField {
            background: Rectangle { color:"#FFECB3" }
            focus: loader.focus
            text: loader.value
            padding: 0
            leftInset: 0
            leftPadding: 0
            onAccepted: {
                acceptCallBack(text)
                hide()
            }
        }
    }
    Component {
        id: colorEditor
        ColorDialog {
            id: colorEdit
            visible: loader.visible
            //currentColor: root.value
            modality: Qt.ApplicationModal
            parentWindow: Global.mainWindow
            Binding {   // BIND loader.value-->currentColor only for compatible types
                target: colorEdit
                property: "currentColor"
                value: loader.value
                when: loader.sourceComponent === colorEditor
            }
            onAccepted: {
                acceptCallBack(color)
                hide()
            }
            onRejected: hide()
        }
    }
    function hide() {
        focus = false
    }
}

