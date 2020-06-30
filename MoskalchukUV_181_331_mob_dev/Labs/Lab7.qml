import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.0

Page {
    id: page7

    Binding { target: headerLabel; property: "text"; value: "Шифрование"; when: swipeView.currentIndex === 6}

    ColumnLayout {
        anchors.fill: parent
        clip: true

        spacing: -5

        Text {
            id: textChooseFileOrKey
            text: "Вы выбрали файл<br>" + crypto.getFileName(fileDialog.fileUrls) + "<br><br>Теперь вы можете ввести ключ шифрования и зашифровать свой файл"
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignHCenter

            color: "#ffffff"
            visible: false
        }

        Text {
            id: error
            text: "Введите 32 символа"
            color: "red"
            font.bold: true
            Layout.leftMargin: 30
            visible: false
        }

        TextField {
            id: textField
            height: 100

            Layout.fillWidth: true
            placeholderText: "введите ключ длинной 32 символа"
            font.pixelSize: 14
            font.bold: true
            Layout.leftMargin: 30
            Layout.rightMargin: 30
            color: "#ffffff"
            placeholderTextColor: "#ededed"

            maximumLength: 32

            background: Item {
                width: parent.width
                height: parent.height
                Rectangle {
                    color: "#ffffff"
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                }
            }

            visible: false
        }

        Text {
            id: textChooseFile
            text: "Выберете любой текстовый файл, чтобы его зашифровать."
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.margins: 20
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignHCenter

            color: "#ffffff"
        }


            Button {
                id: buttonEncript
                text: "Зашифровать файл"
                Material.background: "#4a76a8"
                Material.foreground: "#ffffff"
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.rightMargin: 30


                onClicked: {
                    if((textField.text).length !== 32) error.visible = true; else {

                        crypto.encriptFile(textField.text)
                        error.visible = false
                        buttonEncript.visible = false
                        textField.readOnly = true
                        buttonDecript.visible = true
                        textChooseFileOrKey.text = "Вы выбрали файл<br>" + crypto.getFileName(fileDialog.fileUrls)
                    }
                }

                visible: false
            }

            Button {
                id: buttonDecript
                text: "Расшифровать файл"
                Material.background: "#4a76a8"
                Material.foreground: "#ffffff"
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.rightMargin: 30


                onClicked: {
                    crypto.decriptFile(textField.text);
                    buttonDecript.visible = false
                    buttonEncript.visible = true
                }

                visible: false
            }

            Button {
                id: buttonChooseFile
                text: "Выбрать файл"
                Material.background: "#4a76a8"
                Material.foreground: "#fff"
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.rightMargin: 30
                Layout.topMargin: -25
                Layout.bottomMargin: 20


                onClicked: {
                    fileDialog.open()
                }
            }


        FileDialog {
                    id: fileDialog
                    title: "Выберите файл для шифрования"
                    nameFilters: [ "Text files (*.txt)", "All files (*.txt *.doc *.docx *.cpp)" ]
                    onAccepted: {

                        if (buttonChooseFile.text === "Выбрать другой файл") {
                            textField.text = ""
                            buttonDecript.visible = false
                            buttonEncript.visible = true
                            error.visible = false
                            textField.readOnly = false
                            textChooseFileOrKey.text = "Вы выбрали файл<br>" + crypto.getFileName(fileDialog.fileUrls) + "<br><br>Теперь вы можете ввести ключ шифрования и зашифровать свой файл"
                        }

                        textChooseFile.visible = false
                        textField.visible = true
                        buttonChooseFile.text = "Выбрать другой файл"
                        textChooseFileOrKey.visible = true
                        buttonEncript.visible = true
                    }

                }

    }

    background: Rectangle {
        id: background
        anchors.fill: parent
        anchors.margins: 7
        radius: 15
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#587a9f" }
            GradientStop { position: 0.20; color: "#91abce" }
            GradientStop { position: 0.45; color: "#a4bee0" }
            GradientStop { position: 0.55; color: "#a4bee0" }
            GradientStop { position: 0.80; color: "#91abce" }
            GradientStop { position: 1.0; color: "#91abce" }
        }


    }
}
