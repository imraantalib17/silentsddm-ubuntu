import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

ColumnLayout {
    id: selector
    
    // Explicit sizing bounds to prevent Layout calculations collapse
    width: (Config.sessionPopupWidth - Config.menuAreaPopupsPadding * 2) * Config.generalScale
    Layout.preferredWidth: width

    signal sessionChanged(sessionIndex: int, iconPath: string, label: string)
    signal close

    property int currentSessionIndex: (sessionModel && sessionModel.lastIndex >= 0) ? sessionModel.lastIndex : 0
    property string sessionName: ""
    property string sessionIconPath: ""
    readonly property bool active: visible

    function getSessionIcon(name) {
        var available_session_icons = ["hyprland", "plasma", "gnome", "ubuntu", "sway", "awesome", "qtile", "i3", "bspwm", "dwm", "xfce", "cinnamon", "niri"];
        var lowerName = name ? name.toLowerCase() : "";
        for (var i = 0; i < available_session_icons.length; i++) {
            if (lowerName.includes(available_session_icons[i]))
                return "../icons/sessions/" + available_session_icons[i] + ".svg";
        }
        return "../icons/sessions/default.svg";
    }

    onActiveChanged: {
        if (active) {
            sessionList.forceActiveFocus();
        }
    }

    ListView {
        id: sessionList
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: Math.min((sessionModel ? sessionModel.rowCount() : 0) * (Config.menuAreaPopupsItemHeight * Config.generalScale + spacing), Config.menuAreaPopupsMaxHeight * Config.generalScale)
        orientation: ListView.Vertical
        interactive: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        spacing: Config.menuAreaPopupsSpacing || 2
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0

        ScrollBar.vertical: ScrollBar {
            id: scrollbar
            policy: Config.menuAreaPopupsDisplayScrollbar && sessionList.contentHeight > sessionList.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            contentItem: Rectangle {
                id: scrollbarBackground
                implicitWidth: 5 * Config.generalScale
                radius: 5 * Config.generalScale
                color: Config.menuAreaPopupsContentColor
                opacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
            }
        }

        model: sessionModel
        currentIndex: selector.currentSessionIndex
        
        onCurrentIndexChanged: {
            if (currentIndex >= 0 && currentIndex < sessionModel.rowCount()) {
                var session_name = sessionModel.data(sessionModel.index(currentIndex, 0), 260) || "";
                selector.currentSessionIndex = currentIndex;
                selector.sessionName = session_name;
                selector.sessionIconPath = getSessionIcon(session_name);
                selector.sessionChanged(currentIndex, selector.sessionIconPath, session_name);
            }
        }

        delegate: Rectangle {
            id: delegateItem
            width: scrollbar.visible ? (sessionList.width - 8 * Config.generalScale) : sessionList.width
            height: Config.menuAreaPopupsItemHeight * Config.generalScale
            color: "transparent"
            radius: Config.menuAreaButtonsBorderRadius * Config.generalScale

            // Option Active/Hover Highlight Base Layer
            Rectangle {
                anchors.fill: parent
                color: Config.menuAreaPopupsActiveOptionBackgroundColor
                opacity: index === sessionList.currentIndex ? Config.menuAreaPopupsActiveOptionBackgroundOpacity : (itemMouseArea.containsMouse ? (Config.menuAreaPopupsActiveOptionBackgroundOpacity * 0.6) : 0.0)
                radius: Config.menuAreaButtonsBorderRadius * Config.generalScale

                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation { duration: 150 }
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 6 * Config.generalScale
                anchors.rightMargin: 6 * Config.generalScale
                spacing: 8 * Config.generalScale

                Rectangle {
                    Layout.preferredWidth: parent.height * 0.6
                    Layout.preferredHeight: parent.height * 0.6
                    Layout.alignment: Qt.AlignVCenter
                    color: "transparent"

                    Image {
                        id: sessionIcon
                        anchors.centerIn: parent
                        source: selector.getSessionIcon(model.name)
                        width: Config.menuAreaPopupsIconSize * Config.generalScale
                        height: Config.menuAreaPopupsIconSize * Config.generalScale
                        sourceSize: Qt.size(width, height)
                        fillMode: Image.PreserveAspectFit
                        visible: false
                    }
                    
                    MultiEffect {
                        id: sessionIconEffect
                        source: sessionIcon
                        anchors.fill: sessionIcon
                        colorization: 1.0
                        colorizationColor: index === sessionList.currentIndex || itemMouseArea.containsMouse ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                        antialiasing: true
                    }
                }

                Text {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    elide: Text.ElideRight
                    text: model.name || ""
                    color: index === sessionList.currentIndex || itemMouseArea.containsMouse ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                    font.pixelSize: Config.menuAreaPopupsFontSize * Config.generalScale
                    font.family: Config.menuAreaPopupsFontFamily
                }
            }

            MouseArea {
                id: itemMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    // FIX: Direct back-assignment to backend model ensures clicks never drop
                    sessionList.currentIndex = index;
                    if (sessionModel) {
                        sessionModel.currentIndex = index;
                    }
                }
            }
        }
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Down) {
            if (sessionModel && sessionModel.rowCount() > 0) {
                var nextIndex = (sessionList.currentIndex + 1) % sessionModel.rowCount();
                sessionList.currentIndex = nextIndex;
                sessionModel.currentIndex = nextIndex;
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Up) {
            if (sessionModel && sessionModel.rowCount() > 0) {
                var prevIndex = (sessionList.currentIndex + sessionModel.rowCount() - 1) % sessionModel.rowCount();
                sessionList.currentIndex = prevIndex;
                sessionModel.currentIndex = prevIndex;
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
            selector.close();
            event.accepted = true;
        } else if (event.key === Qt.Key_Escape) {
            selector.close();
            event.accepted = true;
        } else {
            event.accepted = false;
        }
    }
}