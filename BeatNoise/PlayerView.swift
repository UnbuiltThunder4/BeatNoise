//
//  PlayerView.swift
//  BeatNoise
//
//  Created by Giovanni Teresi on 18/11/21.
//

import SwiftUI
import AVKit
 

struct PlayerView: View {
    
    @State var current = 0
    @State var data: Data = .init(count: 0)
    @State var title = ""
    @State var currtime = ""
    @State var lenght = ""
    @State var isrepeating: Bool = true
    @State var player: AVAudioPlayer!
    @State var playing = false
    @State var width: CGFloat = 0.0
    @State var songs = ["Sound", "Sound1", "Sound2", "Sound3", "Sound4", "Sound5"]
    @State var finish = false
    @State var del = AVdelegate()
    @State var soundsamples = [Float](repeating: .zero, count: 10)
    @State var currentsample = 0
    @State var timer = Timer.publish(every: 0.5, on: .current, in: .default).autoconnect()
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)

    
    @State var blinking: Bool = false
    @State var eyeFade = false
    @State var height1 = false
    @State var height2 = false
    @State var height3 = false
    @State var yoff = false
    
    
    var body: some View {
        VStack (spacing: 20){
            HStack(spacing: 10){
                                Spacer()
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20).frame(height: height1 ? 13 : 20 )
                                    .offset(x: 0)
                                    .offset(y: yoff ? 5 : -8)
                                    .background(Ellipse()
                                    .offset(x: 0)
                                    .offset(y: yoff ? 10 : 10)
                                    .fill(Color.black)
                                    .frame(width: 50).frame(height: height2 ? 30 : 65))
                                    .padding(.bottom, 20)
                                    .background(Ellipse()
                                    .fill(Color.white.opacity(0.9))
                                    .frame(width: 100).frame(height: height3 ? 60 : 120))
                                    .padding(.trailing, 30)
                                Spacer()
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20).frame(height: height1 ? 13 : 20 )
                                    .offset(x: 0)
                                    .offset(y: yoff ? 5 : -8)
                                    .background(Ellipse()
                                    .offset(x: 0)
                                    .offset(y: yoff ? 10 : 10)
                                    .fill(Color.black)
                                    .frame(width: 50).frame(height: height2 ? 30 : 65))
                                    .padding(.bottom, 20)
                                    .background(Ellipse()
                                    .fill(Color.white.opacity(0.9))
                                    .frame(width: 100).frame(height: height3 ? 60 : 120))
                                    .padding(.leading, 30)
                                Spacer()
                            }
            .padding(.bottom, 40)
             
            HStack(spacing: 4) {
                     ForEach(soundsamples, id: \.self) { (_) in
                         BarView(value: normalizeSoundLevel(level: startAnimationWave()))
                             .animation(.linear, value: soundsamples[currentsample])

                     }
            }.frame(maxWidth: 350, maxHeight: 100).padding(.top, 40)
                .padding()
            
            ZStack(alignment: .leading) {
                
                Capsule().fill(Color.white.opacity(0.08)).frame(width: UIScreen.main.bounds.width - 30 ,height: 8)
                
                Capsule().fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                              startPoint: .leading,
                                              endPoint: .trailing)).frame(width: self.width, height: 8)
                
                    .gesture(DragGesture()
                                .onChanged({ (value) in
                        
                        let x = value.location.x
                        
                        self.width = x
                        
                    }).onEnded({ (value) in
                        
                        let x = value.location.x
                        
                        let screen = UIScreen.main.bounds.width - 30
                        
                        let percent = x / screen
                        
                        self.player.currentTime = Double(percent) * self.player.duration
                    }))
            }
            .padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 4.5)) {
                Text(currtime)
                Text(lenght)
            }
            
            HStack(alignment: .center, spacing: UIScreen.main.bounds.width / 5.0 - 30.0) {
                Button(action: goback) {
                    Image(systemName: "backward.end.fill")
                        .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility4/*@END_MENU_TOKEN@*/) //this makes the button bigger
                }
                
                Button(action: play_pause) {
                    Image(systemName: self.playing && !self.finish ? "pause.fill" : "play.fill")
                        .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility4/*@END_MENU_TOKEN@*/)
                }
                Button(action: gonext) {
                    Image(systemName: "forward.end.fill")
                        .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility4/*@END_MENU_TOKEN@*/)
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundColor"))
        .navigationBarTitle(self.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
        
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            self.player.delegate = self.del
            self.player.prepareToPlay()
            self.currtime = self.getCurrenttime(value: self.player.currentTime)
            self.lenght = self.getCurrenttime(value: self.player.duration)
            self.getData()
            play_pause()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                
                if self.player.isPlaying {
                    let screen = UIScreen.main.bounds.width - 30
                    let value = self.player.currentTime / self.player.duration
                    self.width = screen * CGFloat(value)
                }
                
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                
                self.finish = true
                if !self.player.isPlaying {
                    self.player.stop()
                    gonext()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.linear(duration: 0.5)){
                    yoff.toggle()
                    height1.toggle()
                    height2.toggle()
                    height3.toggle()
                }
            }
        }
        .onDisappear() {
            self.player.stop()
        }
        .onReceive(timer) {
            (_) in
            self.updateTime()
        }
        
    }
    
    

    struct BarView: View {
        var value: CGFloat
        let numberOfsamples: Int = 10
        

        var body: some View {
            ZStack {
           
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfsamples) * 15) / CGFloat(numberOfsamples), height: value - (value / 1.07) )
                
                  
            }
        }
    }
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
           
        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
    func getData() {
        let asset = AVAsset(url: self.player.url!)
        for i in asset.commonMetadata {
            if  i.commonKey?.rawValue == "title" {
                let title = i.value as! String
                self.title = title
            }
        }
    }
    
    func getCurrenttime (value: TimeInterval)-> String {
        let duration: String
        duration = "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy: 60)) < 10 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy: 60)))"
        return duration
    }
    
    func updateTime() {
        self.currtime = self.getCurrenttime(value: self.player.currentTime)
    }
    
    func ChangeSongs() {
        self.player.stop()
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        self.player.delegate = self.del
        self.data = .init(count: 0)
        self.title = ""
        self.player.prepareToPlay()
        self.getData()
        self.currtime = "0:00"
        self.lenght = self.getCurrenttime(value: self.player.duration)
        self.playing = true
        self.finish = false
        self.width = 0
        self.player.play()
    }
    
    func goback() {
        if self.current > 0 {
            self.current -= 1
            self.ChangeSongs()
        }
    }
    
    func play_pause() {
        if self.player.isPlaying {
            self.player.pause()
            self.playing = false
            
        }
        else {
            self.player.play()
            self.playing = true
          
        }
    }
    
    func gonext() {
        if self.songs.count - 1 != self.current {
            self.current += 1
            self.ChangeSongs()
        }
        else {
            self.current = 0
            self.ChangeSongs()
        }
    }
    
    
    
    func startAnimationWave()->Float {
        
        let wave = [50, 100, 150, 200, 250, 200, 150, 100, 50, 100]
        let maxsamples = 10
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: isrepeating) {_ in
            if  self.playing {
            soundsamples[currentsample] = Float(wave[currentsample])
            currentsample = (currentsample + 1) % maxsamples
            }
            else { self.isrepeating = false}
        }
        return Float(soundsamples[currentsample])
    }
}
    



struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()

    }
}


