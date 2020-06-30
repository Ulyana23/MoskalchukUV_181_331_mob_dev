import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtWebView 1.1

Page {
    id: page5

    Binding { target: headerLabel; property: "text"; value: "Получение токена"; when: swipeView.currentIndex === 4}

    GridLayout {
        anchors.fill: parent
        Button {
            id: btAuth
            text: "Авторизация"
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 12
            Material.background: "#4a76a8"
            Material.foreground: "#fff"

            onClicked: {
                browser.visible = true
                browser.url = "https://oauth.vk.com/authorize"
                + "?client_id=" + "7407559"
                + "&display=mobile"
                + "&redirect_uri=https://oauth.vk.com/blanck.html"
                + "&score=friends"
                + "&response_type=token"
                + "&v=5.37"
                + "&state=123457";
                btAuth.visible = false;
                success.visible = false;
                error.visible = false;

            }
        }
    }


    Label {
        id: success
        text: "Вы успешно авторизовались"
        color: "green"

        visible: false
    }

    Label {
        id: error
        text: "Авторизоваться не получилось, попробуйте ещё раз."
        color: "red"

        visible: false
    }

        Popup {
            id: popup

            width: 200
            height: 200
            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside


            ColumnLayout {
                anchors.fill: parent

                    Text {
                        text: "Поздравляю! Вы успешно авторизовались!"
                        font.pixelSize: 13
                        Layout.preferredWidth: parent.width

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WordWrap
                        Layout.fillHeight: true

                    }


                    Label {
                        text: "Access token"
                        font.pixelSize: 12
                        color: "#4a76a8"
                        font.bold: true
                        Layout.preferredWidth: parent.width

                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }

                    Text {
                        id: accessToken

                        Layout.preferredWidth: parent.width

                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter

                        wrapMode: Text.WrapAnywhere
                    }

                Button {
                    text: "Выход"
                    font.pixelSize: 12
                    Material.background: "#4a76a8"
                    Material.foreground: "#fff"

                    Layout.fillWidth: true

                    onClicked: {
                        Qt.quit()
                        //browser.url = "https://login.vk.com/?act=logout_mobile&hash=3aea8efa8a56fbbaed&reason=tn&_origin=https://vk.com";
                        //popup.close();


                    }

                }
            }

            }





    WebView {
        id: browser
        anchors.fill: parent
        visible: false
        url: ""



        onLoadingChanged: {

            console.info("*** " + browser.url);

            var BrUsl = browser.url;
            var val = httpController.getSomeValueFromCPP(BrUsl);
            if(val !== "") {
                console.log(val)
                accessToken.text = val
                popup.open()
                browser.visible = false
                btAuth.visible = true
                success.visible = true
                error.visible = false
            }

            else  {
                browser.visible = false
                btAuth.visible = true
                success.visible = false
                error.visible = true
            }

            //var token = String.prototype.match.call(BrUsl, /\#(?:access_token)\=([\S\s]*?)\&/)[1];

            //if(token !== "") console.info(token)

            /*if (loadRequest.status == WebView.LoadSucceededStatus && browser.url == "https://oauth.vk.com/authorize?client_id=7407559&display=mobile&redirect_uri=https://oauth.vk.com/blanck.html&score=friends&response_type=token&v=5.37&state=123456") {
                browser.visible = true
            }

            if (browser.url == "https://login.vk.com/?act=logout_mobile&hash=3aea8efa8a56fbbaed&reason=tn&_origin=https://vk.com") {
                browser.visible = false
            }*/

            if (browser.url == "https://m.vk.com/" || browser.url == "https://m.vk.com/feed") {
                browser.url = "https://oauth.vk.com/authorize"
                + "?client_id=" + "7407559"
                + "&display=mobile"
                + "&redirect_uri=https://oauth.vk.com/blanck.html"
                + "&score=friends"
                + "&response_type=token"
                + "&v=5.37"
                + "&state=123456";



            }


        }



    }


}
