//
//  UserSettings.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import Foundation

class UserSettingsWrapper: ObservableObject {
    init(userSettingsStruct: UserSettingsStruct) {
        self.settings = userSettingsStruct
    }
    
    @Published var settings: UserSettingsStruct {
        willSet {
            objectWillChange.send()
        }
    }
}

extension UserSettingsWrapper: Equatable {
    static func == (lhs: UserSettingsWrapper, rhs: UserSettingsWrapper) -> Bool {
        return lhs.settings == rhs.settings
    }
}

struct UserSettingsStruct: Codable {
    var studyDuration: Int = 90
    var breakDuration: Int = 10
    var allowNotifications: Bool = false
    var volume: Float = 0.8
    var userHasCustomStudyTime: Bool = false
    var userHasCustomBreakTime: Bool = false
}


extension UserSettingsStruct: Equatable {
    static func == (lhs: UserSettingsStruct, rhs: UserSettingsStruct) -> Bool {
        return
            lhs.studyDuration == rhs.studyDuration &&
            lhs.breakDuration == rhs.breakDuration &&
            lhs.allowNotifications == rhs.allowNotifications &&
            lhs.volume == rhs.volume &&
            lhs.userHasCustomStudyTime == rhs.userHasCustomStudyTime &&
            lhs.userHasCustomBreakTime == rhs.userHasCustomBreakTime
        }
}

