//
//  AVdelegate.swift
//  BeatNoise
//
//  Created by Giovanni Teresi on 18/11/21.
//

import Foundation
import AVKit

class AVdelegate : NSObject,AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
