//
//  SplashScreen.swift
//  BeatNoise
//
//  Created by Willy Merlet on 19/11/21.
//

import SwiftUI

struct SplashScreen: View {
    @State var splashAnimation: Bool = false
    @State var fadeIn = false
    @State var fadeIn1 = false
    @State var fadeIn2 = false
    @State var circleAni = false
    @State var mouthFade = false
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    HStack(spacing: 10){
                        Spacer()
                        Circle()
                            .fill(Color.white)
                            .frame(width: 5, height: 5)
                            .offset(x: 0, y: 0)
                            .opacity(fadeIn ? 1 : 0)
                            .background(Ellipse()
                            .fill(Color.black)
                            .frame(width: 13, height: 16))
                            .opacity(fadeIn1 ? 1 : 0)
                            .padding(.bottom, 10)
                            .background(Ellipse()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 25, height: 30))
                            .opacity(fadeIn2 ? 1 : 0)
                            .padding(.trailing, 20)
                          
                  
                      Circle()
                            .fill(Color.white)
                            .frame(width: 5, height: 5)
                            .offset(x: 0, y: 0)
                            .opacity(fadeIn ? 1 : 0)
                            .background(Ellipse()
                            .fill(Color.black)
                            .frame(width: 13, height: 16))
                            .opacity(fadeIn1 ? 1 : 0)
                            .padding(.bottom, 10)
                            .background( Ellipse()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 25, height: 30))
                            .opacity(fadeIn2 ? 1 : 0)
                            .padding(.leading, 20)
                           
                     Spacer()
                    }.padding(.bottom, 15)
        
                    HStack(spacing: 6){
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 10, height: 30)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 10, height: 35)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 10, height: 40)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 10, height: 10)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 10, height: 40)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 10, height: 35)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 10, height: 30)
                    }.opacity(mouthFade ? 1 : 0).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation(.easeIn(duration: 0.4)){
                                mouthFade.toggle()
                            }
                        }
                    }
                 
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.linear(duration: 0.2)){
                            fadeIn.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.linear(duration: 0.2)){
                            fadeIn1.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.linear(duration: 1)){
                            fadeIn2.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.linear(duration: 0.6)){
                            circleAni.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.35) {
                        
                        withAnimation(.easeInOut(duration: 0.4)){
                            splashAnimation.toggle()
                        }
                    }
                }
            }.frame(width: circleAni ? 200 : 2200).frame(height: circleAni ? 200: 2200).background(Circle().stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),startPoint: .top,endPoint: .bottom), lineWidth: 12))
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("backgroundColor")).scaleEffect(splashAnimation ? 35 : 1).statusBar(hidden: true)
       
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

struct TriangleS: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct BarView1: View {
    var value: CGFloat

    var body: some View {
        ZStack {
       
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: 20, height: 60)
              
        }
    }
}
