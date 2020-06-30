#ifndef QHTTPCONTROLLER_H
#define QHTTPCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QJsonObject>
#include <QJsonArray>
#include "model.h"

class HttpController : public QObject
{
    Q_OBJECT
public:
    explicit HttpController(QObject *parent = nullptr);
    QNetworkAccessManager * nam;
    QString token;
    Model friendsModel;
    double roundTo(double inpValue, int inpCount);

private:
    double menStatistic;
    double womenStatistic;
    QJsonArray itemsArray;


public slots:
    //void SlotFinished(QNetworkReply *reply);
    void GetNetworkValue();
    QString onPageInfo(QString replyString);
    QJsonObject otherPage(QString replyString);
    void restRequest();
    QByteArray SlotGetHttps(QString url);
    QString getHTML();
    QString getCSS();
    void sendTextareaToFileHTML(QByteArray textareaData);
    void sendTextareaToFileCSS(QByteArray textareaData);


    QByteArray SlotGetHttpsWithHeader();



    QString getSomeValueFromCPP(QString index) {
        if (index.contains("https://oauth.vk.com/blank.html", Qt::CaseInsensitive) == false) {
           return "";
        }

        else {
            int st = index.indexOf("access_token") + sizeof("access_token");
            int end = index.indexOf("&expires_in=");

            int size = end - st;
            index = index.mid(st, size);
            token = index;
            emit signalLab6();
            qDebug() << index;
            restRequest();


            return index;
        }
    }

    void writeDB();
    bool readDB();




signals:
    void signalSendToQML(QString pReply, QString temperatureNow, QJsonObject json);
    void signalStatisticToQML(double men, double women);
    void signalLab6();


};

#endif // HTTPCONTROLLER_H
