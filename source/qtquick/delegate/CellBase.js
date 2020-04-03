var component
var editor
var parent

function createEditor(owner) {
    parent= owner
    if (!parent.editor) return;
    component = Qt.createComponent(parent.editor);
    if (component.status === Component.Ready)   finishCreation();
    else                                        component.statusChanged.connect(finishCreation)
}

function finishCreation() {
    if (component.status === Component.Ready) {
        editor = component.createObject(parent, { cell: parent })
        if (editor === null)    console.log("Error creating object")
        else                    editor.activate()
    } else if (component.status === Component.Error) {
        console.log("Error loading component:", component.errorString()) // Error Handling
    }
}
