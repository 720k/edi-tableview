import QtQuick 2.14
import QtQuick.Controls 2.14
import App.Class 0.1 as Class

CellTextEditor {
    IntValidator    { id: intValidator }
    DoubleValidator { id: doubleValidator }

    Component.onCompleted:  {
        if (cell.option.hasOwnProperty("min")) {
            console.log("["+cell.option.min+" .. "+cell.option.max+"]")
            if (cell.type === Class.MetaType.Int)       setInt(cell.option.min, cell.option.max)
            if (cell.type === Class.MetaType.Double)    setDouble(cell.option.min, cell.option.max)
        }
    }
    function setInt(min,max) {
        intValidator.bottom = min
        intValidator.top = max
        contentItem.validator=intValidator
    }
    function setDouble(min,max) {
        doubleValidator.bottom = min
        doubleValidator.top = max
        doubleValidator.decimals=3
        contentItem.validator = doubleValidator
    }
}
