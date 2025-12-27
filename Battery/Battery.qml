import Quickshell
import Quickshell.Io
import QtQuick

import Quickshell.Services.UPower

Text {
  id: power

  anchors.fill: parent

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
