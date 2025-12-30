import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import qs.Common

Rectangle {
    function getTime() {
        return Qt.formatDateTime(new Date(), "HH:mm:ss");
    }

    height: parent.height
    anchors.centerIn: parent

    color: Theme.background0

    radius: 6

    implicitWidth: clock.implicitWidth + 20
    implicitHeight: clock.implicitHeight

    Text {
        id: clock
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent

        color: Theme.foreground

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
