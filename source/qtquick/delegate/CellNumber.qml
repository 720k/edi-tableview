import QtQuick 2.14
CellBase {
    contentItem:  Text {
        text : value
        clip: true
        horizontalAlignment:  Text.AlignRight
        verticalAlignment:    Text.AlignVCenter
        color: "#2E7D32"
        elide: Text.ElideLeft
        rightPadding: 2
    }
    editor: "CellNumberEditor.qml"
}

