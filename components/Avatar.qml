import QtQuick
import QtQuick.Effects
import QtQuick.Controls

Rectangle {
    id: avatar
    
    property string shape: Config.avatarShape
    property string source: ""
    property bool active: false
    property int squareRadius: (shape === "circle") ? (width / 2) : (Config.avatarBorderRadius === 0 ? 1 : Config.avatarBorderRadius * Config.generalScale)
    property bool drawStroke: (active && Config.avatarActiveBorderSize > 0) || (!active && Config.avatarInactiveBorderSize > 0)
    property color strokeColor: active ? Config.avatarActiveBorderColor : Config.avatarInactiveBorderColor
    property int strokeSize: active ? (Config.avatarActiveBorderSize * Config.generalScale) : (Config.avatarInactiveBorderSize * Config.generalScale)
    property string tooltipText: ""
    property bool showTooltip: false

    signal clicked
    signal clickedOutside

    radius: squareRadius
    color: "transparent"
    antialiasing: true

    // Persistent Color Fill Base Underlay Layer
    Rectangle {
        anchors.fill: parent
        radius: avatar.squareRadius
        color: Config.passwordInputBackgroundColor
        opacity: Config.passwordInputBackgroundOpacity
    }

    Image {
        id: faceImage
        source: avatar.source
        anchors.fill: parent
        mipmap: true
        antialiasing: true
        visible: false
        smooth: true
        fillMode: Image.PreserveAspectCrop
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter

        onStatusChanged: {
            if (status === Image.Error) {
                source = Config.getIcon("user-default");
                faceEffects.colorization = 1.0;
            }
        }
    }

    // Advanced Clipping Mask Assembly Block
    MultiEffect {
        id: faceEffects
        anchors.fill: parent
        source: faceImage
        antialiasing: true
        maskEnabled: true
        maskSource: faceImageMask
        maskSpreadAtMin: 1.0
        maskThresholdMax: 1.0
        maskThresholdMin: 0.5
        colorization: 0.0
        colorizationColor: avatar.strokeColor === Config.passwordInputBackgroundColor && (1.0 - Config.passwordInputBackgroundOpacity < 0.3) ? Config.passwordInputContentColor : avatar.strokeColor
    }

    Item {
        id: faceImageMask
        anchors.fill: parent
        layer.enabled: true
        layer.smooth: true
        visible: false

        Rectangle {
            anchors.fill: parent
            radius: avatar.squareRadius
            color: "black" // High opacity alpha anchor for alpha-blending logic
        }
    }

    // Foreground Stroke Frame Overlay Layer (Placed over MultiEffect to avoid clipping pixelation)
    Rectangle {
        anchors.fill: parent
        radius: avatar.squareRadius
        color: "transparent"
        border.width: avatar.drawStroke ? avatar.strokeSize : 0
        border.color: avatar.strokeColor
        antialiasing: true
        visible: avatar.drawStroke
    }

    // Precise Geometric Bounds Input Surface Mapping Handler
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor

        function isCursorInsideAvatar() {
            if (!mouseArea.containsMouse)
                return false;
            if (avatar.shape !== "circle")
                return true;

            // Mathematical calculation mapping circle radius limits cleanly
            var centerX = width / 2;
            var centerY = height / 2;
            var dx = (mouseArea.mouseX - centerX) / centerX;
            var dy = (mouseArea.mouseY - centerY) / centerY;

            return (dx * dx + dy * dy) <= 1.0;
        }

        onReleased: function (mouse) {
            var isInside = isCursorInsideAvatar();
            if (isInside) {
                avatar.clicked();
            } else {
                avatar.clickedOutside();
            }
            mouse.accepted = isInside;
        }

        function updateHover() {
            cursorShape = isCursorInsideAvatar() ? Qt.PointingHandCursor : Qt.ArrowCursor;
        }

        onMouseXChanged: updateHover()
        onMouseYChanged: updateHover()

        ToolTip {
            id: toolTipControl
            parent: avatar
            enabled: Config.tooltipsEnable && !Config.tooltipsDisableUser && avatar.tooltipText !== ""
            visible: enabled && (avatar.showTooltip || mouseArea.isCursorInsideAvatar())
            delay: 300
            y: -height - 10
            x: (parent.width - width) / 2
            
            contentItem: Text {
                id: tooltipTextElement
                font.family: Config.tooltipsFontFamily
                font.pixelSize: Config.tooltipsFontSize * Config.generalScale
                text: avatar.tooltipText
                color: Config.tooltipsContentColor
            }
            
            background: Rectangle {
                implicitWidth: tooltipTextElement.implicitWidth + 16
                implicitHeight: tooltipTextElement.implicitHeight + 8
                color: Config.tooltipsBackgroundColor
                opacity: Config.tooltipsBackgroundOpacity
                border.width: 0
                radius: Config.tooltipsBorderRadius * Config.generalScale
            }
        }
    }
}