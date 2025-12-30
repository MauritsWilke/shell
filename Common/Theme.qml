pragma Singleton
import Quickshell
import QtQuick

// https://github.com/sainnhe/everforest
Singleton {
    id: theme
    property string mode: "dark"

    function getVariant(light, dark): string {
        return mode == "dark" ? dark : light;
    }

    QtObject {
        id: dark

        property string foreground: "#D3C6AA"
        property string red: "#E67E80"
        property string yellow: "#DBBC7F"
        property string green: "#A7C080"
        property string blue: "#7FBBB3"
        property string purple: "#D699B6"
        property string aqua: "#83C092"
        property string orange: "#E69875"

        property string statusline1: "#A7C080"
        property string statusline2: "#D3C6AA"
        property string statusline3: "#E67E80"

        property string grey0: "#7A8478"
        property string grey1: "#859289"
        property string grey2: "#9DA9A0"

        property string backgroundDim: "#1E2326"
        property string background0: "#272E33"
        property string background1: "#2E383C"
        property string background2: "#374145"
        property string background3: "#414B50"
        property string background4: "#495156"
        property string background5: "#4F5B58"
        property string backgroundRed: "#493B40"
        property string backgroundYellow: "#45443C"
        property string backgroundGreen: "#3C4841"
        property string backgroundBlue: "#384B55"
        property string backgroundPurple: "#463F48"
        property string backgroundVisual: "#4C3743"
    }

    QtObject {
        id: light

        property string foreground: "#5C6A72"
        property string red: "#F85552"
        property string yellow: "#DFA000"
        property string green: "#8DA101"
        property string blue: "#3A94C5"
        property string purple: "#DF69BA"
        property string aqua: "#35A77C"
        property string orange: "#F57D26"

        property string statusline1: "#93B259"
        property string statusline2: "#708089"
        property string statusline3: "#E66868"

        property string grey0: "#A6B0A0"
        property string grey1: "#939F91"
        property string grey2: "#829181"

        property string backgroundDim: "#F2EFDF"
        property string background0: "#FFFBEF"
        property string background1: "#F8F5E4"
        property string background2: "#F2EFDF"
        property string background3: "#EDEADA"
        property string background4: "#E8E5D5"
        property string background5: "#BEC5B2"
        property string backgroundRed: "#FFE7DE"
        property string backgroundYellow: "#FEF2D5"
        property string backgroundGreen: "#F3F5D9"
        property string backgroundBlue: "#ECF5ED"
        property string backgroundPurple: "#FCECED"
        property string backgroundVisual: "#F0F2D4"
    }

    // readonly property string foreground: mode === "dark" ? dark.foreground : light.foreground
    readonly property string foreground: getVariant(light.foreground, dark.foreground)
    readonly property string red: getVariant(light.red, dark.red)
    readonly property string yellow: getVariant(light.yellow, dark.yellow)
    readonly property string green: getVariant(light.green, dark.green)
    readonly property string blue: getVariant(light.blue, dark.blue)
    readonly property string purple: getVariant(light.purple, dark.purple)
    readonly property string aqua: getVariant(light.aqua, dark.aqua)
    readonly property string orange: getVariant(light.orange, dark.orange)

    readonly property string statusline1: getVariant(light.statusline1, dark.statusline1)
    readonly property string statusline2: getVariant(light.statusline2, dark.statusline2)
    readonly property string statusline3: getVariant(light.statusline3, dark.statusline3)

    readonly property string grey0: getVariant(light.grey0, dark.grey0)
    readonly property string grey1: getVariant(light.grey1, dark.grey1)
    readonly property string grey2: getVariant(light.grey2, dark.grey2)

    readonly property string backgroundDim: getVariant(light.backgroundDim, dark.backgroundDim)
    readonly property string background0: getVariant(light.background0, dark.background0)
    readonly property string background1: getVariant(light.background1, dark.background1)
    readonly property string background2: getVariant(light.background2, dark.background2)
    readonly property string background3: getVariant(light.background3, dark.background3)
    readonly property string background4: getVariant(light.background4, dark.background4)
    readonly property string background5: getVariant(light.background5, dark.background5)
    readonly property string backgroundRed: getVariant(light.backgroundRed, dark.backgroundRed)
    readonly property string backgroundYellow: getVariant(light.backgroundYellow, dark.backgroundYellow)
    readonly property string backgroundGreen: getVariant(light.backgroundGreen, dark.backgroundGreen)
    readonly property string backgroundBlue: getVariant(light.backgroundBlue, dark.backgroundBlue)
    readonly property string backgroundPurple: getVariant(light.backgroundPurple, dark.backgroundPurple)
    readonly property string backgroundVisual: getVariant(light.backgroundVisual, dark.backgroundVisual)
}
