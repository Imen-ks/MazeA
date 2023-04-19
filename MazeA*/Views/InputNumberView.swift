//
//  InputNumberView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 19/04/2023.
//

import SwiftUI
import Combine

struct InputNumberView: View {
    @Binding var property: String
    
    var headline: String
    var subHeadline: String
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    Text(headline)
                    Text(subHeadline)
                        .font(.caption)
                }
                Spacer()
                ZStack(alignment:.trailing) {
                    Capsule()
                        .fill(.teal)
                        .frame(width: 70, height: 40)
                    TextField("", text: $property)
                        .frame(width: 35)
                        .padding(5)
                        .cornerRadius(16)
                        .keyboardType(.numberPad)
                        .onReceive(Just(property)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.property = filtered
                            }
                        }
                }
            }
            .padding(.vertical, 8)
            Divider()
                .overlay(Color.white)
        }
        .padding()
        .padding(.horizontal)
        
    }
}

struct InputNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.indigo
            InputNumberView(property: .constant(""), headline: "Number of rows", subHeadline: "(between 1 & 10)")
        }
        .foregroundColor(.white)
    }
}
