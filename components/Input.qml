import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: input

    signal accepted

    property string placeholder: ""
    property alias input: textField
    property bool isPassword: false
    property bool splitBorderRadius: false
    property alias text: textField.text
    property string icon: ""
    property bool enabled: true
    property int inputMethodHints: Qt.ImhNone

    width: Config.passwordInputWidth * Config.generalScale
    height: Config.passwordInputHeight * Config.generalScale

    TextField {
        id: textField
        anchors.fill: parent
        inputMethodHints: input.inputMethodHints
        color: Config.passwordInputContentColor
        enabled: input.enabled
        echoMode: input.isPassword ? TextInput.Password : TextInput.Normal
        passwordCharacter: Config.passwordInputMaskedCharacter
        activeFocusOnTab: true
        selectByMouse: true
        verticalAlignment: TextField.AlignVCenter
        font.family: Config.passwordInputFontFamily
        font.pixelSize: Math.max(8, Config.passwordInputFontSize * Config.generalScale)
        
        // Dynamic text styling padding calculation
        leftPadding: Config.passwordInputDisplayIcon ? (Config.passwordInputHeight * Config.generalScale) : 12
        rightPadding: 12
        onAccepted: input.accepted()

        // Background Layer Color/Opacity Fill
        background: Rectangle {
            anchors.fill: parent
            color: Config.passwordInputBackgroundColor
            opacity: Config.passwordInputBackgroundOpacity
            topLeftRadius: Config.passwordInputBorderRadiusLeft * Config.generalScale
            bottomLeftRadius: Config.passwordInputBorderRadiusLeft * Config.generalScale
            topRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.generalScale : Config.passwordInputBorderRadiusLeft * Config.generalScale
            bottomRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.generalScale : Config.passwordInputBorderRadiusLeft * Config.generalScale
        }

        // Structural Border Overlay
        Rectangle {
            anchors.fill: parent
            border.width: Config.passwordInputBorderSize * Config.generalScale
            border.color: Config.passwordInputBorderColor
            color: "transparent"
            topLeftRadius: Config.passwordInputBorderRadiusLeft * Config.generalScale
            bottomLeftRadius: Config.passwordInputBorderRadiusLeft * Config.generalScale
            topRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.generalScale : Config.passwordInputBorderRadiusLeft * Config.generalScale
            bottomRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.generalScale : Config.passwordInputBorderRadiusLeft * Config.generalScale
        }

        // Icon Housing Overlay Component
        Rectangle {
            id: iconContainer
            color: "transparent"
            visible: Config.passwordInputDisplayIcon
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: height

            Image {
                id: innerIcon
                source: input.icon
                anchors.centerIn: parent
                width: Math.max(1, Config.passwordInputIconSize * Config.generalScale)
                height: width
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
                visible: false
                opacity: input.enabled ? 1.0 : 0.3
                
                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation { duration: 250 }
                }
            }

            MultiEffect {
                source: innerIcon
                anchors.fill: innerIcon
                colorization: 1.0
                colorizationColor: textField.color
                visible: innerIcon.visible || true
            }
        }

        // Floating Placeholder Prompt Typography label
        Text {
            id: placeholderLabel
            anchors.left: parent.left
            anchors.leftMargin: textField.leftPadding
            anchors.verticalCenter: parent.verticalCenter
            visible: textField.text.length === 0 && (!textField.preeditText || textField.preeditText.length === 0)
            text: input.placeholder
            color: textField.color
            opacity: 0.5 // Standard legible alpha blend for descriptive prompts
            font.pixelSize: textField.font.pixelSize
            font.family: textField.font.family
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: textField.verticalAlignment
            font.italic: true
        }
    }
}