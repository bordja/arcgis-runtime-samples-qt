// [WriteFile Name=DisplayMap, Category=Maps]
// [Legal]
// Copyright 2016 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// [Legal]

import QtQuick 2.6
import QtQuick.Controls 1.4
import Esri.Samples 1.0
import Esri.ArcGISExtras 1.1

OAuthRedirectExample {
    id: root
    width: 800
    height: 600
    property double scaleFactor: System.displayScaleFactor

    Column {
        anchors{
            fill: parent
            margins: 16
        }
        spacing: 16

        GroupBox {
            Column {
                spacing: 16

                Text {
                    text: "client id"
                    font.bold: true
                }

                TextField {
                    id: clientIdField
                    width: 128 * scaleFactor
                    placeholderText: clientId
                    onAccepted: setClientId(text);
                }

                Button {
                    text: "update"
                    onClicked: setClientId(clientIdField.text);
                }
            }
        }

        Button {
            id: loadPortalButton
            text: "load portal"
            onClicked: {
                enabled = false;
                loadPortal();
            }
        }

        Text {
            text: portalLoadStatus
        }

        Text {
            text: status
        }

        Text {
            text: portalName
            font.bold: true
        }
    }
}



