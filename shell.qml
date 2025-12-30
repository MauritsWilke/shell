import Quickshell // for PanelWindow
import QtQuick // for Text

import qs.Components

PanelWindow {
    // Make it stick to top, left and right
    // default is centred and min-size
    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"

    margins {
        left: 8
        right: 8
        top: 4
        bottom: 0 // Niri already takes care of this
    }

    implicitHeight: 30

    Clock {}

    Battery {}
}
