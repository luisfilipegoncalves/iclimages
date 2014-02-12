#include "ImageDatabaseModel.h"

#include <QTimer>
#include <QDebug>
#include <QFileDialog>
#include <QDirIterator>
#include <QtConcurrent/QtConcurrentRun>
#include <QFutureWatcher>
#include <QMimeDatabase>
#include <QStandardItem>

ImageDatabaseModel::ImageDatabaseModel(QObject *parent) :
    QStandardItemModel(parent)
{
    connect(&_watcher, SIGNAL(finished()), this, SLOT(entriesReady()));

    QTimer *timer = new QTimer(this);
    timer->setSingleShot(true);
    timer->setInterval(1000);
    connect(timer, SIGNAL(timeout()), this, SLOT(getRootDirectory()));
    timer->start();
}

QHash<int, QByteArray> ImageDatabaseModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "fileName";
    roles[Qt::UserRole + 1] = "filePath";
    return roles;
}

extern QStringList entryList(const QString &path)
{
    QMimeDatabase db;

    QDirIterator it(path,QDirIterator::Subdirectories);
    QStringList list;
    while (it.hasNext()) {
        QString f = it.next();
        QMimeType t = db.mimeTypeForFile(f);
        QString mymeTypeName = t.name();
        if(mymeTypeName.contains("image/"))
        {
            qDebug() << "f = " << f << " type: " << t.name() << t.aliases();
            list.append(f);
        }
    }
    return list;
}

void ImageDatabaseModel::getRootDirectory()
{
    qDebug() << "getting root directory...";
    QString dirPath = QFileDialog::getExistingDirectory(0, tr("Open Directory"),
                                                    "/home",
                                                    QFileDialog::ShowDirsOnly
                                                    | QFileDialog::DontResolveSymlinks);

    //dirPath = "/Users/luisfilipe/Pictures/testeEva";
    qDebug() << "dir: " << dirPath;
    if(dirPath.isEmpty())
        return;

    QFileInfo info(dirPath);
    if(!info.exists() || !info.isDir())
        return;

    QFuture<QStringList> future = QtConcurrent::run(entryList, dirPath);
    _watcher.setFuture(future);
}

void ImageDatabaseModel::entriesReady()
{
    qDebug() << "Entries ready....";
    QStringList results = _watcher.result();
    qDebug() << "results size: " << results.size();

    foreach(QString fileName, results)
    {
        QStandardItem *itemName = new QStandardItem(fileName);
        itemName->setData(fileName, Qt::UserRole + 1);
        appendRow(QList<QStandardItem*>() <<  itemName );
    }
}
