import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    property color black: "#000000"
    property color blue: "#3e8fb0"
    property color white: "#ffffff"
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 16

    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 36
    color: root.black

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: 9

            Rectangle {
                width: 34
                height: 36
                color: isActive ? root.blue : "transparent"
                border.color: isActive ? root.blue : "transparent"
                border.width: 5

                property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1) ?? null
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                property bool notEmpty: workspace !== null

                Rectangle {
                    height: 3
                    width: 31
                    color: parent.isActive ? root.blue : (parent.notEmpty ? root.blue : "transparent")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                }

                Text {
                    anchors.centerIn: parent
                    text: index + 1
                    color: isActive ? root.black : root.white
                    font {
                        family: root.fontFamily
                        pixelSize: root.fontSize
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

    }
}
