import QtQuick 2.14
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14
import QtQuick.Layouts 1.12

Page {
    id: page3

    property bool menuOpen: false

    Binding { target: headerLabel; property: "text"; value: "Lab3"; when: swipeView.currentIndex === 2}

    Connections {
        target: points
        onClicked: if(swipeView.currentIndex === 2) {
                       if(menuOpen === false) {
                           menuLab3.open()
                           menuOpen = true
                       }
                       else {
                           menuLab3.close()
                           menuOpen = false
                       }
                    }
    }

    Menu {
        id: menuLab3
        x: points.x

        MenuItem {
            text: "одно фото"
            font.pixelSize: 13
            onTriggered: {
                gl.visible = true
                gl1.visible = false

            }

        }

        MenuItem {
            text: "три фото"
            font.pixelSize: 13
            onTriggered: {
                gl.visible = false
                gl1.visible = true
            }
        }

    }

    //###############################################################################################################

    GridLayout {
        id: gl
        anchors.fill: parent
        columns: 2
        rows: 3

        visible: false

        Item {
            id: item
            height: 180
            width: 180
            Layout.row: 0
            Layout.rowSpan: 3
            Layout.column: 0
            Layout.leftMargin: -23
            Layout.rightMargin: -23

            Image {
                id: image
                Layout.row: 0
                Layout.column: 0

                source: "../images/image_lab3.jpg"
                anchors.fill: item

                //sourceSize.height: parent.height / 3
                fillMode: Image.PreserveAspectFit

                smooth: true
                visible: false
            }

            Image {
                id: foreground
                Layout.row: 0
                Layout.column: 0

                source: "../images/foreground_lab3.png"
                anchors.fill: item

                //sourceSize.height: parent.height / 3
                fillMode: Image.PreserveAspectFit

                smooth: true
                visible: false
            }

            Image {
                id: mask
                Layout.row: 0
                Layout.column: 0

                source: "../images/mask_lab3.png"
                anchors.fill: item

                //sourceSize.height: parent.height / 3

                smooth: true
                visible: false
            }

        }


         Blend {
             id: blend
             anchors.fill: item

             source: image
             foregroundSource: foreground
             mode: blendMode.currentText
             visible: false
         }

         ColumnLayout {
             id: growColumbLayout

             Layout.column: 1
             Layout.row: 0
             spacing: -20

             Slider {
                 id: growSpread
                 Text {
                     text: "spread"
                     x: growSamples.x
                 }
                 implicitWidth: 160
                 Layout.alignment: Qt.AlignHCenter
                 from: 0.0
                 to: 1.0
                 value: 0.5
             }

             Slider {
                 id: growRadius
                 Text {
                     text: "radius"
                     x: growSamples.x
                 }
                 implicitWidth: 160
                 Layout.alignment: Qt.AlignHCenter
                 from: 0
                 to: 30
                 value: 8

             }

             Slider {
                 id: growSamples

                 Text {
                     text: "samples"
                     x: growSamples.x
                 }

                 implicitWidth: 160
                 Layout.alignment: Qt.AlignHCenter
                 from: 0
                 to: 30
                 value: 17
             }

             RowLayout {
                 Layout.alignment : Qt.AlignHCenter
                 RadioButton {
                     id: rb1
                     text: "зелёный"
                     font.pixelSize: 12
                     checked: true

                     onCheckedChanged: {
                         grow.color = "green"
                     }
                 }

                 RadioButton {
                     id: rb2
                     text: "серый"
                     font.pixelSize: 12

                     onCheckedChanged: {
                         grow.color = "gray"
                     }
                 }
             }
         }


        ThresholdMask {
            id: thresholdMask
            anchors.fill: item

            source: blend
            maskSource: mask
            threshold: maskThreshold.value
            spread: maskSpread.value
        }

        ColumnLayout {

            Layout.column: 1
            Layout.row: 1

            Slider {
                id: maskThreshold
                Text {
                    text: "threshold"
                    x: maskThreshold.x
                }
                implicitWidth: 160
                Layout.alignment: Qt.AlignHCenter
                from: 0.0
                to: 1.0
                value: 0.5
            }

            Slider {
                id: maskSpread
                Text {
                    text: "spread"
                    x: maskSpread.x
                }
                implicitWidth: 160
                Layout.alignment: Qt.AlignHCenter
                from: 0.0
                to: 1.0
                value: 0.2

            }
        }

        Glow {
            id: grow
            anchors.fill: item

            radius: growRadius.value
            samples: growSamples.value
            color: "green"
            source: thresholdMask
            spread: growSpread.value

            //visible: false

        }


        ComboBox {
           id: blendMode
           font.pixelSize: 13
           implicitWidth: 160
           Layout.column: 1
           Layout.row: 2
           Layout.alignment: Qt.AlignTop


           model: ["addition", "average", "color", "colorBurn", "colorDodge", "darken",
               "darkerColor", "difference", "divide", "exclusion", "hardlight", "hue", "lighten", "lighterColor", "lightness",
               "negation", "multiply", "saturation", "screen", "subtract", "softLight"]
       }




    }

    //####################################################################################################


    GridLayout {
            id: gl1
            anchors.fill: parent
            columns: 2
            rows: 3

            Item {
                id: item1
                height: 130
                width: 130
                Image {
                    id: image1
                    Layout.row: 0
                    Layout.column: 0

                    source: "../images/image_lab3.jpg"
                    anchors.fill: item1

                    //sourceSize.height: parent.height / 3
                    fillMode: Image.PreserveAspectFit

                    smooth: true
                    visible: false
                }

                Image {
                    id: foreground1
                    Layout.row: 0
                    Layout.column: 0

                    source: "../images/foreground_lab3.png"
                    anchors.fill: item1

                    //sourceSize.height: parent.height / 3
                    fillMode: Image.PreserveAspectFit

                    smooth: true
                    visible: false
                }

                Image {
                    id: mask1
                    Layout.row: 0
                    Layout.column: 0

                    source: "../images/mask_lab3.png"
                    anchors.fill: item1

                    //sourceSize.height: parent.height / 3

                    smooth: true
                    visible: false
                }

            }


            Glow {
                id: grow1
                Layout.column: 0
                Layout.row: 0
                width: image1.width
                height: image1.height

                radius: growRadius1.value
                samples: growSamples1.value
                color: "green"
                source: image1
                spread: growSpread1.value

            }

            ColumnLayout {

                Layout.column: 1
                Layout.row: 0
                spacing: -20

                Slider {
                    id: growSpread1
                    Text {
                        text: "spread"
                        x: growSamples1.x
                    }
                    implicitWidth: 160
                    Layout.alignment: Qt.AlignHCenter
                    from: 0.0
                    to: 1.0
                    value: 0.5
                }

                Slider {
                    id: growRadius1
                    Text {
                        text: "radius"
                        x: growSamples1.x
                    }
                    implicitWidth: 160
                    Layout.alignment: Qt.AlignHCenter
                    from: 0
                    to: 30
                    value: 8

                }

                Slider {
                    id: growSamples1

                    Text {
                        text: "samples"
                        x: growSamples1.x
                    }

                    implicitWidth: 160
                    Layout.alignment: Qt.AlignHCenter
                    from: 0
                    to: 30
                    value: 17
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    RadioButton {
                        id: rb11
                        text: "зелёный"
                        font.pixelSize: 12
                        checked: true

                        onCheckedChanged: {
                            grow1.color = "green"
                        }
                    }

                    RadioButton {
                        id: rb21
                        text: "серый"
                        font.pixelSize: 12

                        onCheckedChanged: {
                            grow1.color = "gray"
                        }
                    }
                }
            }

            Blend {
                Layout.column: 0
                Layout.row: 1
                width: image1.width
                height: image1.height

                source: image1
                foregroundSource: foreground1
                mode: blendMode1.currentText
            }

             ComboBox {
                id: blendMode1
                font.pixelSize: 13
                implicitWidth: 160
                Layout.column: 1
                Layout.row: 1

                model: ["addition", "average", "color", "colorBurn", "colorDodge", "darken",
                    "darkerColor", "difference", "divide", "exclusion", "hardlight", "hue", "lighten", "lighterColor", "lightness",
                    "negation", "multiply", "saturation", "screen", "subtract", "softLight"]
            }



            ThresholdMask {
                Layout.column: 0
                Layout.row: 2
                width: image1.width
                height: image1.height

                source: image1
                maskSource: mask1
                threshold: maskThreshold1.value
                spread: maskSpread1.value
            }

            ColumnLayout {

                Layout.column: 2
                Layout.row: 0

                Slider {
                    id: maskThreshold1
                    Text {
                        text: "threshold"
                        x: maskThreshold1.x
                    }
                    implicitWidth: 160
                    Layout.alignment: Qt.AlignHCenter
                    from: 0.0
                    to: 1.0
                    value: 0.5
                }

                Slider {
                    id: maskSpread1
                    Text {
                        text: "spread"
                        x: maskSpread1.x
                    }
                    implicitWidth: 160
                    Layout.alignment: Qt.AlignHCenter
                    from: 0.0
                    to: 1.0
                    value: 0.2

                }
            }
    }


}
