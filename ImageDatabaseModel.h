#ifndef IMAGEDATABASEMODEL_H
#define IMAGEDATABASEMODEL_H

#include <QAbstractListModel>
#include <QStandardItemModel>
#include <QFutureWatcher>
#include <QStringList>
class EvaImage;
class ImageDatabaseModel : public QStandardItemModel
{
    Q_OBJECT
public:
    explicit ImageDatabaseModel(QObject *parent = 0);
    


protected:
    QHash<int, QByteArray> roleNames() const;

signals:
    
public slots:
    const QString getImage(int row);
    const QString getImageName(int row);
    const QString getImageDate(int row);

    QStringList getImageModel(int row);


private slots:
    void getRootDirectory();
    void entriesReady();
    
private:
    QFutureWatcher<QStringList> _watcher;
    QList<EvaImage*> _images;
};

#endif // IMAGEDATABASEMODEL_H
