//
//  PlaylistView.swift
//  BeatNoise
//
//  Created by Giovanni Teresi on 18/11/21.
//
//Clelia's code

import SwiftUI

struct PlaylistView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color("backgroundColor"))
        UITableView.appearance().backgroundColor = UIColor(Color("backgroundColor"))

    }
    @Environment(\.defaultMinListRowHeight) var minRowHeight
   

    var body: some View {
            NavigationView{
                ScrollView{
                    VStack{
                        List {
                            NavigationLink(destination: PlayerView(current: 0)) {
                                Text ("Nature Sound")
                                
                            }
                            NavigationLink(destination: PlayerView(current: 1)) {
                                
                                Text ("Waterfall Sound")
                            }
                            NavigationLink(destination: PlayerView(current: 2)) {
                                
                                Text ("River Water Sound")
                            }
                            NavigationLink(destination: PlayerView(current: 3)) {
                                
                                Text ("Birds Chirping Sound")
                            }
                            NavigationLink(destination: PlayerView(current: 4)) {
                                
                                Text ("Dark Lamp Sound")
                            }
                            
                            NavigationLink(destination: PlayerView(current: 5)) {
                                
                                Text ("Waves Crashing Sound")
                            }
                            
                        }.frame(minHeight: minRowHeight * 14).background(Color("backgroundColor")).navigationTitle("Playlist")
                    }.background(Color("backgroundColor"))
                }.background(Color("backgroundColor"))
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}



