#ifndef QHTTPCONTROLLER_H
#define QHTTPCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QJsonObject>

class HttpController : public QObject
{
    Q_OBJECT
public:
    explicit HttpController(QObject *parent = nullptr);
    QNetworkAccessManager * nam;



public slots:
    //void SlotFinished(QNetworkReply *reply);
    void GetNetworkValue();
    QString onPageInfo(QString replyString);
    QJsonObject otherPage(QString replyString);
signals:
    void signalSendToQML(QString pReply, QString temperatureNow, QJsonObject json);


};

#endif // HTTPCONTROLLER_H
