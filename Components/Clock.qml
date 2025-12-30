import Quickshell.Widgets
import Quickshell.Io
import QtQuick

Rectangle {
    function getTime() {
        return Qt.formatDateTime(new Date(), "HH:mm:ss");
    }

    height: parent.height
    anchors.centerIn: parent

    color: "red"

    radius: 6

    implicitWidth: clock.implicitWidth + 20
    implicitHeight: clock.implicitHeight

    Text {
        id: clock
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent

        text: getTime()

        font {
            family: "FiraMono Nerd Font"
            pixelSize: 14
            bold: false
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = getTime()
        }
    }
}
