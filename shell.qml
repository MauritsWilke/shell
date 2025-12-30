import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

PanelWindow {
    id: root
    visible: true

    // Theme
    property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "FiraMono Nerd Font"
    property int fontSize: 14

    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0
    property var wifiStrength: 0
    property string wifiGrade: getWifiGrade(wifiStrength)

    function getWifiGrade(percentage) {
        if (percentage >= 80)
            return "A";
        if (percentage >= 60)
            return "B";
        if (percentage >= 40)
            return "C";
        if (percentage >= 20)
            return "D";
        if (percentage > 0)
            return "F";
        return "Unknown";
    }

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

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                if (root.lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)));
                }
                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var total = parseInt(parts[1]) || 1;
                var used = parseInt(parts[2]) || 0;
                memUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: wifiProc
        command: ["sh", "-c", "iwctl station wlan0 show | grep 'AverageRSSI' | awk '{print $2}'"]

        stdout: SplitParser {
            onRead: line => {
                const rssi = parseInt(line);
                if (!isNaN(rssi)) {
                    const percentage = Math.max(0, Math.min(100, rssi * -1));
                    wifiStrength = Math.round(percentage);
                }
            }
        }

        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
            wifiProc.running = true;
        }
    }

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 34
    color: root.colBg

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Item {
            Layout.fillWidth: true
        }

        // BAT
        Text {
            text: {
                switch (UPower.displayDevice.state) {
                case UPowerDeviceState.Charging:
                    return "⚡ " + getBatteryIcon(UPower.displayDevice.percentage * 100);
                default:
                    return getBatteryIcon(UPower.displayDevice.percentage * 100);
                }
            }

            color: root.colBlue
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
        }

        Rectangle {
            width: 1
            height: 16
            color: root.colMuted
        }

        // CPU
        Text {
            text: "CPU: " + root.cpuUsage + "%"
            color: root.colYellow
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
        }

        Rectangle {
            width: 1
            height: 16
            color: root.colMuted
        }

        // MEM
        Text {
            text: "󰍛  " + root.memUsage + "%"
            color: root.colCyan
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
        }

        Rectangle {
            width: 1
            height: 16
            color: root.colMuted
        }

        Text {
            id: clock
            color: root.colBlue
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
            text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            }
        }

        Rectangle {
            width: 1
            height: 16
            color: root.colMuted
        }

        Text {
            id: wifiText
            text: "WiFi: " + root.wifiGrade
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
            color: root.colYellow
        }
    }
}
