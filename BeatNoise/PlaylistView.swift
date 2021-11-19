//
//  PlaylistView.swift
//  BeatNoise
//
//  Created by Giovanni Teresi on 18/11/21.
//
//Clelia's code

import SwiftUI

struct PlaylistView: View {
    
    //@StateObject var cur = SettingCurrent()
    
  //  @Binding var current: Int
    
    var body: some View {
        
        NavigationView{
            VStack {
                List {
                    NavigationLink(destination: PlayerView()) {
                        Text ("White Noise Track 1")
                        
                    }
                    
                    NavigationLink(destination: PlayerView()) {
                        
                        Text ("White Noise Track 2")
//                            .onTapGesture(){
//                                self.current = 1
//                    }
                    }
                    NavigationLink(destination: Text("")) {
                        
                        Text ("Ocean Waves")
                    }
                    NavigationLink(destination: Text("")) {
                        
                        Text ("Rain Track 1")
                    }
                    NavigationLink(destination: Text("")) {
                        
                        Text ("Rain Track 2")
                    }
                    
                    NavigationLink(destination: Text("")) {
                        
                        Text ("Birds Chirping")
                    }
                    
                }
            }
            .navigationTitle("Playlist")
            .background(Color("backgroundColor"))
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
            .preferredColorScheme(.dark)
    }
}



