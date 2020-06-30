import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtWebView 1.1

Page {
    Binding { target: headerLabel; property: "text"; value: "Просмотр"; when: swipeView.currentIndex === 9}
    ColumnLayout {
        anchors.fill: parent
        WebView {
            id: browser

            //url: "https://yandex.ru/"
            url: "file:///C:/Users/User/Desktop/mobile/MoskalchukUV_181_331_mob_dev/codeEditor/index.html";

            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Button {
            text: "Update"
            Layout.alignment: Qt.AlignHCenter
            Material.background: "#4a76a8"
            Material.foreground: "#fff"
            onClicked: {
                browser.url = "file:///C:/Users/User/Desktop/mobile/MoskalchukUV_181_331_mob_dev/codeEditor/index.html";
            }
        }
    }
}


