//
//  notificationService.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import Foundation
import AVFoundation
import UserNotifications

/*
This function uses the UNUserNotificationCenter class to check the current notification settings for the app. If the authorization status is .authorized, it means that the user has granted permission to send notifications. If it is .denied, the user has denied permission. If it is .notDetermined, the user has not yet been asked for permission.

You can call this function by using checkNotificationPermission(). It will return true if the user has granted permission to send notifications, and false if they have denied permission or have not yet been asked for permission.
*/
func checkNotificationPermission(completion: @escaping (Bool)->()) {
    let center = UNUserNotificationCenter.current()
    
    center.getNotificationSettings { (settings) in
        if (settings.authorizationStatus == .authorized) {
            completion(true)
        }
    }
    completion(false)
}

func requestPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { success, error in
        if let error = error {
            print(error.localizedDescription)
        }
    }
}

func sendNotification(title: String, subtitle: String, soundPath: String? = nil) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    
    if (soundPath != nil) {
        content.sound = UNNotificationSound(
            named: UNNotificationSoundName(soundPath!)
        )
    }
    
    let request = UNNotificationRequest(
        identifier: UUID().uuidString,
        content: content,
        trigger: nil
    )
    
    // add our notification request
    UNUserNotificationCenter.current().add(request)
}


func sendBreakStartedNotification(seconds: Int) {
    sendNotification(
        title: "Take a break",
        subtitle: "It's time for a \(seconds)-second break to help you learn more effectively!",
        soundPath: "./break-started.wav"
    )
}

func sendBreakEndedNotification() {
    sendNotification(
        title: "Break over",
        subtitle: "Time to get back to work!",
        soundPath: "break-ended.wav"
    )
}

func sendSessionEndedNotification() {
    sendNotification(
        title: "Study Session Complete",
        subtitle: "Congratulations on completing your study session! Take a break and come back refreshed.",
        soundPath: "session-ended.wav"
    )
}
