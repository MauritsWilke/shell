// import Quickshell
// import Quickshell.Io
// import QtQuick

// import "Battery"

// PanelWindow {
//   anchors {
//     top: true
//     left: true
//     right: true
//   }

//   implicitHeight: 30

//   // Text {
//   //   id: power

//   //   anchors {
//   //     left: parent
//   //     verticalCenter: parent.verticalCenter
//   //   }


//   //   text: {
//   //     switch (UPower.displayDevice.state) {
//   //         case UPowerDeviceState.Charging:
//   //             return "⚡ " + UPower.displayDevice.percentage * 100 + "%"
//   //         case UPowerDeviceState.Discharging:
//   //             return UPower.displayDevice.percentage * 100 + "%"
//   //         case UPowerDeviceState.FullyCharged:
//   //             return "✓ 100%"
//   //     }
//   //   }
//   // }
  
//   Item {
//     anchors.centerIn: parent
//     Clock { }
//   }

//   Item {
//     anchors.centerIn: parent

//     Battery { }
//   }
// }
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import Quickshell.Widgets

PanelWindow {
  id: root

  // Theme
  property color colBg: "#1a1b26"
  property color colFg: "#a9b1d6"
  property color colMuted: "#444b6a"
  property color colCyan: "#0db9d7"
  property color colBlue: "#7aa2f7"
  property color colYellow: "#e0af68"
  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 14

  property int cpuUsage: 0
  property int memUsage: 0
  property var lastCpuIdle: 0
  property var lastCpuTotal: 0
  property var wifiStrength: 0
  property string wifiGrade: getWifiGrade(wifiStrength) 
  function getWifiGrade(percentage) {  
    if (percentage >= 80) return "A";  
    if (percentage >= 60) return "B";  
    if (percentage >= 40) return "C";  
    if (percentage >= 20) return "D";  
    if (percentage > 0) return "F";  
    return "Unknown";  
  }  

  Process {
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]
    stdout: SplitParser {
        onRead: data => {
          if (!data) return
          var p = data.trim().split(/\s+/)
          var idle = parseInt(p[4]) + parseInt(p[5])
          var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
          if (lastCpuTotal > 0) {
              cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
          }
          lastCpuTotal = total
          lastCpuIdle = idle
        }
      }
    Component.onCompleted: running = true
  }

  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        memUsage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }

  Process {  
    id: wifiProc
    command: ["sh", "-c", "iwctl station wlan0 show | grep 'AverageRSSI' | awk '{print $2}'"]  
      
    stdout: SplitParser {  
      onRead: line => {  
        console.log(line)
        const rssi = parseInt(line);  
        if (!isNaN(rssi)) {  
          const percentage = Math.max(0, Math.min(100, rssi * -1))
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
        cpuProc.running = true
        memProc.running = true
        wifiProc.running = true
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

    Item { Layout.fillWidth: true }

    // BAT
    Text {
      text: {
        switch (UPower.displayDevice.state) {
          case UPowerDeviceState.Charging:
            return "⚡ " + Math.round(UPower.displayDevice.percentage * 100) + "%"
          case UPowerDeviceState.Discharging:
            return Math.round(UPower.displayDevice.percentage * 100) + "%"
          case UPowerDeviceState.FullyCharged:
            return "✓ 100%"
        }
      }

      color: root.colBlue
      font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
    }

    Rectangle { width: 1; height: 16; color: root.colMuted }

    // CPU
    Text {
      text: "CPU: " + cpuUsage + "%"
      color: root.colYellow
      font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
    }

    Rectangle { width: 1; height: 16; color: root.colMuted }

    // MEM
    Text {
      text: "Mem: " + memUsage + "%"
      color: root.colCyan
      font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
    }

    Rectangle { width: 1; height: 16; color: root.colMuted }

    Text {
        id: clock
        color: root.colBlue
        font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
        text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
        }
    }
    
    Rectangle { width: 1; height: 16; color: root.colMuted }

    Text {  
      id: wifiText  
      text: "WiFi: " + wifiGrade
      font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
      color: root.colYellow
    }

  }
}

