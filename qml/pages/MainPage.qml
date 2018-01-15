import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
    id: mainPage
    property alias nofonoOut: nofonoOut
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
                         | Orientation.LandscapeInverted


    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: mainCol.height
        id: listPass
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {

            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push("About.qml")
            }
        }

        RemorsePopup { id: remorse }

        Column {
            id: mainCol
            width: parent.width;
            PageHeader {
                width: listPass.width
                title: qsTr("Nofono")
                description: qsTr("restarts ofono service")
            }
            Timer {
                interval: 10
                id: autorunInterval
                repeat: false
                onTriggered: {
                    run()
                    if(config.exitafterautostart) {
                        closeInterval.start()
                    }

                }
            }

            Timer {
                interval: 600
                id: closeInterval
                repeat: false
                onTriggered: {
                    Qt.quit()
                }
            }
            Button {
                text: qsTr("restart telephony service now")
                onClicked: {
                    remorse.cancel()
                    closeInterval.stop()
                    run()
                }
                preferredWidth: Theme.buttonWidthLarge
            }
            Label {
                id: nofonoOut
                text: mainapp.output
                width: parent.width
                color: Qt.rgba(255,255,255,0.2)
                textFormat: Text.PlainText

            }
            TextSwitch {
                text: qsTr("Run on app start")
                checked: config.autostart
                onCheckedChanged: {
                    config.set("autostart", checked)
                    remorse.cancel()
                    closeInterval.stop()
                }
            }
            TextSwitch {
                text: qsTr("Exit after autostart")
                checked: config.exitafterautostart
                onCheckedChanged: {
                    config.set("exitafterautostart", checked)
                    remorse.cancel()
                    closeInterval.stop()
                }
            }
        }
        Component.onCompleted: {
            if(config.get("autostart")) {
                console.log("autostart");
                remorse.execute("nofono", function() { autorunInterval.start() }, 2000 )
            }

        }

    }
}
