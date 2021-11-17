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
    @State var timeRemaining = 10 //Should be numberOfData (found in MicrophoneModifier) / 4
    
    @State var rand: Int = 0
    let trivia = ["Sounds that reach or surpass 85 dB can harm the ears.", //line 0
                  "Noise pollution can cause health problems even in wildlife.", //line 1
                  "Loud noises cause bluebirds to have fewer chicks.", //line 2
                  "Noise is responsible for 16,600 premature deaths every year in Europe.", //line 3
                  "Trees are natural noise absorbents and can reduce noise by 10 dB.", //line 4
                  "Noise pollution can even cause heart attacks.", //line 5
                  "Research on noise pollution is still just starting.", //line 6
                  "The World Health Organization defines noise above 65 dB as noise pollution.", //line 7
                  "The average city dweller has a hearing loss of a 15 years older person.", //line 8
                  "You can prevent hear loss with the use of noise-cancelling headphones."] //line 9
    let triviaNumber = 10
    
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
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .offset(x: 0, y: -10)
                        .background(Ellipse()
                            .fill(Color.black)
                            .frame(width: 50, height: 65))
                            .padding(.bottom, 20)
                        .background(Ellipse()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 100, height: 120))
                            .padding(.trailing, 30)
                    Spacer()
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .offset(x: 0, y: -10)
                        .background(Ellipse()
                            .fill(Color.black)
                            .frame(width: 50, height: 65))
                            .padding(.bottom, 20)
                        .background( Ellipse()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 100, height: 120))
                            .padding(.leading, 30)
                    Spacer()
                }.padding(.bottom, 40)
                Spacer()
                HStack(spacing: 4) {
                         ForEach(mic.soundSamples, id: \.self) { level in
                             BarView(value: self.normalizeSoundLevel(level: level))
                         }
                }.frame(maxWidth: 350, maxHeight: 100).padding(.top, 40)
                Spacer()
                if (timeRemaining > 0) {
                    Triangle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .offset(x: -80, y: 10)
                        .onAppear {
                            micResult.startMonitoring()
                        }
                    Text("Wait \(timeRemaining) sec\nI'm scanning...")
                        .foregroundColor(Color.black)
                        .frame(maxWidth: 350, maxHeight: 150)
                        .background(Rectangle()
                            .fill(Color.white)
                            .frame(width: 350, height: 150)
                            .cornerRadius(30))
                        .padding(.bottom, 50)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            }
                        }
                    }
                
                    else {
                        Triangle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40)
                            .offset(x: -80, y: 10)
                        Text("The result is \(Int(micResult.averageData())) dB. Did you know?\n\(trivia[rand])")
                            .padding(.horizontal, 5)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: 350, maxHeight: 150)
                            .background(Rectangle()
                                .fill(Color.white)
                                .frame(width: 350, height: 150)
                                .cornerRadius(30))
                            .padding(.bottom, 50)
                            .onAppear {
                                rand = Int.random(in:0..<triviaNumber)
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
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 15) / CGFloat(numberOfSamples), height: value)
              
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
