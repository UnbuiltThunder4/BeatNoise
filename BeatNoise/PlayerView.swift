//
//  PlayerView.swift
//  BeatNoise
//
//  Created by Giovanni Teresi on 18/11/21.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    var body: some View {
        NavigationView {
            Player().navigationBarTitle("White Noise Player")
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}


struct Player: View {
    
    @State var data: Data = .init(count: 0)
    @State var title = ""
    @State var player: AVAudioPlayer!
    @State var playing = false
    @State var width: CGFloat = 0.0
    @State var songs = ["Sound", "Sound1"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegate()
    
    var body: some View {
        VStack (spacing: 20){
            Text(self.title).font(.title).padding(.top)
            ZStack(alignment: .leading) {
            
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                
                Capsule().fill(Color.red).frame(width: self.width, height: 8)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("backgroundColor"))
        .onAppear {
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            self.player.delegate = self.del
            self.player.prepareToPlay()
            self.getData()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                
                if self.player.isPlaying{
                    
                    let screen = UIScreen.main.bounds.width - 30
                    
                    let value = self.player.currentTime / self.player.duration
                    
                    self.width = screen * CGFloat(value)
                }
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                
                self.finish = true
            }
        }
        
        
    }
    
    func getData() {
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata {
            if i.commonKey?.rawValue == "artwork" {
                let data = i.value as! Data
                self.data = data
            }
            if  i.commonKey?.rawValue == "title" {
                let title = i.value as! String
                self.title = title
            }
        }
    }
    
    func ChangeSongs() {
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        self.player.delegate = self.del
        self.data = .init(count: 0)
        self.title = ""
        self.player.prepareToPlay()
        self.getData()
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
}
