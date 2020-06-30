#ifndef CRYPTOCONTROLLER_H
#define CRYPTOCONTROLLER_H

#include <QObject>
#include <QFile>
#include <QIODevice>
#include <QObject>
#include <QDebug>
#include <QTemporaryFile>
#include <QBuffer>
#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <openssl/aes.h>


class CryptoController : public QObject {
    Q_OBJECT
public:
    explicit CryptoController(QObject *parent = nullptr);

    QString file;

    public slots:
        bool encriptFile(QString key);
        bool decriptFile(QString key);
        QString getFileName(QString name);

private:
        unsigned char * iv = (unsigned char *)("12345678901234567890123456789090");

protected:
QObject *viewer;

};


#endif // CRYPTOCONTROLLER_H
