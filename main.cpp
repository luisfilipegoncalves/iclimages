#include <QApplication>
#include "qtquick2applicationviewer.h"
#include "ImageDatabaseModel.h"

#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    ImageDatabaseModel model;

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/iclimages/main.qml"));
    viewer.showExpanded();
    viewer.rootContext()->setContextProperty("imagesModel", &model);

    return app.exec();
}
