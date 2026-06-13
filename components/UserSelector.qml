import QtQuick
import QtQuick.Controls
import SddmComponents

Item {
    id: selector

    signal openUserList
    signal closeUserList
    signal userChanged(userIndex: int, username: string, userRealName: string, userIcon: string, needsPassword: bool)

    property bool listUsers: false
    property string orientation: "horizontal"
    property bool isDragging: false

    function prevUser() {
        if (userModel.rowCount() > 1) {
            userList.currentIndex = (userList.currentIndex + userModel.rowCount() - 1) % userModel.rowCount();
        }
    }
    
    function nextUser() {
        if (userModel.rowCount() > 1) {
            userList.currentIndex = (userList.currentIndex + 1) % userModel.rowCount();
        }
    }

    ListView {
        id: userList
        anchors.fill: parent
        orientation: selector.orientation === "horizontal" ? ListView.Horizontal : ListView.Vertical
        spacing: 12 * Config.generalScale
        interactive: false
        boundsBehavior: Flickable.StopAtBounds

        // Safe evaluation of highlighting engine centers
        preferredHighlightBegin: selector.orientation === "horizontal" ? 
            ((parent.width - (Config.avatarActiveSize * Config.generalScale)) / 2) : 
            ((parent.height - (Config.avatarActiveSize * Config.generalScale)) / 2)
        preferredHighlightEnd: preferredHighlightBegin
        highlightRangeMode: ListView.StrictlyEnforceRange
        
        // Dynamic padding to support seamless centering profiles
        leftMargin: selector.orientation === "horizontal" ? preferredHighlightBegin : 0
        rightMargin: selector.orientation === "horizontal" ? preferredHighlightBegin : 0
        topMargin: selector.orientation === "horizontal" ? 0 : preferredHighlightBegin
        bottomMargin: selector.orientation === "horizontal" ? 0 : preferredHighlightBegin

        highlightMoveDuration: 200
        highlightResizeDuration: 200
        highlightMoveVelocity: -1
        highlightFollowsCurrentItem: true

        model: userModel
        currentIndex: userModel.lastIndex
        
        onCurrentIndexChanged: {
            if (currentIndex >= 0 && currentIndex < userModel.rowCount()) {
                var username = userModel.data(userModel.index(currentIndex, 0), 257) || "";
                var userRealName = userModel.data(userModel.index(currentIndex, 0), 258) || "";
                var userIcon = userModel.data(userModel.index(currentIndex, 0), 260) || "";
                var needsPasswd = userModel.data(userModel.index(currentIndex, 0), 261) !== false;

                sddm.currentUser = username;
                selector.userChanged(currentIndex, username, userRealName, userIcon, needsPasswd);
            }
        }

        delegate: Rectangle {
            id: delegateRoot
            width: index === userList.currentIndex ? (Config.avatarActiveSize * Config.generalScale) : (Config.avatarInactiveSize * Config.generalScale)
            height: index === userList.currentIndex ? (Config.avatarActiveSize * Config.generalScale) : (Config.avatarInactiveSize * Config.generalScale)
            
            anchors {
                verticalCenter: selector.orientation === "horizontal" ? parent.verticalCenter : undefined
                horizontalCenter: selector.orientation === "horizontal" ? undefined : parent.horizontalCenter
            }
            color: "transparent"
            visible: selector.listUsers || index === userList.currentIndex

            Behavior on width {
                enabled: Config.enableAnimations
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
            Behavior on height {
                enabled: Config.enableAnimations
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
            
            opacity: selector.listUsers || index === userList.currentIndex ? 1.0 : 0.0
            Behavior on opacity {
                enabled: Config.enableAnimations
                NumberAnimation { duration: 200 }
            }

            Avatar {
                id: userAvatar
                anchors.fill: parent
                source: model.icon || ""
                active: index === userList.currentIndex
                opacity: active ? 1.0 : Config.avatarInactiveOpacity
                enabled: userModel.rowCount() > 1
                tooltipText: active && selector.listUsers ? (Config.avatarAlwaysActive ? "" : "Close user selection") : (active && !selector.listUsers ? "Select user" : model.name)
                showTooltip: selector.focus && !selector.listUsers && active

                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation { duration: 200 }
                }

                onClicked: {
                    if (!selector.listUsers) {
                        selector.openUserList();
                        selector.focus = true;
                    } else {
                        if (index === userList.currentIndex) {
                            selector.closeUserList();
                            selector.focus = false;
                        } else {
                            userList.currentIndex = index;
                        }
                    }
                }
                
                onClickedOutside: {
                    if (selector.listUsers) {
                        selector.closeUserList();
                        selector.focus = false;
                    }
                }
            }
        }
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
            if (selector.listUsers) {
                selector.closeUserList();
                selector.focus = false;
            } else if (userModel.rowCount() > 1) {
                selector.openUserList();
                selector.focus = true;
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Escape) {
            selector.closeUserList();
            selector.focus = false;
            event.accepted = true;
        } else if ((selector.orientation === "horizontal" && event.key === Qt.Key_Left) || (selector.orientation === "vertical" && event.key === Qt.Key_Up)) {
            selector.prevUser();
            selector.focus = true;
            event.accepted = true;
        } else if ((selector.orientation === "horizontal" && event.key === Qt.Key_Right) || (selector.orientation === "vertical" && event.key === Qt.Key_Down)) {
            selector.nextUser();
            selector.focus = true;
            event.accepted = true;
        } else {
            event.accepted = false;
        }
    }
}