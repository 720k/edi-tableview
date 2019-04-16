import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import App.Class 0.1 as Class

Rectangle {
    id: root
    property var value
    signal clicked()
    implicitWidth: 100
    implicitHeight: 30
    color:"#eee"
    Loader {
        id: loader
        anchors.fill: parent
        anchors.margins: 1
        sourceComponent: textDelegate

    }
    MouseArea {
        id: editSurface
        anchors.fill: parent
        onClicked: root.clicked()
        enabled: loader.item.objectName !=="!"
    }
    Component {
        id: textDelegate
        Text {
            text: root.value
            clip: true
            horizontalAlignment:  Text.AlignHCenter
            verticalAlignment:    Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

}
