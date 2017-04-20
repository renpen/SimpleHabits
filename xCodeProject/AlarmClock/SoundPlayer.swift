//
//  SoundPlayer.swift
//  AlarmClock
//
//  Created by René Penkert on 11.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import AVFoundation


class SoundPlayer
{
    static let sharedInstance = SoundPlayer()
    var player: AVAudioPlayer?
    func playSound(fileName : String)
    {
        player?.volume = 1.0
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
            return print("error")
        }
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch let error {
            print("Play ERROR")
            print(error.localizedDescription)
        }
    }

}
