/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import harbour.nofono.Settings 1.0
import harbour.nofono.Launcher 1.0
import "pages"

ApplicationWindow
{
    id: mainapp
    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    property string output: ""
    function loadConfig() {
        ["autostart", "exitafterautostart"].forEach(function (key){
            config.get(key);
        })

    }
    MySettings {
        id: myset
    }

    Item {
        id: config
        function set(key, value){
            if(Object.keys(config).indexOf(key) > -1 && value !== config[key]) {
                myset.setValue(key, JSON.stringify(value))
                config[key] = value
                myset.sync()
            }

        }
        function get(key) {
            if (myset.contains(key)) {
                config[key] = JSON.parse( myset.value(key))
            }
            if(config[key]) {
                return  config[key];
            }
        }

        property bool autostart: false
        property bool exitafterautostart: false

        Component.onCompleted: loadConfig()
    }

    App {
        id: bar
    }

    function banner(notificationType, message, header) {
        notification.close()
        var notificationCategory
        switch (notificationType) {
        case "OK":
            notificationCategory = "x-jolla.store.sideloading-success"
            break
        case "INFO":
            notificationCategory = "x-jolla.lipstick.credentials.needUpdate.notification"
            break
        case "WARNING":
            notificationCategory = "x-jolla.store.error"
            break
        case "ERROR":
            notificationCategory = "x-jolla.store.error"
            break
        }
        notification.category = notificationCategory
        notification.previewBody = message
        notification.previewSummary = header || "Nofono"
        notification.publish()
    }
    function run(){
        var data = bar.launch(
                    "/usr/share/harbour-nofono/helper/nofonohelper")
        output = data //"<pre>" + data + "</pre>"
        banner('OK', 'Nofono', qsTr('mobile service restarting    →'))
    }

    Notification {
        id: notification
        itemCount: 1
        expireTimeout: -1
    }
}
