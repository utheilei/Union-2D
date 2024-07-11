pragma Singleton
import utk.UApplicationTheme 1.0
import QtQuick 2.12

UApplicationTheme {
    id: theme

    property color windowText
    property color button
    property color light
    property color midlight
    property color dark
    property color mid
    property color text
    property color brightText
    property color buttonText
    property color base
    property color window
    property color shadow
    property color highlight
    property color highlightedText
    property color link
    property color linkVisited
    property color alternateBase
    property color toolTipBase
    property color toolTipText
    property color placeholderText
    property color itemBackground
    property color successBackground
    property color warningBackground
    property color errorBackground
    property color orangeBackground
    property color offlineBackground
    property color informationBackground
    property color splitLineBackground
    property color frameBorder


    Behavior on window {
        ColorAnimation {
            duration: 1000
        }
    }

    onApplicationThemeChanged: {
        updateColor()
    }

    Component.onCompleted: {
        updateColor()
    }

    function updateColor() {
        windowText = color(UApplicationTheme.WindowText)
        button = color(UApplicationTheme.Button)
        light = color(UApplicationTheme.Light)
        midlight = color(UApplicationTheme.Midlight)
        dark = color(UApplicationTheme.Dark)
        mid = color(UApplicationTheme.Mid)
        text = color(UApplicationTheme.Text)
        brightText = color(UApplicationTheme.BrightText)
        buttonText = color(UApplicationTheme.ButtonText)
        base = color(UApplicationTheme.Base)
        window = color(UApplicationTheme.Window)
        shadow = color(UApplicationTheme.Shadow)
        highlight = color(UApplicationTheme.Highlight)
        highlightedText = color(UApplicationTheme.HighlightedText)
        link = color(UApplicationTheme.Link)
        linkVisited = color(UApplicationTheme.LinkVisited)
        alternateBase = color(UApplicationTheme.AlternateBase)
        toolTipBase = color(UApplicationTheme.ToolTipBase)
        toolTipText = color(UApplicationTheme.ToolTipText)
        placeholderText = color(UApplicationTheme.PlaceholderText)
        itemBackground = color(UApplicationTheme.ItemBackground)
        successBackground = color(UApplicationTheme.SuccessBackground)
        warningBackground = color(UApplicationTheme.WarningBackground)
        errorBackground = color(UApplicationTheme.ErrorBackground)
        orangeBackground = color(UApplicationTheme.OrangeBackground)
        offlineBackground = color(UApplicationTheme.OfflineBackground)
        informationBackground = color(UApplicationTheme.InformationBackground)
        splitLineBackground = color(UApplicationTheme.SplitLineBackground)
        frameBorder = color(UApplicationTheme.FrameBorder)
    }
}
