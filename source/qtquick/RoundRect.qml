import QtQuick 2.12

Rectangle {
    id: root
    radius: 5
    property bool topLeftCorner: false
    property bool topRightCorner: false
    property bool bottomLeftCorner: false
    property bool bottomRightCorner: false
    Rectangle {
        color: parent.color
        visible:!parent.topLeftCorner
        width: parent.radius
        height: parent.radius
        anchors.top : parent.top
        anchors.left: parent.left
    }
    Rectangle {
        color: parent.color
        visible:!parent.topRightCorner
        width: parent.radius
        height: parent.radius
        anchors.top : parent.top
        anchors.right: parent.right
    }
    Rectangle {
        color: parent.color
        visible:!parent.bottomLeftCorner
        width: parent.radius
        height: parent.radius
        anchors.bottom : parent.bottom
        anchors.left: parent.left
    }
    Rectangle {
        color: parent.color
        visible:!parent.bottomRightCorner
        width: parent.radius
        height: parent.radius
        anchors.bottom : parent.bottom
        anchors.right: parent.right
    }
}
