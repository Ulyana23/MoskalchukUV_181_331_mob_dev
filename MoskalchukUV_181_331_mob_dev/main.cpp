#include "qhttpcontroller.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    //вызов независимой функции в составе класса QCoreApplication
    //без создания экземпляра класса (объекта)
    //просто настройка масштабирования экрана
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling); //QCoreApplication - базовый класс, отвечает за базовые свойства объекта

    QGuiApplication app(argc, argv); //добавляет графические сущности; моздаётся базовое приложение с графической областью
    //QApplication - виджеты



    HttpController httpController;

    httpController.GetNetworkValue();

    QQmlApplicationEngine engine; //создание браузерного движка; engine - браузерный движок



    QQmlContext * context = engine.rootContext();
    context->setContextProperty("httpController", &httpController); //поместить С++ объект в область видимости движка qml

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

    return app.exec(); //запуск бесконечного цикла обработки сообщений и слотов сигналов
}
