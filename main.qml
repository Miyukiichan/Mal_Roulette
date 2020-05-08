import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.0

import "json.js" as Json
import backend 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("MAL Roulette")

    function get_random_result() {
        statusbarStatus.text = "Working..."
        worker.sendMessage({"user" : username.text})
    }

    WorkerScript {
        id: worker
        source: "json.js"
        onMessage: {
            Json.displayResult(messageObject.done)
            statusbarStatus.text = ""
        }
    }

    BackEnd {
        id: backend
    }

    TextField {
        id: username
        x: 220
        y: 220
        placeholderText: qsTr("Username")
        onAccepted: get_random_result()
        selectByMouse: true
        text: "Miyukiichan"
        anchors.verticalCenterOffset: -103
        anchors.horizontalCenterOffset: -59
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: accept
        x: 386
        y: 220
        text: qsTr("Accept")
        anchors.verticalCenterOffset: -103
        anchors.horizontalCenterOffset: 113
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: get_random_result()
    }

     CheckBox {
         id: completed_checkbox
         x: 293
         y: 205
         text: qsTr("Completed")
         anchors.verticalCenterOffset: -15
         anchors.horizontalCenterOffset: 23
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
     }

     Label {
         id: category_label
         x: 245
         y: 180
         text: qsTr("Categories to Include")
         anchors.verticalCenterOffset: -50
         anchors.horizontalCenterOffset: 0
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         font.pointSize: 12
     }

     CheckBox {
         id: watching_checkbox
         x: 64
         y: 205
         text: qsTr("Watching")
         anchors.verticalCenterOffset: -15
         anchors.horizontalCenterOffset: -199
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         checked: true
     }

     CheckBox {
         id: plan_to_watch_checkbox
         x: 173
         y: 205
         text: qsTr("Plan to Watch")
         anchors.verticalCenterOffset: -15
         anchors.horizontalCenterOffset: -90
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         checked: true
     }

     CheckBox {
         id: dropped_checkbox
         x: 489
         y: 205
         text: qsTr("Dropped")
         anchors.verticalCenterOffset: -15
         anchors.horizontalCenterOffset: 213
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
     }

     CheckBox {
         id: on_hold_checkbox
         x: 398
         y: 205
         text: qsTr("On Hold")
         anchors.verticalCenterOffset: -15
         anchors.horizontalCenterOffset: 121
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         checked: false
     }

     Rectangle {
         id: resultRectangle
         x: 188
         y: 273
         width: 234
         height: 84
         color: "#ffffff"
         radius: 10
         anchors.verticalCenterOffset: 69
         anchors.horizontalCenterOffset: 0
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         visible: false
         border.width: 2

         Label {
             id: titleLabel
             x: 104
             y: 13
             text: qsTr("Label")
             visible: false
             anchors.verticalCenterOffset: -13
             anchors.horizontalCenterOffset: 0
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.verticalCenter: parent.verticalCenter
         }

         Label {
             id: statusLabel
             x: 95
             y: 22
             text: qsTr("Label")
             visible: false
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.horizontalCenterOffset: 0
             anchors.verticalCenter: parent.verticalCenter
             anchors.verticalCenterOffset: 6
         }
     }

     Rectangle {
         id: statusBar
         y: 457
         height: 23
         color: "#bcbaba"
         anchors.left: parent.left
         anchors.leftMargin: 0
         anchors.right: parent.right
         anchors.rightMargin: 0
         anchors.bottom: parent.bottom
         anchors.bottomMargin: 0

         Label {
             id: statusbarStatus
             x: 8
             y: 5
             text: qsTr("")
         }
     }

     Button {
         id: viewMalButton
         x: 270
         y: 363
         text: qsTr("View in MAL")
         anchors.verticalCenterOffset: 145
         anchors.horizontalCenterOffset: 0
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         visible: false
         onClicked: Json.send_to_mal()
     }
}
