import QtQuick 2.0
import Qt.labs.folderlistmodel 2.1

Rectangle {
    width: 1000
    height: 800
    color: "gray"
    id: root

    GridView {
        id: grid
        anchors.fill: parent
        cellWidth: 80
        cellHeight: 80

        model: imagesModel
        delegate: imageDelegate

        Component {
            id: imageDelegate
            Rectangle
            {
                width: 70
                height: 70
                color: "transparent"

                Image {
                    anchors.fill: parent
                    anchors.margins: 2
                    id: img
                    cache: true
                    source: filePath
                    asynchronous: true
                    fillMode: Image.PreserveAspectCrop
                    sourceSize.width: 68
                    sourceSize.height: 68

                }
            }
        }

    }


//    ListView {
//        id: listView
//        anchors.fill: parent

//        FolderListModel {
//            id: folderModel
//            folder: "file:///Users/luisfilipe/Pictures"
//            nameFilters: [ "*.png", "*.jpg" ]
//            showDirs: true
//        }

//        Component {
//            id: fileDelegate
//            Rectangle {
//                width: root.width
//                height: 60

//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        console.log(fileName)
//                        console.log(filePath)
//                        folderModel.folder = filePath
//                        console.log("is folder= " + folderModel.isFolder(listView.currentIndex))
//                    }
//                }

//                Text {
//                    text: fileName
//                    anchors.centerIn: parent
//                }
//            }
//        }

//        model: folderModel
//        delegate: fileDelegate
//    }
}
