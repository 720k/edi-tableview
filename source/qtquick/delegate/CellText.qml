import QtQuick 2.4
CellBase {
    contentItem: Text {
        text: value
        clip: true
        horizontalAlignment:  Text.AlignHCenter
        verticalAlignment:    Text.AlignVCenter
        elide: Text.ElideRight
    }
    editor: "CellTextEditor.qml"
}
