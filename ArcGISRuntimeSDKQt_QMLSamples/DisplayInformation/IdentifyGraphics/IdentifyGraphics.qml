// Copyright 2015 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import Esri.ArcGISRuntime 100.00
import Esri.ArcGISExtras 1.1

Rectangle {
    width: 800
    height: 600

    property real scaleFactor: System.displayScaleFactor

    // Declare a map view inside the rectangle
    MapView {
        id: mapView

        anchors.fill: parent

        // Nest a map inside of the map view
        Map {
            id: map
            // set the basemap
            BasemapTopographic {}
        }

        // Add a graphics overlay to the map view
        GraphicsOverlay {
            id: graphicsOverlay
            // assign a render to the graphics overlay
            renderer: SimpleRenderer {
                symbol: SimpleFillSymbol {
                    style: Enums.SimpleFillSymbolStyleSolid
                    color: Qt.rgba(1, 1, 0, 0.7)
                }
            }
        }

        // Signal handler for identify graphics overlay
        onIdentifyGraphicsOverlayStatusChanged: {
            if (identifyGraphicsOverlayStatus === Enums.TaskStatusCompleted) {
                if (identifyGraphicsOverlayResults.length > 0) {
                    msgDialog.open();
                }
            } else if (identifyGraphicsOverlayStatus === Enums.TaskStatusErrored) {
                console.log("error");
            }
        }

        // Signal handler for mouse click event on the map
        onMouseClicked: {
            mapView.identifyGraphicsOverlay(graphicsOverlay, mouse.x, mouse.y, 22 * scaleFactor, 1000);
        }
    }

    MessageDialog {
        id: msgDialog
        text: "Tapped on graphic"
    }

    // Neatline rectangle
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }
    }

    Component.onCompleted: {
        // create the polygon by assigning points
        var polygonBuilder = ArcGISRuntimeEnvironment.createObject("PolygonBuilder", {spatialReference: map.spatialReference});
        polygonBuilder.addPointXY(-20e5, 20e5);
        polygonBuilder.addPointXY(20e5, 20e5);
        polygonBuilder.addPointXY(20e5, -20e5);
        polygonBuilder.addPointXY(-20e5, -20e5);
        // assign the geometry of the graphic to be the polygon
        var polygonGraphic = ArcGISRuntimeEnvironment.createObject("Graphic");
        polygonGraphic.geometry = polygonBuilder.geometry;
        // add the graphic to the polygon graphics overlay
        graphicsOverlay.graphics.append(polygonGraphic);
    }
}