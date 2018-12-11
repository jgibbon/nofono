import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
                         | Orientation.LandscapeInverted
    property bool largeScreen: Screen.sizeCategory === Screen.Large ||
                               Screen.sizeCategory === Screen.ExtraLarge
    SilicaFlickable {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: col.height

        VerticalScrollDecorator {
        }

        Column {
            id: col
            spacing: Theme.paddingLarge
            width: parent.width
            PageHeader {
                title: qsTr("About")
            }
            SectionHeader {
                text: qsTr("Info")
                visible: isPortrait || largeScreen
            }
            Separator {
                color: Theme.primaryColor
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignHCenter
                visible: isPortrait || largeScreen
            }
            Label {
                text: "Nofono"
                font.pixelSize: largeScreen ? Theme.fontSizeHuge : Theme.fontSizeExtraLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: isLandscape ? (largeScreen ? "/usr/share/icons/hicolor/256x256/apps/harbour-nofono.png" : "/usr/share/icons/hicolor/86x86/apps/harbour-nofono.png") : (largeScreen ? "/usr/share/icons/hicolor/256x256/apps/harbour-nofono.png" : "/usr/share/icons/hicolor/128x128/apps/harbour-nofono.png")
            }
            Label {
                font.pixelSize: largeScreen ? Theme.fontSizeLarge : Theme.fontSizeMedium
                text: qsTr("Version") + " " + version
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.secondaryHighlightColor
            }
            Label {
                text: qsTr("runs 'systemctl restart ofono' so you don't have to.")
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width - Theme.horizontalPageMargin*2
                x: Theme.horizontalPageMargin
                horizontalAlignment: Text.Center
                textFormat: Text.RichText
                wrapMode: Text.Wrap
                color: Theme.secondaryColor
            }
            SectionHeader {
                text: qsTr("Author")
                visible: isPortrait || largeScreen
            }
            Separator {
                color: Theme.primaryColor
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignHCenter
                visible: isPortrait || largeScreen
            }
            Label {
                text: "John Gibbon"
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                width: parent.width - Theme.horizontalPageMargin*2
                x: Theme.horizontalPageMargin

            }

            Button {
                text: "https://github.com/jgibbon/nofono/"
                onClicked: Qt.openUrlExternally(text)
                width: parent.width - Theme.horizontalPageMargin*2
                x: Theme.horizontalPageMargin
            }
            Label {
                text: qsTr("Large portions of the code taken from Sailcron – thanks ade!")
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                width: parent.width - Theme.horizontalPageMargin*2
                x: Theme.horizontalPageMargin

            }
            Button {
                text: "https://github.com/a-dekker/sailcron/"
                onClicked: Qt.openUrlExternally(text)
                width: parent.width - Theme.horizontalPageMargin*2
                x: Theme.horizontalPageMargin
            }

        }
    }
}
