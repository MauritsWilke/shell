import Quickshell
import Quickshell.Io
import QtQuick

import "Battery"

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  // Text {
  //   id: power

  //   anchors {
  //     left: parent
  //     verticalCenter: parent.verticalCenter
  //   }


  //   text: {
  //     switch (UPower.displayDevice.state) {
  //         case UPowerDeviceState.Charging:
  //             return "⚡ " + UPower.displayDevice.percentage * 100 + "%"
  //         case UPowerDeviceState.Discharging:
  //             return UPower.displayDevice.percentage * 100 + "%"
  //         case UPowerDeviceState.FullyCharged:
  //             return "✓ 100%"
  //     }
  //   }
  // }
  
  Item {
    anchors.centerIn: parent
    Clock { }
  }

  Item {
    anchors.centerIn: parent

    Battery { }
  }
}