import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    
    property bool active: visible

    // Enforce matching dimensions across layout contexts
    Layout.preferredWidth: Config.powerPopupWidth * Config.generalScale
    Layout.fillWidth: true
    spacing: 2 * Config.generalScale

    signal close

    // Set initial structural item focus target when menu becomes active
    onActiveChanged: {
        if (active) {
            shutdownButton.forceActiveFocus();
        }
    }

    IconButton {
        id: suspendButton

        Layout.fillWidth: true
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight * Config.generalScale
        preferredWidth: Config.powerPopupWidth * Config.generalScale

        enabled: sddm.canSuspend
        icon: Config.getIcon("power-suspend.svg")
        contentColor: Config.menuAreaPopupsContentColor
        activeContentColor: Config.menuAreaPopupsActiveContentColor
        fontFamily: Config.menuAreaPopupsFontFamily
        backgroundColor: "transparent"
        activeBackgroundColor: Config.menuAreaPopupsActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupsIconSize
        fontSize: Config.menuAreaPopupsFontSize
        label: textConstants.suspend

        onClicked: {
            selector.close();
            sddm.suspend();
        }

        KeyNavigation.up: shutdownButton
        KeyNavigation.down: rebootButton
    }

    IconButton {
        id: rebootButton

        Layout.fillWidth: true
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight * Config.generalScale
        preferredWidth: Config.powerPopupWidth * Config.generalScale

        enabled: sddm.canReboot
        icon: Config.getIcon("power-reboot.svg")
        contentColor: Config.menuAreaPopupsContentColor
        activeContentColor: Config.menuAreaPopupsActiveContentColor
        fontFamily: Config.menuAreaPopupsFontFamily
        backgroundColor: "transparent"
        activeBackgroundColor: Config.menuAreaPopupsActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupsIconSize
        fontSize: Config.menuAreaPopupsFontSize
        label: textConstants.reboot

        onClicked: {
            selector.close();
            sddm.reboot();
        }

        KeyNavigation.up: suspendButton
        KeyNavigation.down: shutdownButton
    }

    IconButton {
        id: shutdownButton

        Layout.fillWidth: true
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight * Config.generalScale
        preferredWidth: Config.powerPopupWidth * Config.generalScale

        enabled: sddm.canPowerOff
        icon: Config.getIcon("power.svg")
        contentColor: Config.menuAreaPopupsContentColor
        activeContentColor: Config.menuAreaPopupsActiveContentColor
        fontFamily: Config.menuAreaPopupsFontFamily
        backgroundColor: "transparent"
        activeBackgroundColor: Config.menuAreaPopupsActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupsIconSize
        fontSize: Config.menuAreaPopupsFontSize
        label: textConstants.shutdown

        onClicked: {
            selector.close();
            sddm.powerOff();
        }

        KeyNavigation.up: rebootButton
        KeyNavigation.down: suspendButton
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
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