//
//  TriviaView.swift
//  BeatNoise
//
//  Created by Clelia Iovine on 19/11/21.
//

import SwiftUI

struct TriviaView: View {
    let titles: [String] = [
        "What is noise pollution?",
        "At which point noise pollutione becomes hurtful?",
        "Noise pollution and wildlife",
        "Who is affected the most by noise pollution?",
    ]
    let texts: [String] = [
        "Noise pollution is generally defined as regular exposure to elevated sound levels that may lead to adverse effects in humans or other living organisms. According to the World Health Organization,sound levels less than 70 dB aren’t damaging to living organisms, regardless of how long or consistent the exposure is. The average noise level of 98 dB exceeds the WHO value of 50 dB allowed for residential areas.",
        "Sounds that reach 85 decibels or higher can harm a person’s ears",
        "Noise pollution also impacts the health and well-being of wildlife. Animals use sound for a variety of reasons, including to navigate, find food, attract mates, and avoid predators. Noise pollution makes it difficult for them to accomplish these tasks, which affects their ability survive. Increasing noise is not only affecting animals on land, it is also a growing problem for those that live in the ocean. Whales and dolphins are particularly impacted by noise pollution. These marine mammals rely on echolocation to communicate, navigate, feed, and find mates, and excess noise interferes with their ability to effectively echolocate. Some of the loudest underwater noise comes from naval sonar devices. Sonar sounds can be as loud as 235 decibels and travel hundreds of miles under water, interfering with whales’ ability to use echolocation and it can cause mass strandings of whales on beaches and alter the feeding behavior of endangered blue whales (Balaenoptera musculus).",
        "Who is affected the most by noise pollution?",
    ]
    
    var body: some View {
        VStack {
        NavigationView {
            ScrollView {
                ForEach(0..<titles.count, id: \.self) { index in
                    TriviaCard(title: titles[index], text: texts[index])
                        .frame(width: UIScreen.main.bounds.width - 32)
                        .cornerRadius(16)
                        .padding()
                }
            }.navigationTitle("Trivia")
        }
    }.background(Color("backgroundColor"))
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
