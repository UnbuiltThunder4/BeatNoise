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
    @State var isActive:Bool = false
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    var body: some View {
        TabView{
            if self.isActive {
            HomeView()
                .tabItem {
                    Label("Scan", systemImage: "dot.radiowaves.left.and.right")
                    }
            PlaylistView()
                .tabItem{
                    Label("Playlist", systemImage: "music.note")
                }
                TriviaView()
                    .tabItem {
                        Label("Trivia", systemImage: "book")
                    }
            } else {
                SplashScreen()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
