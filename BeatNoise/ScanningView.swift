//
//  ScanningView.swift
//  BeatNoise
//
//  Created by Willy Merlet on 16/11/21.
//

import SwiftUI
import AVFoundation
import Foundation
import Combine

struct ScanningView: View {
    @State var eyeFade = false
    @State var movingEye = false
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    @ObservedObject private var micResult = MicrophoneInput()
    @State var timeRemaining = 7
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
         init() {
           UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
       }
      
       private func normalizeSoundLevel(level: Float) -> CGFloat {
           let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
           
           return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
       }
    var body: some View {
        NavigationView{
            VStack {
             
                HStack(spacing: 10){
                    Spacer()
                    
                    Circle().fill(Color.black).frame(width: 25, height: 25).background(Ellipse().fill(Color.gray.opacity(eyeFade ? 0.6 : 0.2)).frame(width: 60, height: 60)).padding(.bottom, 20).background( Ellipse().fill(Color.white.opacity(0.70))
                        .frame(width: 100, height: 120)).padding(.trailing, 30)
                    Spacer()
                    Circle().fill(Color.black).frame(width: 25, height: 25).background(Ellipse().fill(Color.gray.opacity(0.6)).frame(width: 60, height: 60)).padding(.bottom, 20).background( Ellipse().fill(Color.white.opacity(0.70))
                        .frame(width: 100, height: 120)).padding(.leading, 30)
                    Spacer()
                }.padding(40)
                Spacer()
                HStack(spacing: 4) {
                         ForEach(mic.soundSamples, id: \.self) { level in
                             BarView(value: self.normalizeSoundLevel(level: level))
                         }
                }.padding(.bottom, 20)
                Spacer()
                Triangle()
                    .fill(Color.white)
                    .opacity(0.9)
                    .frame(width: 40, height: 40)
                    .offset(x: -80, y: -55)
                if (timeRemaining > 0) {
                            
                    Text("Wait \(timeRemaining) sec")
                             .background(Rectangle().fill(Color.white)
                             .frame(width: 300, height: 150)
                             .cornerRadius(30)
                             .opacity(0.9))
                             .padding(.bottom, 100)
                             .onReceive(timer) { _ in
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                    }
                                }
                        }
                        else {
                            Text(" The result is \(micResult.averageData())")
                                .background(Rectangle().fill(Color.white)
                                .frame(width: 300, height: 150)
                                .cornerRadius(30)
                                .opacity(0.9))
                                .padding(.bottom, 100)
                                .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation(.linear(duration: 2)){
                                          eyeFade.toggle()
                                        }
                                    }
                                }
                        }
                   
                  
               
         
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("backgroundColor")
            ).navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ScanningView_Previews: PreviewProvider {
    static var previews: some View {
        ScanningView()
    }
}

let numberOfSamples: Int = 10

struct BarView: View {
    var value: CGFloat

    var body: some View {
        ZStack {
       
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .border(Color.black)
               
        
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 10) / CGFloat(numberOfSamples), height: value)
              
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}
