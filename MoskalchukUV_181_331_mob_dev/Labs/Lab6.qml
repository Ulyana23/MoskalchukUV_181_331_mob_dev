import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import QtQuick.Window 2.12

Page {
    id: page_6

    property bool menuOpen: false
    property bool auth: false

    Binding { target: headerLabel; property: "text"; value: "Список"; when: swipeView.currentIndex === 5}

    Connections {
        target: points
        onClicked: if(swipeView.currentIndex === 5) {
                       if(menuOpen === false) {
                           menuLab6.open()
                           menuOpen = true
                       }
                       else {
                           menuLab6.close()
                           menuOpen = false
                       }
                    }
    }

    Connections {
        target: httpController

        function onSignalLab6() {
                auth = true;
            }

        }


    Menu {
        id: menuLab6
        x: points.x

        MenuItem {
            text: "Плитка"
            font.pixelSize: 13
            onTriggered: {
                grid.visible = true
                list.visible = false
                headerLabel.text = "Плитка"
            }

            height: visible ? implicitHeight : 0
            visible: list.visible

        }

        MenuItem {
            text: "Список"
            font.pixelSize: 13
            onTriggered: {
                list.visible = true
                grid.visible = false
                headerLabel.text = "Список"
            }

            height: visible ? implicitHeight : 0
            visible: grid.visible
        }

        MenuItem {
            text: "Обновить"
            font.pixelSize: 13
            onTriggered: {
                if (auth == false) popupError.open();
                else {
                    httpController.restRequest();
                    httpController.writeDB();
                    httpController.readDB();
                }
            }
        }

    }

    ColumnLayout {
        id: columnText
        anchors.fill: parent
        Layout.alignment: Qt.AlignCenter
        Text {
            id: text
            text: "База данных пуста. Пожалуйства, обновите данные."
            font.pixelSize: 15
            font.bold: true
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        visible: list.count == 0 ? true : false;

    }

    ListView {
        id: list
        anchors.fill: parent
        spacing: 5

        ScrollBar.vertical: ScrollBar {
            id: scroll
            visible: list.count == 0 ? false : true;

            policy: ScrollBar.AsNeeded

            contentItem: Rectangle {
                    color: "#ccc"
                    //width: 2 // This will be overridden by the width of the scrollbar
                    height: 10 // This will be overridden based on the size of the scrollbar
                    radius: 6

                }

            width: 8
        }

        visible: true

        delegate: Rectangle {
            id: delegate
            color: "#fff"
            height: Screen.pixelDensity * 20
            width: page_6.width - 16
            anchors.horizontalCenter: parent.horizontalCenter

            RowLayout {
                height: parent.height
                width: parent.width

                Image {
                    id: image
                    source: photo

                    Layout.fillHeight: true

                    Layout.topMargin: 5
                    Layout.bottomMargin: 5
                    fillMode: Image.PreserveAspectFit
                    visible: false
                    smooth: true
                    //opacity: 0.5

                    Item {
                        id: item
                        width: image.width
                        height: image.height

                        Rectangle {
                            id: mask
                            anchors.centerIn: parent
                            width: image.adapt ? image.width : Math.min(image.width, image.height)
                            height: image.adapt ? image.height : width
                            radius: Math.min(width, height)
                            color: "red"
                            smooth: true

                            visible: false
                        }

                    }
                }

                RowLayout {



                Item {
                    id: itemAvatar
                    height: Screen.pixelDensity * 15
                    width: Screen.pixelDensity * 15
                    Layout.alignment: Qt.AlignLeft

                    OpacityMask {
                        id: opMask
                        source: image
                        maskSource: mask
                        height: Screen.pixelDensity * 15
                        width: Screen.pixelDensity * 15

                    }

                    Rectangle {
                        color: "#8ac176"
                        radius: Math.min(width, height)
                        width: 15
                        height: 15

                        anchors.bottom: opMask.bottom
                        anchors.right: opMask.right
                        anchors.rightMargin: -2
                        border.color: "#fff"
                        border.width: 3

                        visible: online
                    }

                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignLeft
                    //Layout.leftMargin: 20
                    Layout.topMargin: 0
                    Layout.leftMargin: 6
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 6

                    Label {
                        id: name_label
                        text: name + " " + secondName
                        font.pixelSize: 12
                        font.bold: true
                        color: "#2a5885"

                        //Layout.alignment: Qt.AlignTop

                    }

                    Label {
                        id: city_label
                        text: city
                        Layout.alignment: Qt.AlignLeft

                        font.pixelSize: 11
                        color: "#9f9f9f"
                    }

                }

                }

                Button {
                    id: button
                    text: "show more"

                    font.pixelSize: 10
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 5

                    Material.foreground: "#fff"

                    background: Rectangle {
                        implicitWidth: 50
                        implicitHeight: 20
                        color: button.down ? "#7b9fc9" : "#5181b8"
                        //border.color: "#26282a"
                        //border.width: 1
                        radius: 4
                    }

                    onClicked: {
                        popup.open()
                    }

                }
            }

            Popup {
                id: popup

                width: 270
                height: status != "" ? 250 : 200
                parent: Overlay.overlay

                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside


                ColumnLayout {
                    anchors.fill: parent
                    spacing: 15

                    Label {
                        //horizontalAlignment: Label.AlignRight
                        text: "@" + domain
                        font.pixelSize: 25
                        font.bold: true
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                    }

                    Label {
                        text: "<b>ID: </b>" + idU
                        font.pixelSize: 13
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                        textFormat: Text.RichText
                    }





                    Label {
                        text: "<b>Пол: </b>" + sex
                        font.pixelSize: 13
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                    }


                    Label {

                        text: if(status != "")  "<b>Статус: </b>" + status
                        font.pixelSize: 13
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                        visible: status == "" ? false : true
                    }



                    Button {
                        text: "Закрыть"
                        font.pixelSize: 12
                        Material.background: "#4a76a8"
                        Material.foreground: "#fff"

                        Layout.fillWidth: true

                        onClicked: {
                            popup.close();
                        }

                    }

                }
            }




        }

        model: friendsModel

        /*model: ListModel {
            ListElement {
                name: "Олег"
                secondName: "Пойлов"
                photo: "https://sun9-26.userapi.com/c857736/v857736647/108ac1/RtZBV_CGL18.jpg?ava=1"
                city: "Москва"
                idU: "234567"
                domain: "gfrtgbvcr"
                status: "здесь типа статус бла бла бла"
                sex: "мужской"
            }
            ListElement {
                name: "John"
                secondName: "Brown"
                photo: "https://sun9-26.userapi.com/c857736/v857736647/108ac1/RtZBV_CGL18.jpg?ava=1"
                city: "Малые Пупки"
                idU: "9876543"
                domain: "gfrtgbvcr"
                status: "здесь типа статус бла бла бла"
                sex: "мужской"
            }
            ListElement {
                name: "Sam"
                secondName: "Wise"
                photo: "https://sun9-26.userapi.com/c857736/v857736647/108ac1/RtZBV_CGL18.jpg?ava=1"
                city: "Путинские Горшки"
                idU: "098765"
                domain: "gfrtgbvcr"
                status: "здесь типа статус бла бла бла"
                sex: "мужской"
            }
        }*/
    }


    /*#################################################################################################
     *#################################################################################################
     */

    GridView {
        id: grid
        anchors.fill: parent

        cellWidth: page_6.width/2; cellHeight: page_6.width/2
        Layout.leftMargin: 10

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
            visible: grid.count == 0 ? false : true;

            contentItem: Rectangle {
                    color: "#ccc"
                    //width: 2 // This will be overridden by the width of the scrollbar
                    height: 10 // This will be overridden based on the size of the scrollbar
                    radius: 6

                }

            width: 8
        }

        visible: false

        delegate: Rectangle {
            id: delegateGrid
            color: "#fff"
            height: page_6.width/2 - 5
            width: page_6.width/2 - 5

            Layout.margins: 5
            Layout.leftMargin: 5

            ColumnLayout {
                anchors.fill: parent

                RowLayout {


                Image {
                    id: imageGrid
                    source: photo

                    Layout.fillHeight: true

                    Layout.topMargin: 5
                    Layout.bottomMargin: 5
                    fillMode: Image.PreserveAspectFit
                    visible: false
                    smooth: true
                    //opacity: 0.5

                    Item {
                        id: itemGrid
                        width: imageGrid.width
                        height: imageGrid.height

                        Rectangle {
                            id: maskGrid
                            anchors.centerIn: parent
                            width: imageGrid.adapt ? imageGrid.width : Math.min(imageGrid.width, imageGrid.height)
                            height: imageGrid.adapt ? imageGrid.height : width
                            radius: Math.min(width, height)
                            color: "red"
                            smooth: true

                            visible: false
                        }

                    }
                }



                Item {
                    id: itemAvatarGrid
                    height: Screen.pixelDensity * 18
                    width: Screen.pixelDensity * 18

                    Layout.alignment: Qt.AlignLeft
                    Layout.leftMargin: 5
                    Layout.topMargin: 5

                    OpacityMask {
                        id: opMaskGrid
                        source: imageGrid
                        maskSource: maskGrid
                        height: Screen.pixelDensity * 18
                        width: Screen.pixelDensity * 18
                    }

                    Rectangle {
                        color: "#8ac176"
                        radius: Math.min(width, height)
                        width: 15
                        height: 15

                        anchors.bottom: opMaskGrid.bottom
                        anchors.right: opMaskGrid.right
                        anchors.rightMargin: -2
                        border.color: "#fff"
                        border.width: 3

                        visible: online
                    }


                }


                ColumnLayout {
                    //Layout.alignment: Qt.AlignLeft
                    //Layout.topMargin: 0
                    Layout.leftMargin: 6

                    width: 160
                    spacing: 6

                    Label {
                        id: name_labelGrid
                        text: name
                        font.pixelSize: 11
                        font.bold: true
                        color: "#2a5885"
                        Layout.topMargin: 5

                        //Layout.alignment: Qt.AlignTop

                    }

                    Label {
                        id: secondName_labelGrid
                        text: secondName
                        font.pixelSize: 11
                        font.bold: true
                        color: "#2a5885"

                        //Layout.alignment: Qt.AlignTop

                    }

                    Label {
                        id: city_labelGrid
                        text: city
                        Layout.alignment: Qt.AlignLeft

                        font.pixelSize: 11
                        color: "#9f9f9f"
                    }


                }

                }



                Button {
                    id: buttonGrid
                    Layout.columnSpan: 2
                    text: "show more"
                    font.pixelSize: 12
                    Layout.fillWidth: true
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10

                    Material.foreground: "#fff"

                    background: Rectangle {
                        //implicitWidth: 50
                        implicitHeight: 30
                        color: buttonGrid.down ? "#7b9fc9" : "#5181b8"
                        //border.color: "#26282a"
                        //border.width: 1
                        radius: 4
                    }

                    onClicked: {
                        popupGrid.open()
                    }

                }
            }

            Popup {
                id: popupGrid

                width: 270
                height: status != "" ? 250 : 200
                parent: Overlay.overlay

                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside


                ColumnLayout {
                    anchors.fill: parent
                    spacing: 15

                    Label {
                        //horizontalAlignment: Label.AlignRight
                        text: "@" + domain
                        font.pixelSize: 25
                        font.bold: true
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                    }

                    Label {
                        text: "<b>ID: </b>" + idU
                        font.pixelSize: 13
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                        textFormat: Text.RichText
                    }



                    Label {
                        text: "<b>Пол: </b>" + sex
                        font.pixelSize: 13
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                    }


                    Label {

                        text: if(status != "")  "<b>Статус: </b>" + status
                        font.pixelSize: 13
                        color: "#333333"
                        Layout.preferredWidth: parent.width
                        wrapMode: Label.WordWrap
                        visible: status == "" ? false : true
                    }



                    Button {
                        text: "Закрыть"
                        font.pixelSize: 12
                        Material.background: "#4a76a8"
                        Material.foreground: "#fff"

                        Layout.fillWidth: true

                        onClicked: {
                            popupGrid.close();
                        }

                    }

                }
            }




        }

        model: friendsModel

    }

    Popup {
        id: popupError

        width: 270
        height: 150
        parent: Overlay.overlay

        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        ColumnLayout {
            anchors.fill: parent
            Text {
                id: textError
                text: "Пожалуйста, авторизуйтесь на странице 5."
                font.pixelSize: 15
                Layout.preferredWidth: parent.width
                wrapMode: Label.WordWrap

                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                id: buttonClose
                text: "Закрыть"
                font.pixelSize: 12
                Material.background: "#4a76a8"
                Material.foreground: "#fff"

                Layout.fillWidth: true
                onClicked: {
                    popupError.close();
                }
            }
        }

    }

}
