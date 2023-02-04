//
//  AppDelegate.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    // An instance variable of type UserSettings that stores the user's settings
    // the settings window and the main window have to be in sync
    
    @ObservedObject var userSettings: UserSettingsWrapper = UserSettingsWrapper(
        userSettingsStruct: retrieveUserSettings()
    )
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // request the user for notifications permission
        requestPermission()
    }
    
    // An instance variable of type NSWindow that represents the app's settings window
    var settingsWindow = NSWindow(
        contentRect: NSZeroRect,
        styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView, .borderless],
        backing: .buffered, defer: false
    )
    
    @objc func quitApp() {
        exit(0)
    }
    
    @objc func openSettingsWindow() {
        
        settingsWindow.title = "Preferences"
        // Set the window's isReleasedWhenClosed property to false to prevent it from being deallocated when it is closed
        settingsWindow.isReleasedWhenClosed = false
        // Position the window in the center of the screen
        settingsWindow.center()
        // Set the window's content view to an instance of NSHostingView that displays a SettingsView from the app's SwiftUI code
        settingsWindow.contentView = NSHostingView(rootView: SettingsView().environmentObject(self.userSettings))
        // Make the window's title bar transparent
        settingsWindow.titlebarAppearsTransparent = true
        // Bring the window to the front of all other windows
        settingsWindow.orderFrontRegardless()
    }
}

