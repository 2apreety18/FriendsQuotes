//
//  MusicPlayer.swift
//  FriendsQuotes
//
//  Created by preety on 4/10/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic(backgroundMusicFileName: String) {
        if let bundle = Bundle.main.path(forResource: backgroundMusicFileName, ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func playSoundEffect(soundEffect: String) {
        if let bundle = Bundle.main.path(forResource: soundEffect, ofType: "wav") {
            let soundEffectUrl = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:soundEffectUrl as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
}
