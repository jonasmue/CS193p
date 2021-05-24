//
//  ContentView.swift
//  Memorize
//
//  Created by Jonas on 24.05.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 3)
            Text("Hello, CS193p!")
        }
        .padding(.horizontal)
        .foregroundColor(Color.purple)

            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
