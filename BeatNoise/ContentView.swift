//
//  ContentView.swift
//  BeatNoise
//
//  Created by Willy Merlet on 16/11/21.
//

import AVFoundation
import Foundation
import SwiftUI
import Combine


struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Scan", systemImage: "dot.radiowaves.left.and.right")
                    }
            PlayerView()
                .tabItem{
                    Label("Playlist", systemImage: "music.note")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
