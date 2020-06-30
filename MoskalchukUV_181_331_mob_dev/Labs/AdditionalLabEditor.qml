import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Page {
    Binding { target: headerLabel; property: "text"; value: "Редактор"; when: swipeView.currentIndex === 10}
    ColumnLayout {
        anchors.fill: parent
        Flickable {
            id: flickableHTML
            Material.background: "#badeff"

            Layout.margins: 5
            Layout.fillHeight: true
            Layout.fillWidth: true
            TextArea.flickable: TextArea {
                id: textareaHTML
                //placeholderText: "textarea"

                //textFormat: Text.RichText
                wrapMode: TextArea.Wrap
                text: httpController.getHTML()

                background: Rectangle {
                    id: rectangleHTML
                    anchors.fill: parent
                    color: "#fff"
                    border.color: '#ccc'
                }

            }

            ScrollBar.vertical: ScrollBar { }
        }
        RowLayout {
            //Layout.fillWidth: true
            anchors.centerIn: parent
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            Button {
                text: "SAVE"
                id: buttonSave
                font.pixelSize: 10
                Layout.alignment: Qt.AlignRight
                Material.foreground: "#fff"
                font.bold: true
                background: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 20
                    color: buttonSave.hovered ? "#7b9fc9" : "#5181b8"
                    radius: 4
                }

                onClicked: {
                    httpController.sendTextareaToFileHTML(textareaHTML.text);
                    httpController.sendTextareaToFileCSS(textareaCss.text);
                }
            }

            Button {
                text: "body"
                id: buttonBody
                font.pixelSize: 10
                Layout.alignment: Qt.AlignRight
                Material.foreground: "#fff"
                font.bold: true
                background: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 20
                    color: buttonBody.hovered ? "#7b9fc9" : "#5181b8"
                    radius: 4
                }

                onClicked:  {
                    textareaHTML.append('<body>\n\n</body>');
                }
            }

            Button {
                text: "div"
                id: buttonDiv
                font.pixelSize: 10
                Layout.alignment: Qt.AlignRight
                Material.foreground: "#fff"
                font.bold: true
                background: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 20
                    color: buttonDiv.hovered ? "#7b9fc9" : "#5181b8"
                    radius: 4
                }

                onClicked:  {
                    textareaHTML.append('<div>\n\n</div>');
                }
            }

            Button {
                text: "а"
                id: buttonA
                font.pixelSize: 10
                Layout.alignment: Qt.AlignRight
                Material.foreground: "#fff"
                font.bold: true
                background: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 20
                    color: buttonA.hovered ? "#7b9fc9" : "#5181b8"
                    radius: 4
                }

                onClicked:  {
                    textareaHTML.append('<a href=""></a>');
                }
            }

            Button {
                text: "input"
                id: buttonInput
                font.pixelSize: 10
                Layout.alignment: Qt.AlignRight
                Material.foreground: "#fff"
                font.bold: true
                background: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 20
                    color: buttonInput.hovered ? "#7b9fc9" : "#5181b8"
                    radius: 4
                }

                onClicked:  {
                    textareaHTML.append('<input type="text">');
                }
            }

            Button {
                text: "+CSS"
                id: buttonLink
                font.pixelSize: 10
                //Layout.alignment: Qt.AlignRight
                Material.foreground: "#fff"
                font.bold: true
                background: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 20
                    color: buttonLink.hovered ? "#7b9fc9" : "#5181b8"
                    radius: 4
                }

                onClicked:  {
                    textareaHTML.append('<link rel="stylesheet" type="text/css" href="style.css">');
                }
            }
        }

        Flickable {
            id: flickableCss
            Material.background: "#badeff"
            //moving: false

            Layout.margins: 5
            Layout.fillHeight: true
            Layout.fillWidth: true
            TextArea.flickable: TextArea {
                id: textareaCss
                //textFormat: Text.RichText
                wrapMode: TextArea.Wrap
                text: httpController.getCSS()

                background: Rectangle {
                    id: rectangleCSS
                    anchors.fill: parent
                    color: "#fff"
                    border.color: '#ccc'
                }

            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
}
