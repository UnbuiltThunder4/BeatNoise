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
        "What health issues can arise due to noise pollution?",
        "Is the wildlife affected by noise pollution?",
        "How to prevent hear loss?",
        "How much dangerous is noise pollution?",
        "Who is more affected by noise pollution?"
        
    ]
    let texts: [String] = [
        "Noise pollution is generally defined as regular exposure to elevated sound levels that may lead to adverse effects in humans or other living organisms. According to the World Health Organization,sound levels less than 70 dB aren’t damaging to living organisms, regardless of how long or consistent the exposure is. The average noise level of 98 dB exceeds the WHO value of 50 dB allowed for residential areas.",
        "Notable health issues that can be caused by noise pollution include stress, weakened mental acuity, elevated blood pressure and heart rates. These issues could even lead to more serious problems. In fact, noise pollution has been linked to other dire health complications such as dementia, stroke, and heart attacks.",
        "Animals use sound for many reasons, including to navigate, feed and attract mates. Noise makes it difficult for them to accomplish these tasks, even for the ones that don't live on land. Whales and dolphins are particularly impacted by noise since they rely on echolocation to live and excess noise interferes with this ability. Some of the loudest underwater noise comes from naval sonar devices, that can reach 235 dB and travel hundreds of miles.",
        "World Health Organization says that half of all cases of hearing loss can be prevented through public health measures, including reducing exposure to loud sounds by raising awareness about the risks; developing and enforcing relevant legislation; and encouraging individuals to use personal protective devices such as earplugs and noise-cancelling earphones and headphones, such as Airpods.",
        "Atmospheric pollution is not the only type of contamination that is harming living beings on the planet. According to the World Health Organization, it is one of the most dangerous environmental threats to health. And according to the European Environment Agency, noise is responsible for 16,600 premature deaths and more than 72,000 hospitalisations every year in Europe alone.",
        "Exposure to environmental noise does not affect everyone equally. Socially deprived groups, as well as groups with increased susceptibility to noise (people affected by ADHD, OCD and autism), may suffer more pronounced health-related impacts of noise."
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
            }.background(Color("backgroundColor")).navigationTitle("Trivia")
        }
    }
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
