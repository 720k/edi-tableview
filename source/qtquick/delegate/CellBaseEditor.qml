import QtQuick 2.14
import QtQuick.Controls 2.14

Control {
    id: root
    property var cell : undefined
    anchors.fill:parent
    visible:  false

    function activate() {
        if (typeof cell.onAccepted !== "function")    console.log("[ERROR] cell.onAccepted is not a function!!")
        if (!enabled ) return
        visible = true
        contentItem.forceActiveFocus()
    }

    function cloneCellGeometry() {
        x = cell.x
        y = cell.y
        width = cell.width
        height = cell.height
    }
    function cancelEdit() {
        root.destroy()
    }
    function hide() {
        root.destroy()
    }
    onCellChanged: parent = cell;
}
