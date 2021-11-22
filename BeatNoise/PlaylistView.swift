//
//  PlaylistView.swift
//  BeatNoise
//
//  Created by Giovanni Teresi on 18/11/21.
//
//Clelia's code

import SwiftUI

struct PlaylistView: View {
    
    var body: some View {
      
        VStack {
            NavigationView{
                List {
                    NavigationLink(destination: PlayerView(current: 0)) {
                        Text ("White Noise Track 1")
                        
                    }
                    
                    NavigationLink(destination: PlayerView(current: 1)) {
                        
                        Text ("White Noise Track 2")
                        
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
                .navigationTitle("Playlist")
            }
            .background(Color("backgroundColor"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
            .preferredColorScheme(.dark)
    }
}



