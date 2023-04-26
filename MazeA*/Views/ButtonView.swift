//
//  ButtonView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 26/04/2023.
//

import SwiftUI

enum Orientation {
    case horizontal
    case vertical
}

struct ButtonView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var text: String
    var image: String
    var orientation: Orientation
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            if orientation == .vertical {
                Label(text, systemImage: image)
                    .font(.title2)
                    .frame(width: 100)
            } else if orientation == .horizontal {
                Image(systemName: image)
                    .font(.title)
                    .bold()
                    .frame(width: 40, height: 40)
            }
        }
        .padding(horizontalSizeClass == .compact && verticalSizeClass == .regular ? .horizontal : .vertical)
        .buttonStyle(.borderedProminent)
        .foregroundColor(.white)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            HStack {
                VStack{
                    ButtonView(text: "Solve", image: "gear", orientation: .vertical, action: {})
                    ButtonView(text: "Solve", image: "gear", orientation: .horizontal, action: {})
                }
                .padding(.horizontal)
                VStack{
                    ButtonView(text: "Reset", image: "arrow.counterclockwise", orientation: .vertical, action: {})
                    ButtonView(text: "Reset", image: "arrow.counterclockwise", orientation: .horizontal, action: {})
                }
                .padding(.horizontal)
            }
            .padding()
            HStack {
                VStack{
                    ButtonView(text: "Load", image: "folder.badge.gearshape", orientation: .vertical, action: {})
                        .tint(.indigo)
                    ButtonView(text: "Load", image: "folder.badge.gearshape", orientation: .horizontal, action: {})
                        .tint(.indigo)
                }
                .padding(.horizontal)
                VStack{
                    ButtonView(text: "Save", image: "externaldrive.badge.checkmark", orientation: .vertical, action: {})
                        .tint(.indigo)
                    ButtonView(text: "Save", image: "externaldrive.badge.checkmark", orientation: .horizontal, action: {})
                        .tint(.indigo)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}
