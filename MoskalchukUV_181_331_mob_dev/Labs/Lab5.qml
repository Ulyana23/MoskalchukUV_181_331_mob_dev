import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Page {

    GridLayout {
        anchors.fill: parent
        columns: 1
        rows: 3

        TextField {
            //Layout.alignment: Qt.AlignHCenter
            placeholderText: "textfield"

            //readOnly: true
        }

        TextField {
            //Layout.alignment: Qt.AlignHCenter
            placeholderText: "textfield2"

            //readOnly: true
        }

        Button {
            //Layout.alignment: Qt.AlignHCenter
            text: "button"
        }




    }

}
