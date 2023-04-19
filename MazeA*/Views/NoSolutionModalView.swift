//
//  NoSolutionModalView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 19/04/2023.
//

import SwiftUI

struct NoSolutionModalView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .padding(.bottom)
                Text("There is no solution to this maze")
            }
            .padding()
            .frame(width: 250, height: 250)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.white)
            .background(.teal)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 30)
                    }
                }
            }
        }
    }
}

struct NoSolutionModalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoSolutionModalView()
        }
    }
}
