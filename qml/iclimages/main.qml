import QtQuick 2.0


Rectangle {
    width: 1000
    height: 800
    id: root
    property Component sourceComp: null

    color: "#676767"

    InfoSideBarView {
        id: info
        width: 300
        height: parent.height
        anchors.right: parent.right
        mymodel: imagesModel
    }

    Loader {
        id: mainLoader
        height: root.height
        anchors.left: parent.left
        anchors.right: info.left
        sourceComponent:  imagesGridComponent.myComponent
    }

    GridViewMode {
        id: imagesGridComponent
        mymodel: imagesModel
        onShowFullScreenImage: {
            console.log("imageIndex: " + imageIndex)
            fullScreenViewComponent.currentImageIndex = imageIndex
            mainLoader.sourceComponent = fullScreenViewComponent.myComponent
        }

        onSelectedImageChanged: {
            info.currentImageIndex = imageIndex
        }
    }

    FullScreenViewMode {
        id: fullScreenViewComponent
        mymodel: imagesModel
        onExitFullscreen: {
            console.log("Exiting full screen view with image index: " + imageIndex)
            mainLoader.sourceComponent = imagesGridComponent.myComponent
        }

        onSelectedImageChanged: {
            info.currentImageIndex = imageIndex
        }
    }

    Rectangle {
        width: 1
        height: parent.height
        color: "#1b1b1b"
        anchors.right: info.left
    }
}
