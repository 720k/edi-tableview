import QtQuick 2.14
import QtQuick.Controls 2.14
import App.Class 0.1 as Class
import "CellBase.js" as Js
Control {
    id: root
    // from model
    property var value
    property int type : Class.MetaType.UnknownType
    property var flags
    property int editorType
    property var option
    // local
    property bool readOnly : false
    property bool hasDomain : flags & Class.Property.DomainList
    property string editor
    implicitWidth: 100
    implicitHeight: 30

    background : CellBackground { }
    MouseArea {
        id: clickarea
        anchors.fill: parent
        onClicked: if (!readOnly) edit()
        visible: root.objectName !== "!"
    }
    function onAccepted(value) {
        model.cellData = value
    }
    function edit() {
        Js.createEditor(this);
    }
}
