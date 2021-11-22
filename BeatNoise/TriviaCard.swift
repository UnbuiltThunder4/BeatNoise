//
//  TriviaCard.swift
//  BeatNoise
//
//  Created by Clelia Iovine on 19/11/21.
//

import SwiftUI

struct TriviaCard: View {
    @State var textShade = false
    var title: String
    var text: String
    @State var isSelected: Bool = false
    @State var ere = false
    
    var body: some View {
        LazyVStack {
            Text(title)
                .font(.title2)
                .frame(width: 300, height: 70, alignment: .leading)
            if isSelected {
                Text(text)
                    .font(.body)
                    .frame(width: 300, height: 300, alignment: .leading)
                    .transition(.opacity)
            }
            Image(systemName: "chevron.down")
                .font(.title)
                .padding(.top, 2)
                .frame(width: 20, height: 20, alignment: .trailing)
                .rotationEffect(!isSelected ? .zero : .degrees(180))
        }
        .frame(width: UIScreen.main.bounds.width)
            .padding()
            .background(.gray.opacity(0.3))
            .onTapGesture {
                isSelected = !isSelected
            }
//            .animation(.easeIn, value: isSelected)
//            .transition(.move(edge: .top))
    }
}


//struct TriviaCard_Previews: PreviewProvider {
//    static var previews: some View {
//        TriviaCard()
//    }
//}
