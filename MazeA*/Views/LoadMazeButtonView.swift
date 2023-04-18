//
//  LoadMazeButtonView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 18/04/2023.
//

import SwiftUI

struct LoadMazeButtonView: View {
    var orientation: Orientation
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            if orientation == .vertical {
                Text("Load a new maze")
                    .font(.title2)
            } else if orientation == .horizontal {
                Image(systemName: "folder.badge.plus")
                    .font(.title)
                    .bold()
                    .frame(width: 80, height: 100)
            }
        }
        .buttonStyle(.borderedProminent)
        .foregroundColor(.white)
        .tint(.indigo)

    }
}

struct LoadMazeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoadMazeButtonView(orientation: .vertical, action: {})
            LoadMazeButtonView(orientation: .horizontal, action: {})
        }
    }
}
