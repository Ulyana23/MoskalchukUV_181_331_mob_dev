#ifndef QHTTPCONTROLLER_H
#define QHTTPCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>

class HttpController : public QObject
{
    Q_OBJECT
public:
    explicit HttpController(QObject *parent = nullptr);
    QNetworkAccessManager * nam;



public slots:
    //void SlotFinished(QNetworkReply *reply);
    void GetNetworkValue();
signals:
    void signalSendToQML(QString pReply);


};

#endif // HTTPCONTROLLER_H
