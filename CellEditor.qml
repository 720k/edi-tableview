import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

TextField {
    id:root
    property var acceptCallBack : undefined
    visible: false
    background: Rectangle { color:"#FFECB3" }
    onFocusChanged:         visible=focus
    Keys.onEscapePressed:   focus = false
    onAccepted: {
        acceptCallBack(text)
        focus = false
    }

    function edit(cell, onAccepted) {
        if (typeof onAccepted === "function")   root.acceptCallBack = onAccepted
        else                                    console.log("[ERROR] CellEditor::edit(cell, onAccepted) onAccepted is not a function!!")
        x = cell.x
        y = cell.y
        width = cell.width
        height = cell.height
        text = cell.text
        forceActiveFocus()
    }
}
