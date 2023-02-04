//
//  MicroBreaksApp.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import Foundation
import SwiftUI

@main
struct GapTheoryApp: App {

    // Connect the app delegate instance to this app
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        MenuBarExtra {
            // The content of the MenuBarExtra is a HomeView instance
            HomeView(userSettings: appDelegate.userSettings)
                // Pass the appDelegate object to the HomeView instance as environment object
                .environmentObject(appDelegate)
        }
        label: {
            Image("menu-icon")
        }
        .menuBarExtraStyle(.window)
    }
}
