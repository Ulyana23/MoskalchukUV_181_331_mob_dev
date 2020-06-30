import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.14
import QtGraphicalEffects 1.14
import QtWebView 1.14
import QtWebSockets 1.1

Page{
    id: page10

    Binding { target: headerLabel; property: "text"; value: "WebSocket"; when: swipeView.currentIndex === 8}

    ListModel {
        id: listModel
    }

        ListView {
            id: lst101
            anchors.fill: parent
            anchors.topMargin: 10
            anchors.bottomMargin: 70

            spacing: 5
            model: listModel
            delegate: Item {
                width: parent.width
                height: borderImage.height+5
                BorderImage {
                    id: borderImage
                    source: "../images/rectangle.jpg"
                    width: parent.width *0.9

                    height: text.contentHeight + 33
                    anchors.left: outmessage ? undefined : parent.left
                    anchors.right: outmessage ? parent.right : undefined

                    Text {
                        id: text
                        color: "#ffffff"
                        text: message
                        width: borderImage.width*0.8
                        font.pointSize: 10
                        anchors.top: borderImage.top
                        anchors.left: borderImage.left
                        anchors.leftMargin: 10
                        anchors.topMargin: 10

                        wrapMode: TextArea.WrapAtWordBoundaryOrAnywhere
                    }
                    Text {
                        id: textDate
                        color: "#d3d3d3"
                        text: date
                        font.pointSize: 8
                        anchors.top: text.bottom
                        anchors.topMargin: 3
                        anchors.bottom: borderImage.bottom
                        anchors.right: borderImage.right
                        anchors.rightMargin: 6
                        anchors.bottomMargin: 6

                    }


                }
            }
        }



        RowLayout {
            anchors.bottom: parent.bottom
            width: parent.width
            Rectangle {
                anchors.fill: parent
                color: "#ffffff"
            }

            Button {
                id: btn
                //text: "отправить"
                Layout.leftMargin: 5
                //Layout.rightMargin: 15
                flat: true
                icon.source: "../images/send.svg"
                icon.color: btn.hovered ? "#3f648f" : "#426a96"
//                Material.background: "#4a76a8"
//                Material.foreground: "#fff"
                background: Rectangle {
                    color: "#00000000"
                }

                onClicked: {
                    if(textArea.text !== ""){
                        listModel.append({
                                         "outmessage": true,
                                         "message": textArea.text,
                                         "date": Qt.formatDateTime(new Date(), "hh:mm dd.MM.yyyy")
                                     });
                        webSocket.sendTextMessage(textArea.text);
                        textArea.clear();
                    }
                }
            }

            TextArea {
                    id: textArea
                    Layout.fillWidth: true
                    Layout.margins: 5
                    color: "#333333"
                    placeholderTextColor: "#999999"
                    placeholderText: "Введите сообщение..."
                    wrapMode: TextArea.WrapAtWordBoundaryOrAnywhere
                    //Layout.maximumHeight: 50
                    background: Item {
                        width: parent.width
                        height: parent.height
                        Rectangle {
                            color: "#4a76a8"
                            height: 1
                            width: parent.width
                            anchors.bottom: parent.bottom
                        }
                    }
                }
        }

    WebSocket {
        id: webSocket
        active: true
        url: "ws://localhost:8765"
        onTextMessageReceived: {
            console.log("message: ", message);
            listModel.append(
                        {
                            "outmessage" : false,
                            "message" : message,
                            "date" : Qt.formatDateTime(new Date(), "hh:mm dd.MM.yyyy")
                        });
        }
        onStatusChanged: {
            switch(status)
            {
            case WebSocket.Connecting:
                console.log("Connecting");
                break;
            case WebSocket.Open:
                console.log("Open");
                break;
            case WebSocket.Closing:
                console.log("Closing");
                break;
            case WebSocket.Closed:
                console.log("Closed");
                break;
            case WebSocket.Error:
                console.log("Error");
                console.log("errorString = ", errorString);
                break;
            }
        }
    }
}
