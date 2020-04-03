import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

/*Item {

}*/



Page { //-----------------------------------LABA1
    id: page1

    Binding { target: headerLabel; property: "text"; value: "Приложения Qt QML. Элементы GUI."; when: swipeView.currentIndex === 0 }


        ColumnLayout {
            id: busyIndicator
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            BusyIndicator {
                running: true
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
            height: 2
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
            height: 2
            color: "gray"
        }


        TextArea {
            id: textArea
            //scale: 1
            height: 100
            clip: true

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
