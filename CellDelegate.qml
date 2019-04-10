import QtQuick 2.12

Rectangle {
    id: root
    property alias text : label.text
    signal clicked()
    implicitWidth: 100
    implicitHeight: 30
    color:"#eee"
    Text {
        id: label
        anchors.centerIn: parent
        clip: true
        elide: Text.ElideRight
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
