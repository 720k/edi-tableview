import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle {
    property alias text : label.text
    property alias textColor: label.color
    property alias horizontalAlignment: label.horizontalAlignment
    implicitWidth: 100
    implicitHeight: 30
    color:"#eec"
    Text {
        id: label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        rightPadding: 5
        leftPadding: 5
        font.bold: true
    }
}
