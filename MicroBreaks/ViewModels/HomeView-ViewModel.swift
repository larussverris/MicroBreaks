//
//  HomeView-ViewModel.swift
//  MicroBreaks
//
//  Created by LA on 2.2.2023.
//

import Foundation

extension HomeView {
    class ViewModel: ObservableObject {
        private var timer: Timer?
        private var dispatchQueue: DispatchQueue?
        private var events: Set<Int> = []
        private var userSettings: UserSettingsWrapper!
        
        @Published var isRunning: Bool = false
        
        // State variable to track whether the current session is a break or not
        @Published var isOnBreak = false
        
        // This value is decremented every second
        @Published var secondsLeftInStudySession: Int
        
        init(userSettings: UserSettingsWrapper) {
            self.userSettings = userSettings
            self.secondsLeftInStudySession = userSettings.settings.studyDuration
            self.generateRandomEvents()
        }
        
        func update() {
            self.secondsLeftInStudySession = userSettings.settings.studyDuration
        }
        
        func setSecondsInStudySession(seconds: Int) {
            DispatchQueue.main.async {
                self.userSettings.settings.studyDuration = seconds
                self.secondsLeftInStudySession = seconds
                self.generateRandomEvents()
            }
        }
        
        func startBreakSession(duration: Int) {
            self._sendBreakStartedNotification()
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(duration)) {
                self.isOnBreak = true
                self.isOnBreak = false
                self._sendBreakEndedNotification()
            }
        }
        
        func start() {
            self.isRunning = true
            dispatchQueue = DispatchQueue(label: "StudySessionQueue")
            dispatchQueue?.async { [weak self] in
                guard let self = self else { return }
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    if self.events.contains(self.secondsLeftInStudySession) {
                        self.startBreakSession(duration: self.userSettings.settings.breakDuration)
                    }
                    DispatchQueue.main.async {
                        self.secondsLeftInStudySession -= 1
                        if self.secondsLeftInStudySession == 0 {
                            self.timer?.invalidate()
                            self._sendSessionEndedNotification()
                        }
                    }
                })
                RunLoop.current.add(self.timer!, forMode: .default)
                RunLoop.current.run()
            }
        }
        
        func stop() {
            self.isRunning = false
            timer?.invalidate()
        }
        
        func reset() {
            self.isRunning = false
            self.stop()
            secondsLeftInStudySession = self.userSettings.settings.studyDuration
        }
        
        func generateRandomEvents() {
            self.events.removeAll() // clear the set
            let numberOfTwoMinuteBlocks = self.userSettings.settings.studyDuration/120
            for i in 0...numberOfTwoMinuteBlocks {
                let event = Int.random(in: 105...135)
                let ble = (i*120)+event
                events.insert(ble)
            }
        }
        
        private func _sendBreakStartedNotification() {
            sendBreakStartedNotification(seconds: self.userSettings.settings.breakDuration)
            playSound(soundPath: "break-started", ofType: "wav", volume: userSettings.settings.volume) // need to set volume
        }
        
        private func _sendBreakEndedNotification() {
            sendBreakEndedNotification()
            playSound(soundPath: "break-ended", ofType: "wav", volume: userSettings.settings.volume) // need to set volume
        }
        
        private func _sendSessionEndedNotification() {
            sendSessionEndedNotification()
            playSound(soundPath: "session-ended", ofType: "wav", volume: userSettings.settings.volume) // need to set volume
            
        }

    }
}
