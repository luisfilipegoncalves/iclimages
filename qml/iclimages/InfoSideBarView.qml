import QtQuick 2.0

Rectangle {
    id: rootInfo

    property variant mymodel
    property int currentImageIndex: 0

    onCurrentImageIndexChanged: {
        console.log("current image info changed to: " + currentImageIndex)
        imageName.text = mymodel.getImageName(currentImageIndex)
        imageDate.text = mymodel.getImageDate(currentImageIndex)
        listViewTags.model = mymodel.getImageModel(currentImageIndex)
    }

    Image {
        id: pattern
        source: "qrc:/images/infobackground"
        fillMode: Image.Tile
        anchors.fill: parent
    }

    Text {
        id: imageName
        color: "white"
        font.bold: true
        font.pixelSize: 13
        elide: Text.ElideMiddle
        width: parent.width
        anchors.topMargin: 20
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: imageDate
        color: "lightgray"
        font.bold: true
        font.pixelSize: 12
        elide: Text.ElideMiddle
        width: parent.width
        anchors.topMargin: 10
        anchors.top: imageName.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
    }

    BorderImage {
        id: frameImage
        source: "qrc:/images/frame"
        width: parent.width - 20
        height: 300
        border.left: 12; border.top: 12
        border.right: 12; border.bottom: 12
        anchors.top: imageDate.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter


        Text {
            id: textTagsTitle
            text: qsTr("Tags")
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: 10
            height: 52
            font.bold: true
            font.pixelSize: 14
            color: "white"
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: borderR
            width: parent.width - 2
            height: 1
            color: "gray"
            opacity: 0.5
            anchors.top: textTagsTitle.bottom
            anchors.horizontalCenter: parent.horizontalCenter

        }

        GridView {
            id: listViewTags
            width: parent.width
            anchors.top: borderR.bottom
            anchors.topMargin: 20
            anchors.bottom: borderRectBottom.bottom
            anchors.bottomMargin: 10
            clip: true

            cellWidth: 90
            cellHeight: 40

            delegate: Item {
                width: 85
                height: 30

                Rectangle {
                    id: rct
                    width: Math.min(name.contentWidth + 20, parent.width)
                    height: 30
                    radius: width*0.5
                    border.width: 2
                    border.color: "#7f7f7f"
                    color: "#4d4d4d"
                    anchors.horizontalCenter: name.horizontalCenter
                }

                Text {
                    id: name
                    text: modelData
                    color: "white"
                    font.bold: true
                    font.pixelSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                    elide: Text.ElideRight
                    clip: true
                    width: parent.width

                }
            }
        }

        Rectangle {
            id: borderRectBottom
            width: parent.width - 2
            height: 1
            color: "gray"
            opacity: 0.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 46
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextInput {
            id: tagsInput
            height: 45
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "white"
            opacity: 0.7
            text: activeFocus ? " " : "Add a tag ..."
            font.italic: true
            verticalAlignment: Text.AlignVCenter
            Keys.onReturnPressed: {
                console.log("Add tag: " + text)
                focus = false
            }

            onActiveFocusChanged:  console.log("activfocus changed" + activeFocus)
        }
    }

    Rectangle {
        width: 1
        height: parent.height
        color: "white"
        opacity: 0.1
    }
}
