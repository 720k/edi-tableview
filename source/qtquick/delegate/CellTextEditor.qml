import QtQuick 2.14
import QtQuick.Controls 2.14

CellBaseEditor {
    id: editor
    contentItem : TextField {
        text: cell.value
        onAccepted: {
            if (typeof cell.onAccepted !== "function")    {
                console.log("[ERROR] CellTextEditor : cell.onAccepted is not a Function!!")
                return
            }
            cell.onAccepted(text)
            editor.hide()
        }
        Keys.onEscapePressed:   editor.cancelEdit()
        onFocusChanged: if (!focus) editor.cancelEdit()
    }
}
