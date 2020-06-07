QT += quick network webview svg #список подключённых разделов библиотеки QT

CONFIG += c++11 #настройки компиляции

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS #объявление переменных и флагов окружения

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
TEMPNAME = $${QMAKE_QMAKE}
QTPATH = $$dirname(TEMPNAME)\..\..\..

DEPENDPATH += \
        $$QTPATH\Tools\OpenSSL\Win_x64\include

INCLUDEPATH += \
        $$QTPATH\Tools\OpenSSL\Win_x64\include

win32 {
    LIBS += \
        $$QTPATH\Tools\OpenSSL\Win_x64\lib\libcrypto.lib
}

else: android {
    LIBS += \
        C:\Users\User\AppData\Local\Android\Sdk\android_openssl\static\lib\arm\libcrypto.a
}

#sources - раздел файлов исходного кода на c++
SOURCES += \
        model.cpp \
        qhttpcontroller.cpp \
        main.cpp


# HEADERS - раздел файлов заголовков c++

RESOURCES += qml.qrc #список файлов, включаемых в раздел ресурсов получаемого исполняемого модуля (исполняемый файл, программка)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
#синтаксис "название платформы:" - последующие команды сборки будут работать только на обозначенной платформе
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    model.h \
    qhttpcontroller.h
android: include(C:/Users/User/AppData/Local/Android/Sdk/android_openssl/openssl.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
