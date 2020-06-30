import QtQuick 2.12
import QtQuick.Controls 2.5
import QtCharts 2.3
import QtQuick.Layouts 1.12

Page{
    id: page9

    Binding { target: headerLabel; property: "text"; value: "Графики"; when: swipeView.currentIndex === 7}

    Connections {
        target: httpController

        function onSignalStatisticToQML(men, women) {
            menChart.value = men;
            womenChart.value = women;
            menChart.label = "Мужчины (" + men + "%)";
            womenChart.label = "Женщины (" + women + "%)";
            chartView.visible = true;
            columnText.visible = false

        }
    }

    ColumnLayout {
        id: columnText
        anchors.fill: parent
        Layout.alignment: Qt.AlignCenter
        Text {
            id: text
            text: "Сначала авторизуйся на странице 5 :)"
            font.pixelSize: 18
            font.bold: true
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }

    ChartView {
        id: chartView
        width: parent.width
        height: parent.height
        theme: ChartView.ChartThemeBlueNcs
        antialiasing: true

        PieSeries {
            id: pieSeries
            PieSlice { id: menChart; label: "Мужчины"; value: 0 }
            PieSlice { id: womenChart; label: "Женщины"; value: 0 }

        }
        visible: false

    }
}
