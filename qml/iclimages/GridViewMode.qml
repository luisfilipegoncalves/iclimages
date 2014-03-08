import QtQuick 2.0

Item {
    id: gridItem
    property variant mymodel
    property Component myComponent: gridComponent

    signal showFullScreenImage(int imageIndex)
    signal selectedImageChanged(int imageIndex)


    Component {
        id: gridComponent

        Rectangle {
            color: "transparent"

            Component.onCompleted: {
                console.log("Create grid view!")
                gridView.focus = true
            }
            Component.onDestruction: console.log("destroyed grid view!")

            GridView {
                id: gridView
                cellWidth: 80
                cellHeight: 80
                anchors.fill: parent
                focus: true

                model: mymodel
                delegate: Rectangle {
                    id: rectI
                    width: 80
                    height: 80
                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        anchors.margins: 2
                        id: img
                        cache: true
                        source: filePath
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                        sourceSize.width: parent.width - 2
                        sourceSize.height: parent.height -2

                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("clicked on index: " + index + filePath)
                            gridView.currentIndex = index
                            selectedImageChanged(index)
                        }

                        onDoubleClicked: {
                            console.log("double clicked index: " + index)
                            showFullScreenImage(index)
                        }
                    }
                }

                highlight: Rectangle {
                    color: "red"
                }

            }
        }
    }
}

/*Component {
    id: gridComponent

    GridView {
        id: gridView
        cellWidth: 80
        cellHeight: 80

        model: imagesModel
        delegate: gridImageDelegate
        highlight: Rectangle {
            color: "red"
        }
        focus: true

        onCurrentItemChanged: {
            console.log("current index: " + currentIndex + "current item: " + currentItem)
        }

        Component.onCompleted: console.log("Created Grid View")
        Component.onDestruction: console.log("Destroyed Grid View")

    }

    Component {
        id: gridImageDelegate
        Rectangle
        {
            id: rectI
            width: 80
            height: 80
            color: "transparent"

            Image {
                anchors.fill: parent
                anchors.margins: 2
                id: img
                cache: true
                source: filePath
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
                sourceSize.width: parent.width - 2
                sourceSize.height: parent.height -2

            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked on index: " + index + filePath)
                    gridView.currentIndex = index
                }

                onDoubleClicked: {
                    console.log("double clicked")
                    rectFullscreen.enabled = true
                    rectFullscreen.visible = true
                    horizontalView.currentIndex = gridView.currentIndex
                    imageFullscreen.source = filePath
                }
            }
        }
    }

}
*/
