import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14

Page {
    id: page3

    Binding { target: headerLabel; property: "text"; value: "Lab3"; when: swipeView.currentIndex === 2}

}
