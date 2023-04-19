//
//  CustomizedMazeView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 19/04/2023.
//

import SwiftUI

struct CustomizedMazeView: View {
    @EnvironmentObject var maze: Maze
    @Binding var isCustomizingMaze: Bool
    var body: some View {
        Button {
            // temporary logic for test purpose - to be updated
            maze.customizeMazeWith(rows: 8, columns: 8, startPoint: CGPoint(x: 0, y: 0), goalPoint: CGPoint(x: 7, y: 7))
            isCustomizingMaze = false
        } label: {
            Text("Create")
                .font(.largeTitle)
                .bold()
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }
}

struct CustomizedMazeView_Previews: PreviewProvider {
    @State static var maze = Maze.createSampleData()
    static var previews: some View {
        CustomizedMazeView(isCustomizingMaze: .constant(true))
            .environmentObject(Maze.createSampleData())
    }
}
