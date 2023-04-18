//
//  ResetButtonView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 17/04/2023.
//

import SwiftUI

struct ResetButtonView: View {
    var orientation: Orientation
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            if orientation == .vertical {
                Text("Reset")
                    .font(.title2)
                    .frame(width: 100)
            } else if orientation == .horizontal {
                Image(systemName: "arrow.counterclockwise")
                    .font(.title)
                    .bold()
                    .frame(width: 40)
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ResetButtonView(orientation: .vertical, action: {})
            ResetButtonView(orientation: .horizontal, action: {})
        }
    }
}
