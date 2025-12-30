import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import qs.Common

Rectangle {
    function getTime() {
        return Qt.formatDateTime(new Date(), "HH:mm:ss");
    }

    height: parent.height
    anchors.left: parent

    color: Theme.background0

    radius: 6

    implicitWidth: battery.implicitWidth + 20
    implicitHeight: battery.implicitHeight

    function getBatteryIcon(percentage) {
        if (percentage == 100)
            return "󰁹";
        if (percentage >= 90)
            return "󰂂";
        if (percentage >= 80)
            return "󰂁";
        if (percentage >= 70)
            return "󰂀";
        if (percentage >= 60)
            return "󰁿";
        if (percentage >= 50)
            return "󰁾";
        if (percentage >= 40)
            return "󰁽";
        if (percentage >= 30)
            return "󰁼";
        if (percentage >= 20)
            return "󰁻";
        if (percentage >= 10)
            return "󰁺";
        else
            return "󰂃";
    }

    function getColour(percentage) {
        if (percentage >= 20)
            return Theme.foreground;
        if (percentage >= 10)
            return Theme.yellow;
        else
            return Theme.red;
    }

    Text {
        id: battery
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent

        color: getColour(UPower.displayDevice.percentage * 100)

        text: {
            let text = "";
            if (UPower.displayDevice.state == UPowerDeviceState.Charging)
                text += "⚡ ";
            text += getBatteryIcon(UPower.displayDevice.percentage * 100);
            return text;
        }

        font {
            family: "FiraMono Nerd Font"
            pixelSize: 14
            bold: false
        }
    }
}
