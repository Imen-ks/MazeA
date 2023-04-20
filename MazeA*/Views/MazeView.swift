//
//  MazeView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 17/04/2023.
//

import SwiftUI

struct MazeView: View {
    @EnvironmentObject var maze: Maze
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(.black)
            ForEach((0..<maze.rows), id: \.self) {
                let row = $0
                ForEach((0..<maze.columns), id: \.self) {
                    let column = $0
                    MazeCellView(cell: maze.cells[row][column]) {
                        if maze.isWall(atRow: row, column: column) {
                            maze.removeWall(atRow: row, column: column)
                        } else {
                            maze.setWall(atRow: row, column: column)
                        }
                    }
                }
            }
            .frame(width: CGFloat(maze.columns - 1) * CGFloat(cellSize.width), height: CGFloat(maze.rows - 1) * CGFloat(cellSize.height))
        }
        .frame(width: CGFloat(maze.columns + 2) * CGFloat(cellSize.width), height: CGFloat(maze.rows + 2) * CGFloat(cellSize.height))
    }
}

struct MazeView_Previews: PreviewProvider {
    static var previews: some View {
        MazeView()
            .environmentObject(Maze.createSampleData())
    }
}
