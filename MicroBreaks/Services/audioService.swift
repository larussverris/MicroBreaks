//
//  audioService.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer!

func playSound(soundPath: String, ofType: String, volume: Float = 1) {
    guard let path = Bundle.main.path(forResource: soundPath, ofType: ofType) else {
        return }
    let url = URL(fileURLWithPath: path)

    do {
        player = try AVAudioPlayer(contentsOf: url)
        player.volume = volume
        player?.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}
