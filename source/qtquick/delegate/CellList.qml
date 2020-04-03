import QtQuick 2.14
import QtQuick.Controls 2.14

//Item {
//    id: root
//    property alias model : cbox.model
//    property var value
//    property bool readOnly
//    property var onAccepted : undefined
CellBase {
    id: root
    objectName: "!"
    contentItem: ComboBox {
        enabled: !readOnly
        model: option.values
        editable: false
        currentIndex: model.indexOf(value)
        //onCurrentIndexChanged: root.onAccepted(model[currentIndex])
        onActivated: root.onAccepted(model[index])
    }
}
//}
