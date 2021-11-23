//
//  HomeView.swift
//  BeatNoise
//
//  Created by Willy Merlet on 16/11/21.
//

import SwiftUI

struct HomeView: View {
        init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: 10)
    @ObservedObject private var micInput = MicrophoneInput()
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: ScanningView()) {
                    Text("SCAN")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .background(Circle()
                            .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),startPoint: .top,endPoint: .bottom), lineWidth: 12)
                            .foregroundColor(Color("backgroundColor")).frame(width: 200, height: 200).opacity(0.7))
                        .padding(.bottom, 80)
                }
               
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundColor"))
        .navigationBarTitle("Scan")
        }
        .onAppear {
            mic.setPermission(audioSession: mic.audioSession)
            micInput.setPermission(audioSession: micInput.audioSession)
        }
        .disabled((mic.ispermission == false) && (micInput.ispermission == false))
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
