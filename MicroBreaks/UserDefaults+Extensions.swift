//
//  UserDefaults+Extensions.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import Foundation

// Save user settings to UserDefaults
func saveUserSettings(userSettings: UserSettingsStruct) -> Void {
    let encoder = JSONEncoder()
    do {
        let encoded = try encoder.encode(userSettings)
        UserDefaults.standard.set(encoded, forKey: "userSettings")
    } catch {
        // handle error
    }
}

// Retreive user settings from UserDefaults
func retrieveUserSettings() -> UserSettingsStruct {
    let defaults = UserDefaults.standard
    guard
        let data = defaults.data(forKey: "userSettings"),
        let userSettings = try? JSONDecoder().decode(UserSettingsStruct.self, from: data)
    else {
        return UserSettingsStruct()
    }
    return userSettings
}
