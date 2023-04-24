//
//  TemporaryMazeView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 22/04/2023.
//

import SwiftUI

struct TemporaryMazeView: View {
    @EnvironmentObject var viewModel: Maze
    @Binding var rows: String
    @Binding var columns: String
    @Binding var startPoint: CGPoint?
    @Binding var goalPoint: CGPoint?
    @Binding var selection: CGPoint?
    
    var action: () -> Void
       
    var tempMaze: Maze {
        return viewModel.customizeMazeWith(rows: Int(rows) ?? 0, columns: Int(columns) ?? 0, startPoint: startPoint, goalPoint: goalPoint)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(.black)
            ForEach((0..<tempMaze.rows), id: \.self) {
                let row = $0
                ForEach((0..<tempMaze.columns), id: \.self) {
                    let column = $0
                    MazeCellView(cell: tempMaze.cells[row][column]) {
                        selection = CGPoint(x: row, y: column)
                        action()
                    }
                }
            }
            .frame(width: CGFloat(tempMaze.columns - 1) * CGFloat(cellSize.width), height: CGFloat(tempMaze.rows - 1) * CGFloat(cellSize.height))
            
        }
        .frame(width: CGFloat(tempMaze.columns + 2) * CGFloat(cellSize.width), height: CGFloat(tempMaze.rows + 2) * CGFloat(cellSize.height))
    }
}

struct TemporaryMazeView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var isCustomizingMaze = false
        @State private var rows = "8"
        @State private var columns = "8"
        @State private var startPoint = Optional(CGPoint(x: 0, y: 0))
        @State private var goalPoint = Optional(CGPoint(x: 7, y: 7))
        @State private var isSelectingStartPoint = true
        @State private var isSelectingGoalPoint = true
        @State private var selection = Optional(CGPoint(x: 4, y: 2))
        
        
        var body: some View {
            TemporaryMazeView(rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, selection: $selection, action: {})
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .environmentObject(Maze.createSampleData())
    }
}
