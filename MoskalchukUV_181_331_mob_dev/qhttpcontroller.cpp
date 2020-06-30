#include "qhttpcontroller.h"
#include <QNetworkRequest>
#include <QSslSocket>
#include <QNetworkReply>
#include <QEventLoop>
#include <QDebug>
#include <QBitArray>
#include <QTextDocument>
#include <QJsonDocument>
#include <QJsonArray>
#include <QtCore/qmath.h>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlTableModel>
#include <QtSql/QSqlError>
#include <QFile>
#include <QByteArray>


HttpController::HttpController(QObject *parent) : QObject(parent)
{
    nam = new QNetworkAccessManager();
    //connect(nam, &QNetworkAccessManager::finished,
            //this, &HttpController::SlotFinished);

    qDebug() << "ATTANTION " << QString(SlotGetHttpsWithHeader());
    readDB();
}

void HttpController::sendTextareaToFileHTML(QByteArray textareaData) {
    QFile HTML("C:/Users/User/Desktop/mobile/MoskalchukUV_181_331_mob_dev/codeEditor/index.html");
    HTML.open(QIODevice::WriteOnly);
    qstrlen(textareaData);
    HTML.write(textareaData, qstrlen(textareaData));
    HTML.close();
}

void HttpController::sendTextareaToFileCSS(QByteArray textareaData) {
    QFile CSS("C:/Users/User/Desktop/mobile/MoskalchukUV_181_331_mob_dev/codeEditor/style.css");
    CSS.open(QIODevice::WriteOnly);
    CSS.write(textareaData, qstrlen(textareaData));
    CSS.close();

}

QString HttpController::getHTML() {
    QFile HTML("C:/Users/User/Desktop/mobile/MoskalchukUV_181_331_mob_dev/codeEditor/index.html");
    HTML.open(QIODevice::ReadOnly);
    QString stringHTML = HTML.readAll();
    HTML.close();

    return stringHTML;
}

QString HttpController::getCSS() {
    QFile CSS("C:/Users/User/Desktop/mobile/MoskalchukUV_181_331_mob_dev/codeEditor/style.css");
    CSS.open(QIODevice::ReadOnly);
    QString stringCSS = CSS.readAll();
    CSS.close();

    return stringCSS;
}

QByteArray HttpController::SlotGetHttps(QString url) {
    QNetworkRequest requerst;
    requerst.setUrl(QUrl(url));
    QNetworkReply * reply;
    QEventLoop evtLoop;
    connect(nam, &QNetworkAccessManager::finished,
            &evtLoop, &QEventLoop::quit);

    reply = nam->get(requerst);
    evtLoop.exec();

    QByteArray replyString  = reply->readAll();
    return replyString;
}

QByteArray HttpController::SlotGetHttpsWithHeader() {
    QNetworkRequest requerst;
    requerst.setUrl(QUrl("https://cloud-api.yandex.net/v1/disk/resources/files"));

    requerst.setRawHeader(QByteArray("Authorization"), QByteArray("OAuth AgAAAAA7j4KAAAZG_5rvSweRhUCbmMM3p2hjNNc"));
    /*requerst.setHeader(QNetworkRequest::ContentTypeHeader, "Accept: application/json "
    "Content-Type: application/json "
    "Authorization: AgAAAAA7j4KAAAZG_5rvSweRhUCbmMM3p2hjNNc"); */
    QNetworkReply * reply;
    QEventLoop evtLoop;
    connect(nam, &QNetworkAccessManager::finished,
            &evtLoop, &QEventLoop::quit);

    reply = nam->get(requerst);
    evtLoop.exec();

    QByteArray replyString  = reply->readAll();
    return replyString;
}

