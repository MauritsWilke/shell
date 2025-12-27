import Quickshell
import Quickshell.Io
import QtQuick

// TODO Battery, extract to component later
import Quickshell.Services.UPower

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  Text {
    id: power

    anchors {
      left: parent
      verticalCenter: parent.verticalCenter
    }


    text: {
        switch (UPower.displayDevice.state) {
            case UPowerDeviceState.Charging:
                return "⚡ " + UPower.displayDevice.percentage * 100 + "%"
            case UPowerDeviceState.Discharging:
                return UPower.displayDevice.percentage * 100 + "%"
            case UPowerDeviceState.FullyCharged:
                return "✓ 100%"
        }
    }
}

  Text {
    id: clock
    anchors.centerIn: parent

    Process {
      id: dateProc

      command: ["date"]
      running: true

      stdout: StdioCollector {
        onStreamFinished: clock.text = this.text
      }
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: dateProc.running = true
    }
  }
}