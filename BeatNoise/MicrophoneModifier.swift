//
//  MicrophoneModifier.swift
//  BeatNoise
//
//  Created by Willy Merlet on 16/11/21.
//

import Foundation
import AVFoundation

class MicrophoneMonitor: ObservableObject {
    
  
    public var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    
    private var currentSample: Int
    private let numberOfSamples: Int
    

    @Published public var soundSamples: [Float]
  
    
    init(numberOfSamples: Int) {
        self.numberOfSamples = numberOfSamples // In production check this is > 0.
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
        
  
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
                }
            }
        }
        
   
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
  
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
  
    public func startMonitoring() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
       
            self.audioRecorder.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
    }
    public func stopMonitoring() {
        timer?.invalidate()
        audioRecorder.stop()
        //self.soundData = [Float](repeating: .zero, count: numberOfData)
    }

    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}


class MicrophoneInput: ObservableObject { //Eugenio's code
    
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    
    private let numberOfData = 40 //Should be timeRemaining (found in ContentView) * 4
    @Published public var soundData: [Float]
    
    init() {
        self.soundData = [Float](repeating: .zero, count: numberOfData)
        
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
                }
            }
        }
        
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func startMonitoring() {
            var times = 0
            var rep = true
            audioRecorder.isMeteringEnabled = true
            audioRecorder.record()
            timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: rep, block: { (timer) in //runs 41 times (fix?)
                if times < self.numberOfData {
                    self.audioRecorder.updateMeters()
                    self.soundData[times] = self.audioRecorder.averagePower(forChannel: 0)
                    times += 1
                }
                else {
                    rep = false
                }
            })
    }
    
    
    public func averageData() -> Float {
            var sum: Float = 0.0
            for i in self.soundData {
                sum += i + 160
            }
            sum = sum / Float(self.numberOfData)
            return (90 / 160 * sum) + 2
        }
        
        public func stopMonitoring() {
            timer?.invalidate()
            audioRecorder.stop()
            //self.soundData = [Float](repeating: .zero, count: numberOfData)
        }
    
    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}
