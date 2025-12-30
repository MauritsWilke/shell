import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

Rectangle {
    function getTime() {
        return Qt.formatDateTime(new Date(), "HH:mm:ss");
    }

    height: parent.height
    anchors.left: parent

    color: "red"

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

    Text {
        id: battery
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent

        text: {
            switch (UPower.displayDevice.state) {
            case UPowerDeviceState.Charging:
                return "⚡ " + getBatteryIcon(UPower.displayDevice.percentage * 100);
            default:
                return getBatteryIcon(UPower.displayDevice.percentage * 100);
            }
        }

        font {
            family: "FiraMono Nerd Font"
            pixelSize: 14
            bold: false
        }
    }
}
