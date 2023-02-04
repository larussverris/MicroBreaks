//
//  SettingsView.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import SwiftUI

func sanitizeStringToInt(string: String) -> Int? {
    let sanitizedString = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    return Int(sanitizedString)
}

struct SettingsView: View {

    @EnvironmentObject var userSettings: UserSettingsWrapper
    
    @State var customStudyTime: Int = 90
    @State var customBreakTime: Int = 10
    
    @State var systemAllowsNotificationsForApp: Bool = true
    
    var body: some View {
        
        VStack {
            
            Text("Settings")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if (!systemAllowsNotificationsForApp) {
                AllowNotificationsMessage()
            }
            
            HStack {
                Image(systemName: "bell.fill")
                    .foregroundColor(.blue)
                Text("Reminder Notifications")
                    .foregroundColor(.primary)
                Spacer()
                Toggle(isOn: $userSettings.settings.allowNotifications) {}
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .disabled(!systemAllowsNotificationsForApp)
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(10)
            
            
            Spacer().frame(height: 20)
            
            VStack {
                
                HStack {
                    Text("Study duration")
                        .font(.title3)
                    Spacer()
                    Picker("", selection: $userSettings.settings.userHasCustomStudyTime) {
                        Text("Defaults").tag(false)
                        Text("Custom").tag(true)
                    }.pickerStyle(.segmented)
                        .controlSize(.small)
                        .accentColor(.green)
                }
                
                if (userSettings.settings.userHasCustomStudyTime) {
                    HStack {
                        TextField(
                            "",
                            value: $customStudyTime,
                            formatter: numberFormatter
                        )
                    }
                }
                else {
                    
                    Picker("", selection: $userSettings.settings.studyDuration) {
                        ForEach(studyDurationOptions, id: \.1) { duration, seconds in
                            Text(duration).tag(seconds)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Text("Break duration")
                        .font(.title3)
                    Spacer()
                    Picker("", selection: $userSettings.settings.userHasCustomBreakTime) {
                        Text("Defaults").tag(false)
                        Text("Custom").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .controlSize(.small)
                    .accentColor(.green)
                }
                
                if (userSettings.settings.userHasCustomBreakTime) {
                    TextField("title", value: $customBreakTime, formatter: numberFormatter)
                } else {
                    Picker("", selection: $userSettings.settings.breakDuration) {
                        ForEach(breakDurationOptions, id: \.1) { duration, seconds in
                            Text(duration)
                                .tag(seconds)
                        }
                    }
                }
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(10)
            
            Spacer().frame(height: 20)
            
            HStack {
                Text("Alert volume")
                
                Image(systemName: "speaker.fill")
                Slider(
                    value: $userSettings.settings.volume,
                    in: 0...1,
                    step: 0.2
                )
                Image(systemName: "speaker.wave.3.fill")
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(10)
            
            // Github footer
            GitHubFooter()
        }
        .frame(width: 300)
        .padding()
        
        .onAppear(
            perform: handleOnAppear
        )
        
        // When the value of userSettings changes
        .onChange(
            of: userSettings.settings,
            perform: handleUserSettingsChange
        )
        .onChange(of: customStudyTime) { time in
            userSettings.settings.studyDuration = time*60
        }
        .onChange(of: customBreakTime) { time in
            userSettings.settings.breakDuration = time*60
        }
    }
    
    func handleOnAppear() {
        checkNotificationPermission() {result -> () in
            self.systemAllowsNotificationsForApp = result
        }
    }
    
    func handleUserSettingsChange(_ newSettings: UserSettingsStruct) {
        saveUserSettings(userSettings: newSettings)
        
        /*
         if the user has selected defaults, we have to make sure that there
         isn't an illegal value
        */
        if (!userSettings.settings.userHasCustomStudyTime) {
            let valueIsLegal = studyDurationOptions.contains { (tuple) -> Bool in
                return tuple.1 == userSettings.settings.studyDuration
            }
            if (!valueIsLegal) {
                self.userSettings.settings.studyDuration = 5400
            }
        }
        
        if (!userSettings.settings.userHasCustomBreakTime) {
            let valueIsLegal = breakDurationOptions.contains { (tuple) -> Bool in
                return tuple.1 == userSettings.settings.breakDuration
            }
            if (!valueIsLegal) {
                self.userSettings.settings.breakDuration = 10
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
