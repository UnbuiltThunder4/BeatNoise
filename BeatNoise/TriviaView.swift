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
        "At which point noise pollution becomes hurtful?",
        "Noise pollution and wildlife",
        "Who is affected the most by noise pollution?",
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<titles.count, id: \.self) { index in
                    TriviaCard(title: titles[index], text: texts[index])
                        .frame(width: UIScreen.main.bounds.width - 32)
                        .cornerRadius(16)
                        .padding()
                }
            }.navigationTitle("Trivia")
        }.background(Color("backgroundColor"))
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
