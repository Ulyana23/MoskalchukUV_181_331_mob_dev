#include "qhttpcontroller.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QtWebView>
#include "model.h"
#include "cryptocontroller.h"

int main(int argc, char *argv[])
{
    //вызов независимой функции в составе класса QCoreApplication
    //без создания экземпляра класса (объекта)
    //просто настройка масштабирования экрана
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling); //QCoreApplication - базовый класс, отвечает за базовые свойства объекта

    QApplication app(argc, argv); //добавляет графические сущности; моздаётся базовое приложение с графической областью
    //QApplication - виджеты
    QtWebView::initialize();


    HttpController httpController;

    httpController.GetNetworkValue();

    QQmlApplicationEngine engine; //создание браузерного движка; engine - браузерный движок



    QQmlContext * context = engine.rootContext();

    context->setContextProperty("httpController", &httpController); //поместить С++ объект в область видимости движка qml
    context->setContextProperty("friendsModel", &httpController.friendsModel);

    const QUrl url(QStringLiteral("qrc:/main.qml")); //где брать стартовую страницу для движка, преобразование пути стартовой страницы из char в QURL
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) //заголовок лямбда-выражения
    { //тело лямбда-выражения
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1); //обработчик ошибок; подключение слота, срабатывающего по сигналу objectCreated
    }, Qt::QueuedConnection);
    engine.load(url); //загрузка стартовой страницы с адресом URL

    QObject * mainWindow = engine.rootObjects().first();
    QObject::connect(mainWindow, SIGNAL(signalMakeRequest()),
            &httpController, SLOT(GetNetworkValue()));

    CryptoController crypto(mainWindow);
    context->setContextProperty("crypto", &crypto);


    return app.exec(); //запуск бесконечного цикла обработки сообщений и слотов сигналов
    //в третьей сделать кнопку чтобы сохранять картинку - 3 балла
    //вторая 3 балла мультимедиа горизонтальным свайпом пролистывать
    //
}
