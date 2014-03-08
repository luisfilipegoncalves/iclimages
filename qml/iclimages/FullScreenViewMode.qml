import QtQuick 2.0

Item {
    property variant mymodel
    property Component myComponent: fullscreenComponent
    property int currentImageIndex: 0
    signal exitFullscreen(int imageIndex)
    signal selectedImageChanged(int imageIndex)

    Component {
        id: fullscreenComponent

        Rectangle {
            Component.onCompleted:
            {
                console.log("Create Fullscreen view. currentImageIndex: " + currentImageIndex)
                horizontalView.currentIndex = currentImageIndex
            }

            Component.onDestruction: console.log("Destroy Fullscreen view")

            id: rectFullscreen
            color: "#1b1b1b"

            Rectangle {
                id: toolbar
                height: 50
                width: parent.width
                //color: transparent
                gradient: Gradient {
                    GradientStop {
                        position: 0.07;
                        color: "#434343";
                    }
                    GradientStop {
                        position: 1.00;
                        color: "#353535";
                    }
                }

                Image {
                    source: "qrc:/images/backButton"
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    fillMode: Image.PreserveAspectFit

                    Text {
                        id: name
                        text: qsTr("Back")
                        font.family: "Helvetica"
                        font.bold: true
                        font.pixelSize: 12
                        anchors.fill: parent
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: exitFullscreen(horizontalView.currentIndex)
                    }
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter


                    Image {
                        id: backImg
                        source: "qrc:/images/back"
                        height: 30
                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("back")
                                horizontalView.decrementCurrentIndex()
                            }
                        }
                    }

                    Image {
                        id: forwImg
                        source: "qrc:/images/forward"
                        height: 30
                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("forward")
                                horizontalView.incrementCurrentIndex()
                            }
                        }
                    }
                }


            }

            Image {
                id: imageFullscreen
                anchors.left: parent.left
                anchors.top: toolbar.bottom
                anchors.bottom: horizontalView.top
                anchors.right: parent.right
                anchors.margins: 10
                asynchronous: true
                fillMode: Image.PreserveAspectFit
            }

            ListView {
                id: horizontalView
                height: 80
                width: parent.width
                anchors.bottom: rectFullscreen.bottom
                model: mymodel
                delegate: listImageDelegate
                orientation: ListView.Horizontal

                highlight: Rectangle {
                    color: "yellow"
                }

                focus: true

                onCurrentIndexChanged: {
                    console.log("vertical current index: " + currentIndex)
                    console.log("vertical current item: " + currentItem )
                    imageFullscreen.source = imagesModel.getImage(currentIndex)
                    selectedImageChanged(currentIndex)
                }
                clip: true
            }

            Component {
                id: listImageDelegate
                Rectangle
                {
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
                            horizontalView.currentIndex = index
                        }
                    }

                }
            }
        }
    }
}
