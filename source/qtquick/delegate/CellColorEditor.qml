import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Dialogs 1.2

ColorDialog {
    id: colorEdit
    property var cell : undefined
    title: "Please choose a color"
    visible: true
    currentColor: cell.value
    modality: Qt.ApplicationModal
    onAccepted: {
        if (typeof cell.onAccepted !== "function")    {
            console.log("[ERROR] cell.onAccepted is not a function!!")
            return
        }
        cell.onAccepted(color)
        destroy()
    }
    onRejected: destroy()
    function activate() {
        show()
    }
}
