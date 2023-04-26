//
//  MazeView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 17/04/2023.
//

import SwiftUI

struct MazeView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var viewModel: Maze
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(.black)
            ForEach((0..<viewModel.map.rows), id: \.self) {
                let row = $0
                ForEach((0..<viewModel.map.columns), id: \.self) {
                    let column = $0
                    MazeCellView(cell: viewModel.map.cells[row][column]) {
                        if !viewModel.isSolved && !viewModel.isSolving {
                            if viewModel.isWall(atRow: row, column: column) {
                                viewModel.removeWall(atRow: row, column: column)
                            } else if !viewModel.isStartPoint(atRow: row, column: column) && !viewModel.isGoalPoint(atRow: row, column: column) {
                                    viewModel.setWall(atRow: row, column: column)
                            }
                        }
                    }
                }
            }
            .frame(width: CGFloat(viewModel.map.columns - 1) * CGFloat(cellSize.width), height: CGFloat(viewModel.map.rows - 1) * CGFloat(cellSize.height))
        }
        .frame(width: CGFloat(viewModel.map.columns + 2) * CGFloat(cellSize.width), height: CGFloat(viewModel.map.rows + 2) * CGFloat(cellSize.height))
        .rotationEffect(.degrees(horizontalSizeClass == .compact && verticalSizeClass == .regular ? 0 : -90))
    }
}

struct MazeView_Previews: PreviewProvider {
    static var previews: some View {
        MazeView()
            .environmentObject(Maze(map: Map.sampleData))
    }
}
