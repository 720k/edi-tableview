import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import Qt.labs.platform 1.1
import "../Utils.js" as Utils
CellBaseEditor {
    id: editor
    contentItem : TextField {
        id: field
        text: cell.value
        //rightPadding: height
        onAccepted: {
            if (typeof cell.onAccepted !== "function")    {
                console.log("[ERROR] CellTextEditor : cell.onAccepted is not a Function!!")
                return
            }
            cell.onAccepted(text)
            editor.hide()
        }
        Keys.onEscapePressed:   editor.cancelEdit()
        onFocusChanged: if (!focus && !button.focus) editor.cancelEdit()
        ToolButton {
            id: button
            width: parent.height
            height: parent.height
            anchors.right: parent.right
            text:"..."
            onClicked: folderDialog.openPath(field.text.toString())
        }
        Component.onCompleted: rightPadding = height // avoid binding
    }

    FolderDialog {
        id: folderDialog
        onAccepted: {
            field.text = Utils.urlToPath(folder.toString())
            field.onAccepted()
        }
        function openPath(path) {
            options = FolderDialog.ShowDirsOnly
            currentFolder = Utils.pathToUrl(field.text)
            open()
        }
    }
}
