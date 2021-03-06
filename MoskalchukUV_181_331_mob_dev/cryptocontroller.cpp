#include "cryptocontroller.h"

CryptoController::CryptoController (QObject *parent) : viewer(parent)
{

}

QString CryptoController::getFileName(QString name){
    qDebug() << name;
    int j = 0;
    if((j = name.indexOf("file:///", j)) != -1) {
        file = name.mid( j + 8);
        return file;
    }
    else {
        qDebug() << "error";

    }
    QString str = " ";
    return str;
}

bool CryptoController::encriptFile(QString key){
    EVP_CIPHER_CTX *ctx;

    if (!(ctx = EVP_CIPHER_CTX_new())) return false;

    if (1 != EVP_EncryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(key.toLatin1().data()), iv)) {
            return false;
    }

    QFile our_file(file); // исходный файл с текстом, который мы будем шифровать
    our_file.open(QIODevice::ReadOnly); // этот файл открыт только для чтения, изменять его нельзя

    QFile file_encript("C:/Users/User/Desktop/encrypted.txt"); // файл, в котором будет наш зашифрованный текст из иходного файла 1
    file_encript.open(QIODevice::ReadWrite | QIODevice::Truncate); // этот файл открыт только для записи

     // 1. Считать очередную порцию данных из файла в буфер plaintext
    unsigned char ciphertext[256] = {0}; // зашифрованный текст
    unsigned char plaintext[256] = {0}; // расшифрованный текст
    int plaintext_len  = our_file.read((char *)plaintext, 256); // длина текста, который будем шифровать
    int len  = 0;


    while (plaintext_len>0) //цикл шифрования
    {

        // 2. Применить функцию EVP_EncryptUpdate для получния ciphertext и len
       if (1 != EVP_EncryptUpdate(ctx, // уже заполненная структура с настройками
                              ciphertext, //выходной параметр, буфер, куда запис шифра текст
                              &len , // выходной параметр, кол-во защифрованных символов
                              plaintext, // входной параметр, шифруемый буфер
                              plaintext_len )) { // входной параметр, кол-во исходных символов
           return false;
       }

       // 3. Запись ciphertext в файл шифрованных данных
        file_encript.write((char*)ciphertext, len );
        plaintext_len  = our_file.read((char*)plaintext, 256);
    }

    //необходимо вызвать для финализации
     if (1 != EVP_EncryptFinal_ex(ctx, ciphertext + len, &len)) return false;

    file_encript.write((char*)ciphertext, len);

    EVP_CIPHER_CTX_free(ctx);

    file_encript.close();
    our_file.close();

    return true;
}

bool CryptoController::decriptFile(QString key){


    EVP_CIPHER_CTX *ctx;// сишная структура


     if (!(ctx = EVP_CIPHER_CTX_new())){//выделение памяти, аналогичное С++-оператору new
         return false;
     }

    if (1 !=EVP_DecryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(key.toLatin1().data()), // ключ шифрования
                       iv)){ // вектор
        return false;
    }

    QFile file_encript("C:/Users/User/Desktop/encrypted.txt");
    file_encript.open(QIODevice::ReadOnly);

    QFile file_decript("C:/Users/User/Desktop/decrypted.txt");
    file_decript.open(QBuffer::ReadWrite | QBuffer::Truncate);

    unsigned char ciphertext[256] = {0}; // зашифрованный текст
    unsigned char plaintext[256] = {0}; // расшифрованный текст
    int plaintext_len  = file_encript.read((char *)plaintext, 256); // длина текста, который будем шифровать
    int len  = 0;


    while (plaintext_len >0)
    {
         if (1 != EVP_DecryptUpdate(ctx,// уже заполненная структура с настройками
                              ciphertext,//выходной параметр, буфер, куда запис шифра текст
                              &len, // выходной параметр, кол-во защифрованных символов
                              plaintext, // входной параметр, шифруемый буфер
                              plaintext_len )) { // входной параметр, кол-во исходных символов
             return false;
         }



        file_decript.write((char*)ciphertext, len);
        plaintext_len  = file_encript.read((char*)plaintext, 256);
    }
 //необходимо вызвать для финализации
     if (1 != EVP_DecryptFinal_ex(ctx, ciphertext + len, &len)) return false;

    file_decript.write((char*)ciphertext, len);
    //Удаление структуры
    EVP_CIPHER_CTX_free(ctx);

    file_decript.close();
    file_encript.close();
    return true;
}

