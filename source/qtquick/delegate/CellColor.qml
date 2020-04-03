import QtQuick 2.14
CellBase {
    id: root
    contentItem: Rectangle {
        color: value
        anchors {
            fill: parent
            topMargin: 2
            bottomMargin: 2
            leftMargin: 10
            rightMargin: 10
        }
        border.color: root.readOnly ? "#bbb" : "black"
        border.width: 2
    }
    editor: "CellColorEditor.qml"
}
