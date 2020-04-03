import QtQuick 2.14
import QtQuick.Controls 2.14

CellBase {
    objectName: "!"
    contentItem: Switch {
        enabled: !readOnly
        checked: value
        checkable: true
        onClicked: onAccepted(checked)
    }
}
