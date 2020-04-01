import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {

    GridLayout {
        anchors.fill: parent
        columns: 1
        rows: 3

        Flickable {
            id: flickable
            //anchors.fill: parent

            TextArea.flickable: TextArea {
                id: textarea
                placeholderText: "textarea"
                wrapMode: TextArea.Wrap
            }

            ScrollBar.vertical: ScrollBar { }
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
