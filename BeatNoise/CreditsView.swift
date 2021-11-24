//
//  CreditsView.swift
//  BeatNoise
//
//  Created by Giovanni Teresi on 23/11/21.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        Credits().navigationTitle("Credits")
            .navigationBarTitleDisplayMode(.large)
    }
}

struct Credits: View {
    var body: some View {
        
        
        
        VStack(){
            
            Form{
                Section() {
                    
                    Text("Clelia Iovine")
                    Text("Eugenio Raja")
                    Text("Giovanni Teresi")
                    Text("Willy Merlet")
                    
                }
            }
            
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
