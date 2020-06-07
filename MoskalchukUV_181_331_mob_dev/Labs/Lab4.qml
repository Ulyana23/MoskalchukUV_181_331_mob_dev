import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0



Page {
    id: page4
    property bool menuOpen: false


    Connections {
        target: points
        onClicked: if(swipeView.currentIndex === 3) {
                       if(menuOpen === false) {
                           menuLab4.open()
                           menuOpen = true
                       }
                       else {
                           menuLab4.close()
                           menuOpen = false
                       }
                    }
    }

    Menu {
        id: menuLab4
        x: points.x

        MenuItem {
            text: "Сайт с погодой"
            font.pixelSize: 13
            onTriggered: {
                siteWeather.visible = true
                parsingPage.visible = false
                background.visible = false

            }

        }

        MenuItem {
            text: "Погода сейчас"
            font.pixelSize: 13
            onTriggered: {
                siteWeather.visible = false
                parsingPage.visible = true
                background.visible = true
            }
        }

    }

    //###############################################################################################################



    Connections {
        target: httpController

        function onSignalSendToQML(pString, temperatureNow, json) {
            /*console.log("*** Вызван обработчик");
            swipeView.currentIndex = 3;*/

            busyIndicator.running = false
            busyIndicator1.running = false
            busyIndicator1.visible = false
            textarea.append(pString);
            textField.text = temperatureNow;


            columnLayout.visible = true
            columnLayout1.visible = true
            nowTime.text = json["nowTime"] + " Вчера в это время <span style=\"color: white\">"+ json["degreesYesterdeyNowTime"] + "</span>";
            degreesNow.text = json["degreesNow"];
            weatherNow.text = json["weatherNow"];
            degreesFeelsLike.text = "Ощущается как <span style=\"color: white\">" + json["degreesFeelsLike"] + "</span>";
            windSpeed.text = "ветер: <b style=\"color: white\">" + json["windSpeed"] + "</b>";
            water.text = "влажность: <b style=\"color: white\">" + json["water"] + "</b>"
            pressure.text = "атмосферное давление: <b style=\"color: white\">" + json["pressure"] + "</b>"
            moscowWeather.text = "Погода в Москве"

        }
    }

    Binding { target: headerLabel; property: "text"; value: "Запросы к серверу по HTTP"; when: swipeView.currentIndex === 3 }

    GridLayout {
        id: siteWeather


        anchors.fill: parent
        columns: 1
        rows: 3

        Flickable {
            id: flickable
            //anchors.fill: parent
            Material.background: "#badeff"

            Layout.fillHeight: true
            Layout.fillWidth: true
            TextArea.flickable: TextArea {
                id: textarea
                //placeholderText: "textarea"

                textFormat: Text.RichText
                wrapMode: TextArea.Wrap

                background: Rectangle {
                    id: rectangle
                    anchors.fill: parent
                    color: "#fff"
                }

                readOnly: true



                BusyIndicator {
                    id: busyIndicator
                    anchors.centerIn: parent
                    running: false

                }

            }

            ScrollBar.vertical: ScrollBar { }
        }
        Button {
            Layout.alignment: Qt.AlignHCenter
            text: "вывести на экран"
            font.pixelSize: 12
            Material.background: "#4a76a8"
            Material.foreground: "#fff"
            onClicked: {
                textarea.clear();
                rectangle.color = "#fff"
                textField.text = ""
                busyIndicator.running = true
                busyIndicator1.running = true
                signalMakeRequest();
                rectangle.color = "#badeff"

            }
        }

        TextField {
            id: textField
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: TextInput.AlignHCenter

            //placeholderText: "textfield"
            font.pixelSize: 17

            readOnly: true
        }

    }



    //#####################################################################




    GridLayout {
        id: parsingPage

        anchors.fill: parent
        columns: 1
        rows: 3
        Material.foreground: "#fff"
        visible: false



        BusyIndicator {
            id: busyIndicator1
            Material.accent: "#fff"
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 60
            running: false
            visible: false

        }

       ColumnLayout {
            id: columnLayout
            Layout.leftMargin: 30

            Label {
                id: moscowWeather
                font.bold: true
                font.pixelSize: 18
            }

            Label {
                id: nowTime
                Material.foreground: "#ced6e1"
                textFormat: Text.RichText
            }

            RowLayout {

                spacing: 10
                Label {
                    id: degreesNow
                    font.pixelSize: 50
                    font.bold: true

                }

                ColumnLayout {
                    Label {
                        id: weatherNow
                    }

                    Label {
                        id: degreesFeelsLike
                        Material.foreground: "#ced6e1"
                        textFormat: Text.RichText
                    }

                }

            }



        }

        ColumnLayout {
            id: columnLayout1
            Layout.leftMargin: 30
            Layout.alignment: Qt.AlignTop
            Layout.topMargin: -44

            Label {
                id: windSpeed
                Material.foreground: "#ced6e1"
                textFormat: Text.RichText
            }

            Label {
                id: water
                Material.foreground: "#ced6e1"
                textFormat: Text.RichText

            }


            Label {
                id: pressure
                Material.foreground: "#ced6e1"
                textFormat: Text.RichText
            }
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            text: "обновить данные"
            font.pixelSize: 12
            Material.background: "#4a76a8"
            Material.foreground: "#fff"
            onClicked: {
                textarea.clear();
                columnLayout.visible = false
                columnLayout1.visible = false
                rectangle.color = "#fff"
                textField.text = ""
                busyIndicator.running = true
                busyIndicator1.running = true
                busyIndicator1.visible = true
                signalMakeRequest();
                rectangle.color = "#badeff"

            }
        }


    }

    background: Rectangle {
        id: background
        anchors.fill: parent
        anchors.margins: 7
        radius: 15
        visible: false
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#587a9f" }
            GradientStop { position: 0.50; color: "#638cb8" }
            GradientStop { position: 1.0; color: "#91abce" }
            //GradientStop { position: 0.80; color: "#91abce" }
            //GradientStop { position: 1.0; color: "#fff" }
        }


    }

}
