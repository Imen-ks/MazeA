//
//  SelectCoordinatesView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 19/04/2023.
//

import SwiftUI

struct SelectCoordinatesView: View {
    @EnvironmentObject var maze: Maze
    @Binding var isCustomizingMaze: Bool
    @Binding var rows: String
    @Binding var columns: String
    @Binding var startPoint: CGPoint?
    @Binding var goalPoint: CGPoint?
    @Binding var isSelectingStartPoint: Bool
    @Binding var isSelectingGoalPoint: Bool
    
    var tempMaze: Maze? {
        if Int(rows) ?? 0 > 0 && Int(columns) ?? 0 > 0 {
            return maze.customizeMazeWith(rows: Int(rows) ?? 0, columns: Int(columns) ?? 0, startPoint: startPoint, goalPoint: goalPoint)
        }
        return nil
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.teal
                    .opacity(0.7)
                    .ignoresSafeArea(.container, edges: .bottom)
                if isSelectingStartPoint {
                    if let tempMaze = tempMaze {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(.black)
                            ForEach((0..<tempMaze.rows), id: \.self) {
                                let row = $0
                                ForEach((0..<tempMaze.columns), id: \.self) {
                                    let column = $0
                                    MazeCellView(cell: tempMaze.cells[row][column]) {
                                        startPoint = CGPoint(x: row, y: column)
                                    }
                                }
                            }
                            .frame(width: CGFloat(tempMaze.columns - 1) * CGFloat(cellSize.width), height: CGFloat(tempMaze.rows - 1) * CGFloat(cellSize.height))
                            
                        }
                        .frame(width: CGFloat(tempMaze.columns + 2) * CGFloat(cellSize.width), height: CGFloat(tempMaze.rows + 2) * CGFloat(cellSize.height))
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    isSelectingStartPoint = false
                                } label: {
                                    Image(systemName: "xmark")
                                        .bold()
                                        .padding(.top, 10)
                                }
                                .foregroundColor(.accentColor)
                            }
                        }
                    }
                } else if isSelectingGoalPoint {
                    if let tempMaze = tempMaze {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(.black)
                            ForEach((0..<tempMaze.rows), id: \.self) {
                                let row = $0
                                ForEach((0..<tempMaze.columns), id: \.self) {
                                    let column = $0
                                    MazeCellView(cell: tempMaze.cells[row][column]) {
                                        goalPoint = CGPoint(x: row, y: column)
                                    }
                                }
                            }
                            .frame(width: CGFloat(tempMaze.columns - 1) * CGFloat(cellSize.width), height: CGFloat(tempMaze.rows - 1) * CGFloat(cellSize.height))
                            
                        }
                        .frame(width: CGFloat(tempMaze.columns + 2) * CGFloat(cellSize.width), height: CGFloat(tempMaze.rows + 2) * CGFloat(cellSize.height))
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    isSelectingGoalPoint = false
                                } label: {
                                    Image(systemName: "xmark")
                                        .bold()
                                        .padding(.top, 10)
                                }
                                .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SelectCoordinatesView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var isCustomizingMaze = false
        @State private var rows = "8"
        @State private var columns = "8"
        @State private var startPoint = Optional(CGPoint(x: 0, y: 0))
        @State private var goalPoint = Optional(CGPoint(x: 7, y: 7))
        @State private var isSelectingStartPoint = true
        @State private var isSelectingGoalPoint = true
        
        var body: some View {
            SelectCoordinatesView(isCustomizingMaze: $isCustomizingMaze, rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .environmentObject(Maze.createSampleData())
    }
}
