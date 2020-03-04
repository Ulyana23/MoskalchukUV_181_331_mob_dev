import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: mainWindow //если к объекту не планируется обращаться, можно без id
    visible: true
    width: 320
    height: 480
    title: qsTr("Главное окно") //qsTr - функция для переключения языков, но можно и без него

    //Material.theme: Material.Dark
    //Material.accent: "#808080"

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        font.family: "Arial"

        font.capitalization: Font.MixedCase

        Page { //-----------------------------------LABA1
            id: page1


            header: ToolBar { //-----------HEADER
                id: toolBar
                //Material.foreground: "#fff"
                Material.background: "#4a76a8"

                ToolButton {
                    id: toolButton
                    width: 55
                    Image {
                        id: vk
                        anchors.centerIn: toolButton
                        source: "images/vk.png"
                        width: 40
                        height: 32
                        smooth: true
                    }
                }



                Rectangle {
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: toolButton.right
                    anchors.right: points.left
                    anchors.leftMargin: 8
                    color: "#4f7eb3"
                    radius: 2
                    clip: true

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.left: parent.left
                        text: "Приложения Qt QML. Элементы GUI."
                        font.pixelSize: 12

                    }
                }

                ToolButton {
                    id: points
                    text: qsTr("⋮")

                    font.pixelSize: 25
                    //font.family: "Arial"
                    anchors.right: parent.right
                }
            }//----------HEADER--end



                ColumnLayout {
                    id: busyIndicator
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    BusyIndicator {
                        running: image.status === Image.Loading
                    }
                    Label {
                        text: "загрузка..."
                        font.pixelSize: 13
                    }
                }


                Rectangle {
                    id: rectangle1
                    anchors.top: busyIndicator.bottom
                    anchors.margins: 20
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    //width: parent.width
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 3
                    color: "gray"
                    radius: 3
                }

                Row {
                    id: row
                    scale: 0.7
                    anchors.top: rectangle1.bottom
                    anchors.left: parent.left
                    anchors.topMargin: -15
                    Tumbler {
                        id: tumbler1
                        model: 24
                        height: 160
                        //anchors.top: rectangle.bottom
                    }

                    Tumbler {
                        id: tumbler2
                        model: 60
                        height: 160
                        //anchors.top: rectangle.bottom
                        //anchors.left: tumbler1.right

                    }
                }


                ColumnLayout {
                    scale: 0.8
                    anchors.top: rectangle1.bottom
                    anchors.right: parent.right
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10
                    Material.accent: "#4a76a8"
                    anchors.topMargin: 10
                    RadioButton {
                        checked: true
                        text: qsTr("Русский")
                    }
                    RadioButton {
                        text: qsTr("Английский")
                    }
                }

                Rectangle {
                    id: rectangle2
                    anchors.top: row.bottom
                    anchors.margins: 10
                    anchors.topMargin: -15
                    anchors.left: parent.left
                    anchors.right: parent.right
                    radius: 3
                    height: 3
                    color: "gray"
                }


                TextArea {
                    id: textArea
                    scale: 1
                    anchors.top: rectangle2.bottom
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    placeholderText: qsTr("Введите ваши Имя и Фамилию")
                    font.pixelSize: 14
                }

                Button {
                    id: button
                    text: "отправить данные"
                    font.pixelSize: 12
                    anchors.top: textArea.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    Material.background: "#4a76a8"
                    Material.foreground: "#fff"
                }




        } //--------------LABA1--end



        Page { //страница демонстрации layout
            GridLayout {
                columns: 3
                anchors.fill: parent
                Button {
                    id: button4
                    text: "кнопка1"

                    font {
                        family: "Arial"
                        bold: true
                        //pixelSize: 30
                        italic: true
                    }
                }

                Button {
                    text: "кнопка2"

                    height: 50

                }

                Button {
                    text: "кнопка3"

                    height: 100
                    width: 100
                }

                Button {
                    text: "кнопка4"

                    height: 100
                    width: 100
                }

                Button {
                    text: "кнопка5"

                    //height: 200 не задействовано в layout
                    //width: 200 не задействовано в layout

                    Layout.row: 2
                    Layout.column: 2
                    Layout.preferredHeight: 200

                    Layout.preferredWidth: 200
                    //Layout.fillHeight: true
                    //Layout.fillWidth: true
                }

            }
        }

        Page { //страница демонстрации anchor

            background: Rectangle {
                color: "blue"
            }

            Button {
                id: button1
                text: "Кнопка1"


                font {
                    family: "Arial"
                    bold: true
                    //pixelSize: 30
                    italic: true
                }
            }

            Button {
                text: "кнопка2"
                anchors.right: parent.right
                anchors.left: button1.right
                anchors.top: button1.bottom
                height: 50
                anchors.margins: 20 //topMargin etc
            }

            Button {
                text: "кнопка3"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                height: 100
                width: 100
                //anchors.centerIn: parent
            }
        }
    }


    footer: TabBar { //FOOTER
        id: tabBar
        currentIndex: swipeView.currentIndex
        Material.foreground: "#ccc"
        Material.background: "#fff"



        TabButton {
            text: qsTr("lab1")
        }
        TabButton {
            text: qsTr("lab2")
        }
        TabButton {
            text: qsTr("lab3")
        }
    }
}
