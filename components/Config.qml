pragma Singleton

import QtQuick

/*
    `config["option"]` is used in some places instead of `config.boolValue("option")` so we can default to `true`.
    https://github.com/sddm/sddm/wiki/Theming#new-explicitly-typed-api-since-sddm-020
*/
QtObject {
    // [General]
    property real generalScale: config.realValue("scale") || 1.0 // @desc:Overall scale of the UI. This option can cause the UI to break, so it is recommended to use the individual width/height/size options instead.
    property bool enableAnimations: config['enable-animations'] === "false" ? false : true // @desc:Enable or disable all animations.
    property string animatedBackgroundPlaceholder: config.stringValue("animated-background-placeholder") // @possible:File in `backgrounds/` @desc:An image file to be used as a placeholder for the animated background while it loads.
    property string backgroundFillMode: config.stringValue("background-fill-mode") || "fill" // @possible:'fill' | 'fit' | 'stretch' @desc:Fill mode for <a href="#lockscreenbackground">LockScreen/background</a> and <a href="#loginscreenbackground">LoginScreen/background</a>.

    // [LockScreen]
    property bool lockScreenDisplay: config['LockScreen/display'] === "false" ? false : true // @desc:Whether or not to display the lock screen. If false, the theme will load straight to the login screen.
    property int lockScreenPaddingTop: config.intValue("LockScreen/padding-top") // @desc:Top padding of the lock screen.
    property int lockScreenPaddingRight: config.intValue("LockScreen/padding-right") // @desc:Right padding of the lock screen.
    property int lockScreenPaddingBottom: config.intValue("LockScreen/padding-bottom") // @desc:Bottom padding of the lock screen.
    property int lockScreenPaddingLeft: config.intValue("LockScreen/padding-left") // @desc:Left padding of the lock screen.
    property string lockScreenBackground: config.stringValue("LockScreen/background") || "smoky.jpg" // @possible:File in `backgrounds/` @desc:Background of the lock screen.
    property bool lockScreenUseBackgroundColor: config.boolValue('LockScreen/use-background-color') // @desc:Whether or not to use a plain color as background of the lock screen instead of an image/video file.
    property color lockScreenBackgroundColor: config.stringValue("LockScreen/background-color") || "#2C001E" // @desc:The color to be used as background of the lock screen.
    property int lockScreenBlur: config.intValue("LockScreen/blur") // @desc:Amount of blur to be applied to the background of the lock screen. 0 means no blur.
    property real lockScreenBrightness: config.realValue("LockScreen/brightness") // @possible:-1.0 ≤ R ≤ 1.0 @desc:Brightness of the background of the lock screen.
    property real lockScreenSaturation: config.realValue("LockScreen/saturation") // @possible:-1.0 ≤ R ≤ 1.0 @desc:Saturation of the background of the lock screen.

    // [LockScreen.Clock]
    property bool clockDisplay: config['LockScreen.Clock/display'] === "false" ? false : true // @desc:Whether or not to display the clock in the lock screen.
    property string clockPosition: config.stringValue("LockScreen.Clock/position") || "top-center" // @possible:'top-left' | 'top-center' | 'top-right' | 'center-left' | 'center' | 'center-right' | 'bottom-left' | 'bottom-center' | 'bottom-right'
    property string clockAlign: config.stringValue("LockScreen.Clock/align") || "center" // @possible:'left' | 'center' | 'right' @desc:Relative alignment of the clock and date.
    property string clockFormat: config.stringValue("LockScreen.Clock/format") || "hh:mm" // @desc:Format string used for the clock.
    property string clockFontFamily: config.stringValue("LockScreen.Clock/font-family") || "Ubuntu" // @desc:Font family used for the clock.
    property int clockFontSize: config.intValue("LockScreen.Clock/font-size") || 70 // @desc:Font size of the clock.
    property int clockFontWeight: config.intValue("LockScreen.Clock/font-weight") || 900 // @desc:Font weight of the clock. 400 = regular, 600 = bold, 800 = black
    property color clockColor: config.stringValue("LockScreen.Clock/color") || "#FFFFFF" // @desc:Color of the clock.

    // [LockScreen.Date]
    property bool dateDisplay: config['LockScreen.Date/display'] === "false" ? false : true // @desc:Whether or not to display the date in the lock screen.
    property string dateFormat: config.stringValue("LockScreen.Date/format") || "dddd, MMMM dd, yyyy" // @desc:Format string used for the date.
    property string dateLocale: config.stringValue("LockScreen.Date/locale") || "en_US"
    property string dateFontFamily: config.stringValue("LockScreen.Date/font-family") || "Ubuntu" // @desc:Font family used for the date.
    property int dateFontSize: config.intValue("LockScreen.Date/font-size") || 14 // @desc:Font size of the date.
    property int dateFontWeight: config.intValue("LockScreen.Date/font-weight") || 600 // @desc:Font weight of the date.
    property color dateColor: config.stringValue("LockScreen.Date/color") || "#FFFFFF" // @desc:Color of the date.
    property int dateMarginTop: config.intValue("LockScreen.Date/margin-top") // @desc:Top margin from the clock

    // [LockScreen.Message]
    property bool lockMessageDisplay: config['LockScreen.Message/display'] === "false" ? false : true // @desc:Whether or not to display the custom message in the lock screen.
    property string lockMessagePosition: config.stringValue("LockScreen.Message/position") || "bottom-center"
    property string lockMessageAlign: config.stringValue("LockScreen.Message/align") || "center" // @possible:'left' | 'center' | 'right'
    property string lockMessageText: config.stringValue("LockScreen.Message/text") || "Press any key" // @desc:Text of the custom message.
    property string lockMessageFontFamily: config.stringValue("LockScreen.Message/font-family") || "Ubuntu" // @desc:Font family used for the custom message.
    property int lockMessageFontSize: config.intValue("LockScreen.Message/font-size") || 12 // @desc:Font size of the custom message.
    property int lockMessageFontWeight: config.intValue("LockScreen.Message/font-weight") || 400 // @desc:Font weight of the date.
    property bool lockMessageDisplayIcon: config['LockScreen.Message/display-icon'] === "false" ? false : true // @desc:Show or hide the icon above the message.
    property string lockMessageIcon: config.stringValue("LockScreen.Message/icon") || "enter.svg" // @possible:File in `icons/`
    property int lockMessageIconSize: config.intValue("LockScreen.Message/icon-size") || 16 // @desc:Size of the custom message's icon.
    property color lockMessageColor: config.stringValue("LockScreen.Message/color") || "#FFFFFF" // @desc:Color of the custom message.
    property bool lockMessagePaintIcon: config['LockScreen.Message/paint-icon'] === "false" ? false : true // @desc:Whether or not to paint the icon with the same color as the text.
    property int lockMessageSpacing: config.intValue("LockScreen.Message/spacing") // @desc:Spacing between the icon and the text in the custom message.

    // [LoginScreen]
    property string loginScreenBackground: config.stringValue("LoginScreen/background") || "smoky.jpg" // @possible:File in `backgrounds/` @desc:Background of the login screen.
    property bool loginScreenUseBackgroundColor: config.boolValue('LoginScreen/use-background-color') // @desc:Whether or not to use a plain color as background of the login screen.
    property color loginScreenBackgroundColor: config.stringValue("LoginScreen/background-color") || "#2C001E" // @desc:The color to be used as background of the login screen.
    property int loginScreenBlur: config.intValue("LoginScreen/blur") // @desc:Amount of blur to be applied to the background of the login screen.
    property real loginScreenBrightness: config.realValue("LoginScreen/brightness") // @possible:-1.0 ≤ R ≤ 1.0
    property real loginScreenSaturation: config.realValue("LoginScreen/saturation") // @possible:-1.0 ≤ R ≤ 1.0

    // [LoginScreen.LoginArea]
    property string loginAreaPosition: config.stringValue("LoginScreen.LoginArea/position") || "center" // @possible:'left' | 'center' | 'right'
    property int loginAreaMargin: config.intValue("LoginScreen.LoginArea/margin")

    // [LoginScreen.LoginArea.Avatar]
    property string avatarShape: config.stringValue("LoginScreen.LoginArea.Avatar/shape") || "circle" // @possible:'circle' || 'square'
    property int avatarBorderRadius: config.intValue("LoginScreen.LoginArea.Avatar/border-radius")
    property int avatarActiveSize: config.intValue("LoginScreen.LoginArea.Avatar/active-size") || 120 // @desc:Size of the selected user's avatar.
    property int avatarInactiveSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-size") || 80 // @desc:Size of the non-selected user avatars.
    property real avatarInactiveOpacity: config.realValue("LoginScreen.LoginArea.Avatar/inactive-opacity") || 0.35 // @possible:0.0 ≤ R ≤ 1.0
    property int avatarActiveBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/active-border-size")
    property int avatarInactiveBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-border-size")
    property color avatarActiveBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/active-border-color") || "#E95420"
    property color avatarInactiveBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/inactive-border-color") || "#FFFFFF"
    property bool avatarAlwaysActive: config['LoginScreen.LoginArea.Avatar/always-active'] === "true" ? true : false

    // [LoginScreen.LoginArea.Username]
    property string usernameFontFamily: config.stringValue("LoginScreen.LoginArea.Username/font-family") || "Ubuntu" // @desc:Font family used for the username.
    property int usernameFontSize: config.intValue("LoginScreen.LoginArea.Username/font-size") || 16 // @desc:Font size of the username.
    property int usernameFontWeight: config.intValue("LoginScreen.LoginArea.Username/font-weight") || 700 // @desc:Font weight of the username.
    property color usernameColor: config.stringValue("LoginScreen.LoginArea.Username/color") || "#FFFFFF" // @desc:Color of the username.
    property int usernameMargin: config.intValue("LoginScreen.LoginArea.Username/margin")

    // [LoginScreen.LoginArea.PasswordInput]
    property int passwordInputWidth: config.intValue("LoginScreen.LoginArea.PasswordInput/width") || 200 // @desc:Width of the password field.
    property int passwordInputHeight: config.intValue("LoginScreen.LoginArea.PasswordInput/height") || 30 // @desc:Height of the password field.
    property bool passwordInputDisplayIcon: config['LoginScreen.LoginArea.PasswordInput/display-icon'] === "false" ? false : true
    property string passwordInputFontFamily: config.stringValue("LoginScreen.LoginArea.PasswordInput/font-family") || "Ubuntu" // @desc:Font family of the password field.
    property int passwordInputFontSize: config.intValue("LoginScreen.LoginArea.PasswordInput/font-size") || 12 // @desc:Font size of the password field.
    property string passwordInputIcon: config.stringValue("LoginScreen.LoginArea.PasswordInput/icon") || "password.svg"
    property int passwordInputIconSize: config.intValue("LoginScreen.LoginArea.PasswordInput/icon-size") || 16
    property color passwordInputContentColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/content-color") || "#FFFFFF"
    property color passwordInputBackgroundColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/background-color") || "#2C001E"
    property real passwordInputBackgroundOpacity: config.realValue("LoginScreen.LoginArea.PasswordInput/background-opacity") || 0.40
    property int passwordInputBorderSize: config.intValue("LoginScreen.LoginArea.PasswordInput/border-size") || 1
    property color passwordInputBorderColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/border-color") || "#77216F"
    property int passwordInputBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-left")
    property int passwordInputBorderRadiusRight: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-right")
    property int passwordInputMarginTop: config.intValue("LoginScreen.LoginArea.PasswordInput/margin-top")
    property string passwordInputMaskedCharacter: config.stringValue("LoginScreen.LoginArea.PasswordInput/masked-character") || "●"
    
    // [LoginScreen.LoginArea.LoginButton]
    property color loginButtonBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/background-color") || "#E95420"
    property real loginButtonBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/background-opacity") || 0.85
    property color loginButtonActiveBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-background-color") || "#E95420"
    property real loginButtonActiveBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/active-background-opacity") || 1.0
    property string loginButtonIcon: config.stringValue("LoginScreen.LoginArea.LoginButton/icon") || "arrow-right.svg"
    property int loginButtonIconSize: config.intValue("LoginScreen.LoginArea.LoginButton/icon-size") || 18
    property color loginButtonContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/content-color") || "#FFFFFF"
    property color loginButtonActiveContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-content-color") || "#FFFFFF"
    property int loginButtonBorderSize: config.intValue("LoginScreen.LoginArea.LoginButton/border-size")
    property color loginButtonBorderColor: config.stringValue("LoginScreen.LoginArea.LoginButton/border-color") || "#FFFFFF"
    property int loginButtonBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-left")
    property int loginButtonBorderRadiusRight: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-right")
    property int loginButtonMarginLeft: config.intValue("LoginScreen.LoginArea.LoginButton/margin-left")
    property bool loginButtonShowTextIfNoPassword: config['LoginScreen.LoginArea.LoginButton/show-text-if-no-password'] === "false" ? false : true
    property bool loginButtonHideIfNotNeeded: config.boolValue("LoginScreen.LoginArea.LoginButton/hide-if-not-needed")
    property string loginButtonFontFamily: config.stringValue("LoginScreen.LoginArea.LoginButton/font-family") || "Ubuntu"
    property int loginButtonFontSize: config.intValue("LoginScreen.LoginArea.LoginButton/font-size") || 12
    property int loginButtonFontWeight: config.intValue("LoginScreen.LoginArea.LoginButton/font-weight") || 600

    // [LoginScreen.LoginArea.Spinner]
    property bool spinnerDisplayText: config['LoginScreen.LoginArea.Spinner/display-text'] === "false" ? false : true
    property string spinnerText: config.stringValue("LoginScreen.LoginArea.Spinner/text") || "Logging in"
    property string spinnerFontFamily: config.stringValue("LoginScreen.LoginArea.Spinner/font-family") || "Ubuntu"
    property int spinnerFontWeight: config.intValue("LoginScreen.LoginArea.Spinner/font-weight") || 600
    property int spinnerFontSize: config.intValue("LoginScreen.LoginArea.Spinner/font-size") || 12
    property int spinnerIconSize: config.intValue("LoginScreen.LoginArea.Spinner/icon-size") || 32
    property string spinnerIcon: config.stringValue("LoginScreen.LoginArea.Spinner/icon") || "spinner.svg"
    property color spinnerColor: config.stringValue("LoginScreen.LoginArea.Spinner/color") || "#FFFFFF"
    property int spinnerSpacing: config.intValue("LoginScreen.LoginArea.Spinner/spacing")

    // [LoginScreen.LoginArea.WarningMessage]
    property string warningMessageFontFamily: config.stringValue("LoginScreen.LoginArea.WarningMessage/font-family") || "Ubuntu"
    property int warningMessageFontSize: config.intValue("LoginScreen.LoginArea.WarningMessage/font-size") || 11
    property int warningMessageFontWeight: config.intValue("LoginScreen.LoginArea.WarningMessage/font-weight") || 400
    property color warningMessageNormalColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/normal-color") || "#FFFFFF"
    property color warningMessageWarningColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/warning-color") || "#FFFFFF"
    property color warningMessageErrorColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/error-color") || "#FFFFFF"
    property int warningMessageMarginTop: config.intValue("LoginScreen.LoginArea.WarningMessage/margin-top")

    // [LoginScreen.MenuArea.Buttons]
    property int menuAreaButtonsMarginTop: config.intValue("LoginScreen.MenuArea.Buttons/margin-top")
    property int menuAreaButtonsMarginRight: config.intValue("LoginScreen.MenuArea.Buttons/margin-right")
    property int menuAreaButtonsMarginBottom: config.intValue("LoginScreen.MenuArea.Buttons/margin-bottom")
    property int menuAreaButtonsMarginLeft: config.intValue("LoginScreen.MenuArea.Buttons/margin-left")
    property int menuAreaButtonsSize: config.intValue("LoginScreen.MenuArea.Buttons/size") || 30
    property int menuAreaButtonsBorderRadius: config.intValue("LoginScreen.MenuArea.Buttons/border-radius")
    property int menuAreaButtonsSpacing: config.intValue("LoginScreen.MenuArea.Buttons/spacing")
    property string menuAreaButtonsFontFamily: config.stringValue("LoginScreen.MenuArea.Buttons/font-family") || "Ubuntu"

    // [LoginScreen.MenuArea.Popups]
    property int menuAreaPopupsMaxHeight: config.intValue("LoginScreen.MenuArea.Popups/max-height") || 300
    property int menuAreaPopupsItemHeight: config.intValue("LoginScreen.MenuArea.Popups/item-height") || 30
    property int menuAreaPopupsSpacing: config.intValue("LoginScreen.MenuArea.Popups/item-spacing")
    property int menuAreaPopupsPadding: config.intValue("LoginScreen.MenuArea.Popups/padding")
    property bool menuAreaPopupsDisplayScrollbar: config["LoginScreen.MenuArea.Popups/display-scrollbar"] === "false" ? false : true
    property int menuAreaPopupsMargin: config.intValue("LoginScreen.MenuArea.Popups/margin")
    property color menuAreaPopupsBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/background-color") || "#2C001E"
    property real menuAreaPopupsBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/background-opacity") || 0.85
    property color menuAreaPopupsActiveOptionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/active-option-background-color") || "#E95420"
    property real menuAreaPopupsActiveOptionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/active-option-background-opacity")
    property color menuAreaPopupsContentColor: config.stringValue("LoginScreen.MenuArea.Popups/content-color") || "#FFFFFF"
    property color menuAreaPopupsActiveContentColor: config.stringValue("LoginScreen.MenuArea.Popups/active-content-color") || "#FFFFFF"
    property string menuAreaPopupsFontFamily: config.stringValue("LoginScreen.MenuArea.Popups/font-family") || "Ubuntu"
    property int menuAreaPopupsBorderSize: config.intValue("LoginScreen.MenuArea.Popups/border-size")
    property color menuAreaPopupsBorderColor: config.stringValue("LoginScreen.MenuArea.Popups/border-color") || "#FFFFFF"
    property int menuAreaPopupsFontSize: config.intValue("LoginScreen.MenuArea.Popups/font-size") || 11
    property int menuAreaPopupsIconSize: config.intValue("LoginScreen.MenuArea.Popups/icon-size") || 16

    // [LoginScreen.MenuArea.Session]
    property bool sessionDisplay: config["LoginScreen.MenuArea.Session/display"] === "false" ? false : true
    property string sessionPosition: config.stringValue("LoginScreen.MenuArea.Session/position")
    property int sessionIndex: config.intValue("LoginScreen.MenuArea.Session/index")
    property string sessionPopupDirection: config.stringValue("LoginScreen.MenuArea.Session/popup-direction") || "up"
    property string sessionPopupAlign: config.stringValue("LoginScreen.MenuArea.Session/popup-align") || "center"
    property bool sessionDisplaySessionName: config['LoginScreen.MenuArea.Session/display-session-name'] === "false" ? false : true
    property int sessionButtonWidth: config.intValue("LoginScreen.MenuArea.Session/button-width") || 200
    property int sessionPopupWidth: config.intValue("LoginScreen.MenuArea.Session/popup-width") || 200
    property color sessionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Session/background-color") || "#FFFFFF"
    property real sessionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/background-opacity")
    property real sessionActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/active-background-opacity")
    property color sessionContentColor: config.stringValue("LoginScreen.MenuArea.Session/content-color") || "#FFFFFF"
    property color sessionActiveContentColor: config.stringValue("LoginScreen.MenuArea.Session/active-content-color") || "#FFFFFF"
    property int sessionBorderSize: config.intValue("LoginScreen.MenuArea.Session/border-size")
    property int sessionFontSize: config.intValue("LoginScreen.MenuArea.Session/font-size") || 10
    property int sessionIconSize: config.intValue("LoginScreen.MenuArea.Session/icon-size") || 16

    // [LoginScreen.MenuArea.Layout]
    property bool layoutDisplay: config["LoginScreen.MenuArea.Layout/display"] === "false" ? false : true
    property string layoutPosition: config.stringValue("LoginScreen.MenuArea.Layout/position")
    property int layoutIndex: config.intValue("LoginScreen.MenuArea.Layout/index")
}