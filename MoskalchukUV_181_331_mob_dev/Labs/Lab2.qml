import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.14
import QtGraphicalEffects 1.0


Page {
    property date startTime
    property date newTime
    property date deltaTime

    id: page2

    Binding { target: headerLabel; property: "text"; value: "Видео"; when: tabBar.currentIndex === 1 }


    RowLayout {
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
        }

//############################################################################################
    Item { //----------------------PAGE1
        id: subpage1
        //anchors.fill: parent
        anchors.top: radioRow.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left


        MediaPlayer {
               id: mediaplayer
               source: "../videos/video_lab2.mp4"

           }

        ColumnLayout {

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            Rectangle {
                anchors.fill: videoOutput
                //color: "#f2f2f2"
                color: "black"
                //border.color: "#ccc"
            }

            VideoOutput {
               id: videoOutput


               //anchors.fill: parent
               anchors.right: parent.right
               anchors.left: parent.left
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
                anchors.bottom: videoOutput.bottom
                anchors.bottomMargin: 21

                onClicked: {
                    mediaplayer.playbackState == MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()
                }



                flat: true

                implicitWidth: 25
                implicitHeight: 25


                Image {
                    id: playImage
                    source: mediaplayer.playbackState == MediaPlayer.PlayingState ? "/images/pause.png" : "/images/play.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent

                    ColorOverlay {
                            anchors.fill: playImage
                            source: playImage
                            color: if(play.pressed) {"#ccc"} else if(play.hovered) {"#e3e3e3"} else "#fff"
                    }
                }



            }

            Slider { //------------SLIDER
                id: slider

                //anchors.top: progressBar.bottom
                anchors.right: parent.right
                anchors.left: play.right
                anchors.bottom: videoOutput.bottom
                anchors.bottomMargin: 20
                from: 0
                to: mediaplayer.duration
                value: mediaplayer.position

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

                /*Slider {

                }*/

            }//----------SLIDER--end


            /*Image {
                id: volumeImage
                anchors.left: slider.right
                anchors.right: parent.right
                source: "/images/pause.png"

                ColorOverlay {
                        anchors.fill: volumeImage
                        source: volumeImage
                        color: "#fff"
                }
            }*/


        }





    }//--------------PAGE1---end


//##################################################################################################
    Item {//---------------------PAGE2

        id: subpage2

        anchors.top: radioRow.bottom
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

                onClicked: {
                    if(photoImage.visible === false) {
                        camera.imageCapture.captureToLocation("C:/Users/user/photo");
                        startTime = new Date()
                    }

                    if(videoImage.visible === false) {
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

                    border.color: "#ccc"
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

                    if(videoImage.visible === false) {
                        photoImage.visible = false
                        videoImage.visible = true
                    }
                    else {
                        videoImage.visible = false
                        photoImage.visible = true
                    }
                }



                Image {
                    id: photoImage
                    source: "../images/photo-camera.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    visible: false
                }

                Image {
                    id: videoImage
                    source: "../images/video-camera.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }

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








