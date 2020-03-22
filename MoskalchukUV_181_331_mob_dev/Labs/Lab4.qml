import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {

    GridLayout {
        anchors.fill: parent
        columns: 1
        rows: 3
        TextArea {
            id: textarea
            Layout.alignment: Qt.AlignHCenter
            placeholderText: "textarea"
        }
        Button {
            Layout.alignment: Qt.AlignHCenter
            text: "button"
            onClicked: {
                signalMakeRequest();
            }
        }
        TextField {
            Layout.alignment: Qt.AlignHCenter
            placeholderText: "textfield"

            readOnly: true
        }

    }

}
