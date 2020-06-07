import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12

import "Labs"

ApplicationWindow {
    signal signalMakeRequest()

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

        Lab1 { }

        Lab2 { }

        Lab3 { }

        Lab4 { }

        Lab5 { }

        Lab6 { }

        /*Page { //страница демонстрации layout

            //Binding { target: headerLabel; property: "text"; value: if(tabBar.currentIndex === 1) "Lab2"; }
            Binding { target: headerLabel; property: "text"; value: "Lab2"; when: tabBar.currentIndex === 1}

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
        }*/

        /*Page { //страница демонстрации anchor

            Binding { target: headerLabel; property: "text"; value: "Lab3"; when: tabBar.currentIndex === 2}

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
        }*/
    }

    Drawer {
        id: drawer
        width: 0.66 * parent.width
        height: parent.height
        //dragMargin: 40

        GridLayout {
            //anchors.fill: parent
            width: parent.width
            columns: 1
            Button {
                text: "Lab1"
                flat: true
                width: parent.width

                onClicked: {
                    swipeView.currentIndex = 0
                    drawer.close()
                }

            }

            Button {
                text: "Lab2"
                flat: true

                onClicked: {
                    swipeView.currentIndex = 1
                    drawer.close()
                }
            }

            Button {
                text: "Lab3"
                flat: true

                onClicked: {
                    swipeView.currentIndex = 2
                    drawer.close()
                }
            }

            Button {
                text: "Lab4"
                flat: true

                onClicked: {
                    swipeView.currentIndex = 3
                    drawer.close()
                }
            }

            Button {
                text: "Lab5"
                flat: true

                onClicked: {
                    swipeView.currentIndex = 4
                    drawer.close()
                }
            }

            Button {
                text: "Lab6"
                flat: true

                onClicked: {
                    swipeView.currentIndex = 5
                    drawer.close()
                }
            }
        }
    }



    header: Rectangle { //---------------HEADER
        id: toolBar
        //width: parent.width
        Material.foreground: "#fff"
        color: "#4a76a8"
        height: 15 * Screen.pixelDensity


        ToolButton {
            id: toolButton
            width: 55
            anchors.centerIn: toolButton
            icon.source: "images/vk.svg"
            icon.color: "#fff"
            //flat: true

            onClicked: {
                drawer.open()
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
                id: headerLabel
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.left: parent.left
                //text: "Приложения Qt QML. Элементы GUI."
                font.pixelSize: 12

            }
        }

        ToolButton {
            id: points
            text: qsTr("⋮")

            font.pixelSize: 25
            //flat: true
            //font.family: "Arial"
            anchors.right: parent.right
            //anchors.bottom: parent.bottom


        }
    }//----------HEADER--end




    /*footer: TabBar { //---------------FOOTER
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
    }*///---------------FOOTER--end
}
