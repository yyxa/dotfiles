import "root:/widgets"
import "root:/services"
import "root:/config"
import "root:/modules/bar/popouts" as BarPopouts
import "components"
import "components/workspaces"
import Quickshell
import QtQuick

Item {
    id: root

    required property ShellScreen screen
    required property BarPopouts.Wrapper popouts

    function checkPopout(x: real): void {
        const spacing = Appearance.spacing.small;
        const aw = activeWindow.child;
        const awx = activeWindow.x + aw.x;

        const tx = tray.x;
        const tw = tray.implicitWidth;
        const trayItems = tray.items;

        const n = statusIconsInner.network;
        const nx = statusIcons.x + statusIconsInner.x + n.x - spacing / 2;

        const bls = statusIcons.x + statusIconsInner.x + statusIconsInner.bs - spacing / 2;
        const ble = statusIcons.x + statusIconsInner.x + statusIconsInner.be + spacing / 2;

        const b = statusIconsInner.battery;
        const bx = statusIcons.x + statusIconsInner.x + b.x - spacing / 2;

        if (x >= awx && x <= awx + aw.implicitWidth) {
            popouts.currentName = "activewindow";
            popouts.currentCenter = Qt.binding(() => activeWindow.x + aw.x + aw.implicitWidth / 2);
            popouts.hasCurrent = true;
        } else if (x > tx && x < tx + tw) {
            const index = Math.floor(((x - tx) / tw) * trayItems.count);
            const item = trayItems.itemAt(index);

            popouts.currentName = `traymenu${index}`;
            popouts.currentCenter = Qt.binding(() => tray.x + item.x + item.implicitWidth / 2);
            popouts.hasCurrent = true;
        } else if (x >= nx && x <= nx + n.implicitWidth + spacing) {
            popouts.currentName = "network";
            popouts.currentCenter = Qt.binding(() => statusIcons.x + statusIconsInner.x + n.x + n.implicitWidth / 2);
            popouts.hasCurrent = true;
        } else if (x >= bls && x <= ble) {
            popouts.currentName = "bluetooth";
            popouts.currentCenter = Qt.binding(() => statusIcons.x + statusIconsInner.x + statusIconsInner.bs + (statusIconsInner.be - statusIconsInner.bs) / 2);
            popouts.hasCurrent = true;
        } else if (x >= bx && x <= bx + b.implicitWidth + spacing) {
            popouts.currentName = "battery";
            popouts.currentCenter = Qt.binding(() => statusIcons.x + statusIconsInner.x + b.x + b.implicitWidth / 2);
            popouts.hasCurrent = true;
        } else {
            popouts.hasCurrent = false;
        }
    }

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    implicitHeight: child.implicitHeight + Config.border.thickness * 2

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        onPositionChanged: event => {
            checkPopout(event.x);
        }
        
        onExited: {
            popouts.hasCurrent = false;
        }
    }

    Item {
        id: child

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        implicitHeight: Math.max(workspaces.implicitHeight, activeWindow.implicitHeight, tray.implicitHeight, clock.implicitHeight, statusIcons.implicitHeight, power.implicitHeight)

        StyledRect {
            id: workspaces

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Appearance.spacing.normal

            radius: Appearance.rounding.full
            color: Colours.palette.m3surfaceContainer

            implicitWidth: workspacesInner.implicitWidth + Appearance.padding.small * 2
            implicitHeight: workspacesInner.implicitHeight + Appearance.padding.small * 2

            MouseArea {
                anchors.fill: parent
                anchors.topMargin: -Config.border.thickness
                anchors.bottomMargin: -Config.border.thickness

                onWheel: event => {
                    const activeWs = Hyprland.activeClient?.workspace?.name;
                    if (activeWs?.startsWith("special:"))
                        Hyprland.dispatch(`togglespecialworkspace ${activeWs.slice(8)}`);
                    else if (event.angleDelta.y < 0 || Hyprland.activeWsId > 1)
                        Hyprland.dispatch(`workspace r${event.angleDelta.y > 0 ? "-" : "+"}1`);
                }
            }

            Workspaces {
                id: workspacesInner

                anchors.centerIn: parent
            }
        }

        ActiveWindow {
            id: activeWindow

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: workspaces.right
            anchors.right: tray.left
            anchors.margins: Appearance.spacing.large

            monitor: Brightness.getMonitorForScreen(root.screen)
        }

        Tray {
            id: tray

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: clock.left
            anchors.rightMargin: Appearance.spacing.larger
        }

        Clock {
            id: clock

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: statusIcons.left
            anchors.rightMargin: Appearance.spacing.normal
        }

        StyledRect {
            id: statusIcons

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: power.left
            anchors.rightMargin: Appearance.spacing.normal

            radius: Appearance.rounding.full
            color: Colours.palette.m3surfaceContainer

            implicitWidth: statusIconsInner.implicitWidth + Appearance.padding.normal * 2

            StatusIcons {
                id: statusIconsInner

                anchors.centerIn: parent
            }
        }

        Power {
            id: power

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: Appearance.padding.large
        }
    }
}
