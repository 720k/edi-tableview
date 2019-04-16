import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
ListView {
    id:root
    property var len : [200,200]
    property var count : root.model.length
    property int defaultWidth : 100
    signal  columnWidthChanged

    orientation: ListView.Horizontal
    clip: true
    delegate: HeaderDelegate {
        id: thedelegate
        width: root.len[index]
        height: root.height
        color:"#eec"
        text: "<b>"+modelData+"</b>"
        Rectangle {
            id: handle
            color: Qt.darker(parent.color, 1.05)
            height: parent.height
            width: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                id: mouseHandle
                anchors.fill: parent
                drag{ target: parent; axis: Drag.XAxis }
                hoverEnabled: true
                cursorShape: Qt.SizeHorCursor
                onMouseXChanged: {
                    if (drag.active) {
                        var newWidth = thedelegate.width + mouseX
                        if (newWidth >= 50) {
                            thedelegate.width = newWidth
                            root.len[index] = newWidth
                            root.columnWidthChanged()
                        }
                    }
                }
            }
        }
    }
    onCountChanged:        modelCountChanged()
//    Component.onCompleted: resetColumns()

    function columnWidthProvider(column) {
        return len[column]
    }
    function resetColumns() {
        len=[]
        for (var i=0; i<count; i++) len.push(defaultWidth)
    }
    function modelCountChanged() {
        resetColumns()
        root.columnWidthChanged()
    }
}
