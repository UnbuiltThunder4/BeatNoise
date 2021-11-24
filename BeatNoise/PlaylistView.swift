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



