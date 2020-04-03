#include "qhttpcontroller.h"
#include <QNetworkRequest>
#include <QSslSocket>
#include <QNetworkReply>
#include <QEventLoop>
#include <QDebug>
#include <QBitArray>
#include <QTextDocument>

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
    requerst.setUrl(QUrl("https://yandex.ru/pogoda/moscow"));
    //qDebug() << requerst.url() << requerst.rawHeaderList();
    QNetworkReply * reply;
    //qDebug() << "before get()";
    QEventLoop evtLoop;
    connect(nam, &QNetworkAccessManager::finished,
            &evtLoop, &QEventLoop::quit);

    reply = nam->get(requerst);
    evtLoop.exec();

    QByteArray replyString  = reply->readAll();

    otherPage(QString(replyString));



    emit signalSendToQML(QString(replyString), onPageInfo(QString(replyString)), otherPage(QString(replyString)));

    //qDebug() << "GetNetworkValue()";
    //qDebug() << reply->url() << reply->rawHeaderList() << reply->readAll() << QSslSocket::sslLibraryBuildVersionString() << QSslSocket::sslLibraryVersionString() << QSslSocket::supportsSsl();
}

QString HttpController::onPageInfo(QString replyString) {
    int x = replyString.indexOf("Текущая температура</span><span class=\"temp__value\">") + 52;
    int y = replyString.indexOf("</span><span class=\"temp__unit i-font i-font_face_yandex-sans-text-medium\">°</span></div><img");
    int z = y - x;
    QString degreesNow = replyString.mid(x, z) + "°";
    //qDebug() << degreesNow;

    return degreesNow;
}

QJsonObject HttpController::otherPage(QString replyString) {

    int x = replyString.indexOf("Текущая температура</span><span class=\"temp__value\">") + 52;
    int y = replyString.indexOf("</span><span class=\"temp__unit i-font i-font_face_yandex-sans-text-medium\">°</span></div><img");
    int z = y - x;
    QString degreesNow = replyString.mid(x, z) + "°";
    qDebug() << degreesNow;



    int x1 = replyString.indexOf("<time class=\"time fact__time\" datetime=") + 63;
    QString nowTime = replyString.mid(x1, 13);
    qDebug() << nowTime;


    int x2 = replyString.indexOf("<div class=\"temp\" role=\"text\"><span class=\"temp__value\">") + 56;
    int y2 = replyString.indexOf("</span><span class=\"temp__unit i-font i-font_face_yandex-sans-text-medium\">");
    int z2 = y2 - x2;
    QString degreesYesterdeyNowTime = replyString.mid(x2, z2) + "°";
    qDebug() << degreesYesterdeyNowTime;


    int x3 = replyString.indexOf("day-anchor i-bem\" data-bem='") + 57;
    int y3 = replyString.indexOf("</div><div class=\"term term_orient_h");
    int z3 = y3 - x3;
    QString weatherNow = replyString.mid(x3, z3);
    qDebug() << weatherNow;



    int x4 = replyString.indexOf("Ощущается как</div><div class=\"term__value\"><div class=\"temp\" role=\"text\"><span class=\"temp__value\">") + 100;
    int y4 = replyString.indexOf("</span><span class=\"temp__unit i-font i-font_face_yandex-sans-text-medium\">°</span></div></div></div></div></a></div>");
    int z4 = y4 - x4;
    QString degreesFeelsLike = replyString.mid(x4, z4) + "°";
    qDebug() << degreesFeelsLike;


    int x5 = replyString.indexOf("class=\"wind-speed\">") + 19;
    int y5 = replyString.indexOf("</span> <span class=\"fact__unit\">");
    int z5 = y5 - x5;

    int x6 = replyString.indexOf("Метров в секунду, ") + 18;
    int y6 = replyString.indexOf("\" role=\"text\"><i class=\"icon ");
    int z6 = y6 - x6;
    QString windSpeed = replyString.mid(x5, z5) + " м/с, " + replyString.mid(x6, z6);
    qDebug() << windSpeed;


    int x7 = replyString.indexOf("Влажность: ") + 11;
    int y7 = replyString.indexOf("\" role=\"text\"><i class=\"icon icon_humidity-white term__fact-icon\" aria-hidden=\"true\">");
    int z7 = y7 - x7;
    QString water = replyString.mid(x7, z7);
    qDebug() << water;


    int x8 = replyString.indexOf("icon_pressure-white term__fact-icon\" aria-hidden=\"true\"></i>") + 60;
    int y8 = replyString.indexOf(" <span class=\"fact__unit\">мм рт. ст.");
    int z8 = y8 - x8;
    QString pressure = replyString.mid(x8, z8) + " мм рт. ст.";
    qDebug() << pressure;







    QJsonObject json;
    json["degreesNow"] = degreesNow;
    json["nowTime"] = nowTime;
    json["degreesYesterdeyNowTime"] = degreesYesterdeyNowTime;
    json["weatherNow"] = weatherNow;
    json["degreesFeelsLike"] = degreesFeelsLike;
    json["windSpeed"] = windSpeed;
    json["water"] = water;
    json["pressure"] = pressure;



    return json;
}
