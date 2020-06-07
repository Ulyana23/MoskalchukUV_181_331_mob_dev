import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.14
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.0


Page {
    property date startTime
    property date newTime
    property date deltaTime

    property bool menuOpen: false
    property bool captureStatus: true




    id: page2

    Binding { target: headerLabel; property: "text"; value: "Видео"; when: swipeView.currentIndex === 1 }

    Connections {
        target: points
        onClicked: if(swipeView.currentIndex === 1) {
                       if(menuOpen === false) {
                           menuLab2.open()
                           menuOpen = true
                       }
                       else {
                           menuLab2.close()
                           menuOpen = false
                       }
                    }
    }


    Menu {
        id: menuLab2
        x: points.x

        MenuItem {
            text: "видео"
            font.pixelSize: 13
            onTriggered: {
                subpage1.visible = true
                subpage2.visible = false
                headerLabel.text = "Видео"
                camera.stop()
            }

        }

        MenuItem {
            text: "камера"
            font.pixelSize: 13
            onTriggered: {
                subpage2.visible = true
                subpage1.visible = false
                headerLabel.text = "Камера"
                mediaplayer.stop()
                camera.start()
            }
        }

    }


    /*RowLayout {
        id: radioRow

            RadioButton {
                id: rb1
                text: "Видео"
                checked: true
                onCheckedChanged: {
                    subpage1.visible = true
                    subpage2.visible = false
                    headerLabel.text = "Видео"
                    camera.stop()
                }


            }
            RadioButton {
                text: "Камера"
                onCheckedChanged: {
                    subpage2.visible = true
                    subpage1.visible = false
                    headerLabel.text = "Камера"
                    mediaplayer.stop()
                    camera.start()
                }


            }
        }*/

//############################################################################################
    Item { //----------------------PAGE1
        id: subpage1
        //anchors.fill: parent
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        //anchors.topMargin: 20


        Timer {
            id: timerVideo
            interval: 500

            repeat: true

            onTriggered: {
                newTime = new Date()
                deltaTime = new Date(newTime - startTime)
                //label1.text = Qt.formatTime(deltaTime, "ss:zzz") + "??"
                if(Qt.formatTime(deltaTime, "ss") == "05") timerVideo.stop()

            }

        }


        MediaPlayer {
               id: mediaplayer
               source: "../videos/video_lab2.mp4"

               onPlaying: {
                   timerVideo.start()
                   startTime = new Date()
               }

               volume: volumeSlider.value

           }

        ColumnLayout {

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            Rectangle {
                anchors.fill: videoOutput
                color: "black"
            }

            Button {
                id: addVideoButton
                flat: true
                icon.source: "../images/attach.svg"

                icon.color: "#fff"
                anchors.top: videoOutput.top
                anchors.right: parent.right

                z: 100

                text: ""

                onClicked: {

                    mediaplayer.stop()
                    fileDialog.open()
                }

                FileDialog {
                    id: fileDialog
                    title: "Please choose a file"
                    nameFilters: [ "Video files (*.mp4 *.webm *.mpg *.avi *.mov *.wmv *.flv *.swf *.mkv)" ]

                    onAccepted: mediaplayer.source = fileDialog.fileUrl


                }


                visible: (mediaplayer.playbackState === MediaPlayer.StoppedState) || (mediaplayer.playbackState === MediaPlayer.PausedState) || (timerVideo.running) ? true : false
            }

            VideoOutput {
               id: videoOutput

               //anchors.fill: parent
               anchors.right: parent.right
               anchors.left: parent.left
               anchors.top: parent.top
               anchors.bottom: parent.bottom
               //anchors.topMargin: 20
               //anchors.bottomMargin: 20
               source: mediaplayer


               MouseArea {
                  id: playArea
                  anchors.fill: parent

                  onPressed: mediaplayer.playbackState == MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()

               }
            }

            Button {
                id: play
                //text: "play"
                text: ""

                anchors.left: parent.left
                anchors.leftMargin: 5
                //anchors.bottom: videoOutput.bottom
                anchors.verticalCenter: slider.verticalCenter
                anchors.right: slider.left

                onClicked: {
                    mediaplayer.playbackState == MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()
                }

                flat: true

                height: 35
                width: 35

                icon.source: mediaplayer.playbackState == MediaPlayer.PlayingState ? "../images/pause.svg" : "../images/play.svg"
                icon.color: "#fff"
                icon.height: 20
                icon.width: 20


                visible: (mediaplayer.playbackState === MediaPlayer.StoppedState) || (mediaplayer.playbackState === MediaPlayer.PausedState) || (timerVideo.running) ? true : false
            }

            Slider { //------------SLIDER
                id: slider
                //anchors.top: progressBar.bottom
                anchors.right: volumeButton.left
                anchors.rightMargin: -20
                anchors.left: play.right
                anchors.bottom: videoOutput.bottom
                anchors.bottomMargin: 20
                from: 0
                to: mediaplayer.duration
                value: mediaplayer.playbackState === MediaPlayer.StoppedState ? 0 : mediaplayer.position

                    background: Rectangle {
                        x: slider.leftPadding
                        y: slider.topPadding + slider.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 2
                        width: slider.availableWidth
                        height: implicitHeight //естественная высота элемента
                        radius: 2
                        color: "#636363"

                        Rectangle {
                            width: slider.visualPosition * parent.width
                            height: parent.height
                            color: "#fff"
                            radius: 2
                        }
                    }

                    handle: Rectangle {
                        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                        y: slider.topPadding + slider.availableHeight / 2 - height / 2
                        implicitWidth: 13
                        implicitHeight: 13
                        radius: 13
                        color: slider.pressed ? "#c9c9c9" : "#f6f6f6"
                        //border.color: slider.pressed ? "#8f8f8f" : "#bdbebf"
                    }


                //onValueChanged
                onPressedChanged: {
                        mediaplayer.seek(slider.value)
                }

                visible: (mediaplayer.playbackState === MediaPlayer.StoppedState) || (mediaplayer.playbackState === MediaPlayer.PausedState) || (timerVideo.running) ? true : false

            }//----------SLIDER--end





            Button {
                id: volumeButton
                text: ""
                //anchors.left: slider.right
                anchors.rightMargin: -20
                anchors.right: volumeSlider.left
                anchors.verticalCenter: slider.verticalCenter

                flat: true

                height: 20
                width: 20

                icon.source: "../images/speaker.svg"
                icon.color: "#fff"
                icon.height: 15
                icon.width: 15

                visible: (mediaplayer.playbackState === MediaPlayer.StoppedState) || (mediaplayer.playbackState === MediaPlayer.PausedState) || (timerVideo.running) ? true : false


            }

            Slider {
                id: volumeSlider

                //anchors.left: volumeButton.right
                anchors.right: parent.right
                anchors.verticalCenter: slider.verticalCenter

                from: 0
                to: 1
                value: 0.5

                background: Rectangle {
                    x: volumeSlider.leftPadding
                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    implicitWidth: 70
                    implicitHeight: 1
                    width: volumeSlider.availableWidth
                    height: implicitHeight //естественная высота элемента
                    radius: 2
                    color: "#636363"

                    Rectangle {
                        width: volumeSlider.visualPosition * parent.width
                        height: parent.height
                        color: "#fff"
                        radius: 2
                    }
                }

                handle: Rectangle {
                    x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    implicitWidth: 8
                    implicitHeight: 8
                    radius: 13
                    color: volumeSlider.pressed ? "#c9c9c9" : "#f6f6f6"
                    //border.color: slider.pressed ? "#8f8f8f" : "#bdbebf"
                }

                visible: (mediaplayer.playbackState === MediaPlayer.StoppedState) || (mediaplayer.playbackState === MediaPlayer.PausedState) || (timerVideo.running) ? true : false

            }


        }





    }//--------------PAGE1---end


//##################################################################################################
    Item {//---------------------PAGE2

        id: subpage2

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 20

        VideoOutput {

                id: cameraArea
                anchors.fill: parent
                source: camera
            }

            Camera {
                id: camera
                captureMode: stop()

                imageCapture {

                    onImageCaptured: {
                        photoPreview.source = preview
                        timer.start()
                    }

                }
        }

            Button {  //----------------------BUTTON--capture
                id: capture

                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 10
                text: ""

                icon.source: captureStatus === true ? "../images/photograph.svg" : "../images/cinema.svg"
                icon.color: "#8f8f8f"
                icon.width: 20
                icon.height: 20

                onClicked: {
                    if(captureStatus === true) {
                        camera.imageCapture.captureToLocation("C:/Users/user/photo");
                        startTime = new Date()
                    }

                    if(captureStatus === false) {
                        if (camera.videoRecorder.recorderStatus == CameraRecorder.RecordingStatus) {
                            camera.videoRecorder.stop()
                        }
                        else camera.videoRecorder.record()

                    }

                }

                background: Rectangle {
                    implicitWidth: 40
                    implicitHeight: 40

                    color: if (camera.videoRecorder.recorderStatus == CameraRecorder.RecordingStatus) {
                        capture.down ? "#a83232" : "#d94e4e"
                    } else capture.down ? "#f2f2f2" : "#fff"

                    border.color: "#8f8f8f"
                    radius: 20

                }
            } //------------------------BUTTON--capture--end

            Button {
                id: photoOrVideo

                anchors.bottom: parent.bottom
                anchors.left: capture.right
                anchors.verticalCenter: capture.verticalCenter
                //anchors.bottomMargin: 15
                anchors.leftMargin: 10
                flat: true
                text: ""



                onClicked: {

                    if(captureStatus === true) {
                        captureStatus = false

                    }
                    else {
                        captureStatus = true

                    }
                }


                    icon.source: captureStatus === false ? "../images/photograph.svg" : "../images/cinema.svg"

                background: Rectangle {
                    color: "transparent"

                    implicitWidth: 35
                    implicitHeight: 35
                }


            }

            Timer {
                id: timer
                    interval: 500

                    repeat: true

                    onTriggered: {
                            newTime = new Date()
                            deltaTime = new Date(newTime - startTime)
                            //label1.text = Qt.formatTime(deltaTime, "ss:zzz") + "??"
                            if(Qt.formatTime(deltaTime, "ss") == "02") timer.stop()

                    }

                }

            /*Label {
                id: label1
            }*/

            Image {
                    id: photoPreview
                    anchors.fill: cameraArea
                    fillMode: Image.PreserveAspectFit //изображение масштабируется равномерно
                    visible: timer.running
                }


        visible: false

    }
}

















