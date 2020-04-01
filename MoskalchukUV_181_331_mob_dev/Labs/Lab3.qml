import QtQuick 2.14
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14
import QtQuick.Layouts 1.12

Page {
    id: page3

    Binding { target: headerLabel; property: "text"; value: "Lab3"; when: swipeView.currentIndex === 2}

    GridLayout {
        anchors.fill: parent
        columns: 2
        rows: 3

        Item {
            id: item
            height: 130
            width: 130
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


        Glow {
            id: grow
            Layout.column: 0
            Layout.row: 0
            width: image.width
            height: image.height

            radius: growRadius.value
            samples: growSamples.value
            color: "green"
            source: image
            spread: growSpread.value

        }

        ColumnLayout {

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

        Blend {
            Layout.column: 0
            Layout.row: 1
            width: image.width
            height: image.height

            source: image
            foregroundSource: foreground
            mode: blendMode.currentText
        }

         ComboBox {
            id: blendMode
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
            width: image.width
            height: image.height

            source: image
            maskSource: mask
            threshold: maskThreshold.value
            spread: maskSpread.value
        }

        ColumnLayout {

            Layout.column: 2
            Layout.row: 0

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



    }


}
