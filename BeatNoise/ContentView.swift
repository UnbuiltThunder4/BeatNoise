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
    @State private var home = UUID()
    @State private var playlist = UUID()
    @State private var trivia = UUID()
    @State private var tabSelection = 1
    @State private var tappedTwice = false
       
    var handler: Binding<Int> { Binding(
            get: { self.tabSelection },
            set: {
                    if $0 == self.tabSelection {
                            tappedTwice = true
                    }
                    self.tabSelection = $0
            }
    )}
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    var body: some View {
        TabView(selection: handler){
            if self.isActive {
                    HomeView().id(home)
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                        guard tappedTwice else { return }
                        home = UUID()
                        self.tappedTwice = false
                })
                .tabItem {
                    Label("Scan", systemImage: "dot.radiowaves.left.and.right")
                }.tag(1)
                    PlaylistView()
                .tabItem {
                    Label("Playlist", systemImage: "music.note")
                }.tag(2)
                    TriviaView().id(trivia)
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                        guard tappedTwice else { return }
                        trivia = UUID()
                        self.tappedTwice = false
                })
                    .tabItem {
                        Label("Trivia", systemImage: "book")
                    }.tag(3)
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
