import "root:/services"
import Quickshell.Io
import QtQuick

JsonObject {
    property color colour: Colours.alpha(Colours.palette.m3surface, false)
    property int thickness: 1
    // property color colour: "transparent"
    property int rounding: Appearance.rounding.large
    // property int thickness: Appearance.padding.normal
}
