//
//  HomeView.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var userSettings: UserSettingsWrapper
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var appDelegate: AppDelegate
    
    init(userSettings: UserSettingsWrapper) {
        self.userSettings = userSettings
        self.viewModel = ViewModel(userSettings: userSettings)
    }
    
    var body: some View {
        
        VStack() {
            HStack {
                Text("MicroBreaks")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.grey)
                
                Spacer()
                
                Text("Quit")
                    .foregroundColor(.grey)
                    .onTapGesture {
                        appDelegate.quitApp()
                }
                Button(action: {
                    openSettings()
                }) {
                    Image(systemName: "ellipsis")
                        .padding([.leading,.top,.bottom], 10)
                        .contentShape(Rectangle())
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, 8)
            
            VStack {
                Text(viewModel.isOnBreak
                     ? "Break!"
                     : "Focus!"
                )
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.cyan)
                
                Text("\(formattedTimeRemaining)")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.navy)
            .cornerRadius(20)
            
            HStack {
                
                Spacer()
                if (viewModel.isRunning) {
                    // Pause button
                    CircularButton(
                        icon: "pause.fill",
                        title:"Stop",
                        backgroundColor: Color.white,
                        onPress: viewModel.stop
                    )
                } else {
                    // Play button
                    CircularButton(
                        icon: "play.fill",
                        title: "Start",
                        backgroundColor: Color.white,
                        onPress: viewModel.start
                    )
                }
                
                Spacer()
                Divider().frame(height: 30).foregroundColor(.white)
                Spacer()
                
                // Reset button
                CircularButton(
                    icon: "stop.fill",
                    title: "Reset",
                    backgroundColor: Color.white,
                    onPress: viewModel.reset
                )
                Spacer()
            }.padding()
        }
        .padding()
        .background(Color.midnight.padding(-80))
        .onChange(of: userSettings.settings) { _ in
            viewModel.update()
        }
    }
    func openSettings() {
        appDelegate.openSettingsWindow()
    }
    
    var formattedTimeRemaining: String {
        return secondsToHoursMinutesSeconds(seconds: viewModel.secondsLeftInStudySession)
    }
}
