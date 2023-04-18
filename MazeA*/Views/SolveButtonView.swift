//
//  SolveButtonView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 17/04/2023.
//

import SwiftUI

enum Orientation {
    case horizontal
    case vertical
}

struct SolveButtonView: View {
    var orientation: Orientation
    var action: () -> Void
    var body: some View {
        Button(action: action) {
                 if orientation == .vertical {
                Text("Solve")
                    .font(.title2)
                    .frame(width: 100)
            } else if orientation == .horizontal {
                Image(systemName: "gear")
                    .font(.title)
                    .bold()
                    .frame(width: 40)
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

struct SolveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SolveButtonView(orientation: .vertical, action: {})
            SolveButtonView(orientation: .horizontal, action: {})
        }
    }
}
