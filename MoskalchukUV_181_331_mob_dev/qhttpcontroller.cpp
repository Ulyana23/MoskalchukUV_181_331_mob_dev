#include "qhttpcontroller.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QEventLoop>
#include <QDebug>
#include <QBitArray>

HttpController::HttpController(QObject *parent) : QObject(parent)
{
    nam = new QNetworkAccessManager();
    //connect(nam, &QNetworkAccessManager::finished,
            //this, &HttpController::SlotFinished);


}

/*void HttpController::SlotFinished(QNetworkReply * reply) {
    qDebug() << "SlotFinished()";
    qDebug() << reply->url() << reply->rawHeaderList() << reply->readAll();
}*/

void HttpController::GetNetworkValue()
{
    QNetworkRequest requerst;
    requerst.setUrl((QUrl("http://club-nissan.ru/forums")));
    //qDebug() << requerst.url() << requerst.rawHeaderList();
    QNetworkReply * reply;
    //qDebug() << "before get()";
    QEventLoop evtLoop;
    connect(nam, &QNetworkAccessManager::finished,
            &evtLoop, &QEventLoop::quit);

    reply = nam->get(requerst);
    evtLoop.exec();

    QByteArray replyString  = reply->readAll();

    emit signalSendToQML(QString(replyString));

    qDebug() << "GetNetworkValue()";
    qDebug() << reply->url() << reply->rawHeaderList() << reply->readAll();
}
