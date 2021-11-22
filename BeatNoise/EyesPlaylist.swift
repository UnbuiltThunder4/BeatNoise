//
//  EyesPlaylist.swift
//  BeatNoise
//
//  Created by Clelia Iovine on 22/11/21.
//

import SwiftUI

struct AnimationBootcamp2: View {
    
    @State var isAnimated: Bool = false
    @State var blinking: Bool = false
    @State var eyeFade = false
    @State var height1: Int = 20
    @State var height2: Int = 65
    @State var height3: Int = 120
    @State var yoff: Int = 0
    
    var body: some View {
        VStack{
            Spacer()
            HStack(spacing: 10){
                                Spacer()
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20, height: CGFloat(height1))
                                    .offset(x: 0, y: CGFloat(yoff)-10)
                                    .background(Ellipse()
                                        .offset(x: 0, y: CGFloat(yoff))
                                        .fill(Color.black)
                                        .frame(width: 50, height: CGFloat(height2)))
                                        .padding(.bottom, 20)
                                    .background(Ellipse()
                                        .fill(Color.white.opacity(0.9))
                                        .frame(width: 100, height: CGFloat(height3)))                       .padding(.trailing, 30)
                                Spacer()
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20, height: CGFloat(height1))
                                    .offset(x: 0, y: CGFloat(yoff)-10)
                                    .background(Ellipse()
                                        .offset(x: 0, y: CGFloat(yoff))
                                        .fill(Color.black)
                                        .frame(width: 50, height: CGFloat(height2)))
                                        .padding(.bottom, 20)
                                    .background(Ellipse()
                                        .fill(Color.white.opacity(0.9))
                                        .frame(width: 100, height: CGFloat(height3)))
                                        .padding(.leading, 30)
                                Spacer()
                            }
            Spacer()
            Button("Press here") {
                
                withAnimation {
                    if (blinking == false) {
                        height1 = 20
                        height2 = 65
                        height3 = 120
                        yoff = 0
                        blinking = true
                    
                    }
                    else {
                        height1 = 0
                        height2 = 5
                        height3 = 10
                        yoff = 10
                        blinking = false
                    }
                }
            }
            .padding()
            Ellipse()
                .fill(Color.gray)
                .frame(width: 300, height: CGFloat(height1))
            
           
        }.background(Color.yellow)
           
        
            }
}