void HttpController::GetNetworkValue()
{

    QByteArray replyString = SlotGetHttps("https://yandex.ru/pogoda/moscow");


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
    if (weatherNow.at(0) == ">") weatherNow = weatherNow.mid(1);
    qDebug() << weatherNow;



    int x4 = replyString.indexOf("Ощущается как</div><div class=\"term__value\"><div class=\"temp\" role=\"text\"><span class=\"temp__value\">") + 100;
    int y4 = replyString.indexOf("</span><span class=\"temp__unit i-font i-font_face_yandex-sans-text-medium\">°</span></div></div></div></div></a></div>");
    int z4 = y4 - x4;
    QString degreesFeelsLike = replyString.mid(x4, z4) + "°";
    qDebug() << degreesFeelsLike;


    int x5 = replyString.indexOf("class=\"wind-speed\">") + 19;
    int y5 = replyString.indexOf("</span> <span class=\"fact__unit\">");
    int z5 = y5 - x5;

    QString windSpeed;
    int xx6 = replyString.indexOf("Ветер: ") + 7;
    int yy6 = replyString.indexOf(" Метров в секунду, ");
    int zz6 = yy6 - xx6;

    int x6 = replyString.indexOf("Метров в секунду, ") + 18;
    int y6 = replyString.indexOf("\" role=\"text\"><i class=\"icon ");
    int z6 = y6 - x6;
    if (replyString.mid(xx6, zz6) == "Штиль") windSpeed = replyString.mid(xx6, zz6);
    else windSpeed = replyString.mid(x5, z5) + " м/с, " + replyString.mid(x6, z6);
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

void HttpController::restRequest() {
    double menCount = 0;
    double womenCount = 0;
    QByteArray replyString = SlotGetHttps("https://api.vk.com/method/friends.get?v=5.52&fields=photo_100,city,status,domain,sex&access_token=" + token);

    QJsonDocument jsonDoc = QJsonDocument::fromJson(replyString);

    qDebug() << jsonDoc;


    QJsonObject rootObject = jsonDoc.object();

    if (rootObject.contains("response") && rootObject["response"].isObject())
    {

        QJsonValue responseValue = rootObject.value("response");
        QJsonObject responseObj = responseValue.toObject();

        if (responseObj.contains("count") && responseObj["count"].isDouble()) {

            QJsonValue count = responseObj.value("count");

            qDebug() << " COUNT " << count.toDouble();

        }

        if (responseObj.contains("items") && responseObj["items"].isArray()) {
            QJsonValue items = responseObj.value("items");

            itemsArray = items.toArray();

            //qDebug() << "ITEMS " << itemsArray;



            for (const QJsonValue & item: itemsArray) {

                QJsonObject itemObj = item.toObject();

                if (itemObj.contains("sex") && itemObj["sex"].isDouble()) {

                    QJsonValue sexVal = itemObj.value("sex");

                    if (sexVal.toDouble() == 1) {
                        womenCount += 1;
                    }

                    if (sexVal.toDouble() == 2) {
                        menCount += 1;
                    }

                }

            }

            menStatistic = roundTo(menCount * 100 / (menCount + womenCount), 0);
            womenStatistic = roundTo(womenCount * 100 / (menCount + womenCount), 0);

            emit signalStatisticToQML(double(menStatistic), double(womenStatistic));

        }

    }

}


double HttpController::roundTo(double inpValue, int inpCount) {
        double outpValue;
        double tempVal;
        tempVal=inpValue*pow(10,inpCount);
        if (double(int(tempVal))+0.5 == tempVal)
        {
            if (int(tempVal)%2 == 0)
                {outpValue=double(qFloor(tempVal))/pow(10,inpCount);}
            else
                {outpValue=double(qCeil(tempVal))/pow(10,inpCount);}
        }
        else
        {
            if (double(int(tempVal))+0.5 > tempVal)
                {outpValue=double(qFloor(tempVal))/pow(10,inpCount);}
            else
                {outpValue=double(qCeil(tempVal))/pow(10,inpCount);}
        }
        return(outpValue);
    }


void HttpController::writeDB() {
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("friends");
    db.setDatabaseName("C:/Users/User/Desktop/friends.db");
    db.open();
    QSqlQuery query;
    query.exec("DROP TABLE friends");
    query.exec("CREATE TABLE friends ("
               "id int,"
               "name varchar(255),"
               "secondName varchar(255),"
               "online varchar(255),"
               "city boolean,"
               "photo varchar(255),"
               "domain varchar(255),"
               "sex varchar(255),"
               "status varchar(255))");

    foreach (const QJsonValue & item, itemsArray) {

        QString name;
        QString secondName;
        bool online = false;
        QString city;
        QString photo;
        QString domain;
        QString sex;
        int id = 0;
        QString status;

        QJsonObject itemObj = item.toObject();


        if (itemObj.contains("first_name") && itemObj["first_name"].isString()) {

            QJsonValue nameVal = itemObj.value("first_name");

            name = nameVal.toString();

        }


        if (itemObj.contains("domain") && itemObj["domain"].isString()) {

            QJsonValue domainVal = itemObj.value("domain");

            domain = domainVal.toString();

        }

        if (itemObj.contains("id") && itemObj["id"].isDouble()) {

            QJsonValue idVal = itemObj.value("id");

            qDebug() << itemObj.value("id").toInt();

            id = idVal.toInt();

        }

        if (itemObj.contains("sex") && itemObj["sex"].isDouble()) {

            QJsonValue sexVal = itemObj.value("sex");

            if (sexVal.toDouble() == 1) {
                sex = "женский";
            }

            if (sexVal.toDouble() == 2) {
                sex = "мужской";
            }

        }

        if (itemObj.contains("status") && itemObj["status"].isString()) {

            QJsonValue statusVal = itemObj.value("status");


            status = statusVal.toString();

        }


        if (itemObj.contains("last_name") && itemObj["last_name"].isString()) {

            QJsonValue secondNameVal = itemObj.value("last_name");

            secondName = secondNameVal.toString();

        }

        if (itemObj.contains("online") && itemObj["online"].isDouble()) {
            QJsonValue onlineVal = itemObj.value("online");
            online = onlineVal.toDouble();
        }

        if (itemObj.contains("photo_100") && itemObj["photo_100"].isString()) {
            QJsonValue photoVal = itemObj.value("photo_100");
            photo = photoVal.toString();
        }

        if (itemObj.contains("city") && itemObj["city"].isObject()) {
            QJsonValue cityVal = itemObj.value("city");

            QJsonObject cityObj = cityVal.toObject();

            if (cityObj.contains("title") && cityObj["title"].isString()) {
                QJsonValue titleVal = cityObj.value("title");
                city = titleVal.toString();

                qDebug() << city;

            }

            else city = "";
        }


        query.prepare("INSERT INTO friends (id, name, secondName, online, city, photo, domain, sex, status)"
                      "VALUES (:id, :name, :secondName, :online, :city, :photo, :domain, :sex, :status)");
        query.bindValue(":id", id);
        query.bindValue(":name", name);
        query.bindValue(":secondName", secondName);
        query.bindValue(":online", online);
        query.bindValue(":city", city);
        query.bindValue(":photo", photo);
        query.bindValue(":domain", domain);
        query.bindValue(":sex", sex);
        query.bindValue(":status", status);
        query.exec();
    }

    QSqlDatabase::removeDatabase("QSQLITE");
    db.close();
    //readDB();

    //emit toQML91(online, offline);
}



bool HttpController::readDB()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("friends");
    db.setDatabaseName("C:/Users/User/Desktop/friends.db");
    db.open();
    if(db.isOpen()){
        if (friendsModel.rowCount() > 0) {
            friendsModel.clear();
        }

        QSqlQuery query;


        if (query.exec("SELECT * FROM friends") == true ){

            query.exec("SELECT * FROM friends");


            QString name;
            QString secondName;
            bool online = false;
            QString city;
            QString photo;
            QString domain;
            QString sex;
            int id = 0;
            QString status;

            while (query.next()) {

                name = query.value("name").toString();
                secondName = query.value("secondName").toString();
                online = query.value("online").toBool();
                city = query.value("city").toString();
                photo = query.value("photo").toString();
                domain = query.value("domain").toString();
                sex = query.value("sex").toString();
                id = query.value("id").toInt();
                status = query.value("status").toString();

                friendsModel.addItem(FriendObject(name,
                                                     secondName,
                                                     online,
                                                     city,
                                                     photo, id, domain, sex, status));
            }

                QSqlDatabase::removeDatabase("QSQLITE");
                db.close();
                return true;

        }
            else {
                qDebug()<<"ERROR";
                return false;
            }
    }

    else qDebug()<<"DB is not open";
    return false;


}







