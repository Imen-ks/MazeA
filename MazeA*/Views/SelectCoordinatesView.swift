//
//  SelectCoordinatesView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 19/04/2023.
//

import SwiftUI

struct SelectCoordinatesView: View {
    @EnvironmentObject var viewModel: Maze
    @Binding var rows: String
    @Binding var columns: String
    @Binding var startPoint: CGPoint?
    @Binding var goalPoint: CGPoint?
    @Binding var isSelectingStartPoint: Bool
    @Binding var isSelectingGoalPoint: Bool
    @State private var selection: CGPoint?
    
    var invalidNumberOfRowsOrColumns: Bool {
        Int(rows) ?? 0 > 16 || Int(rows) ?? 0 <= 0 || Int(columns) ?? 0 > 9 || Int(columns) ?? 0 <= 0 || rows.isEmpty || columns.isEmpty
    }
    
    var invalidSelectionMessage: String {
        """
        The number of rows and columns cannot be empty.
        For display convenience, please select a number of rows between 1 & 16 and a number of columns between 1 & 9.
        """
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.teal
                    .opacity(0.7)
                    .ignoresSafeArea(.container, edges: .bottom)
                if invalidNumberOfRowsOrColumns {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .padding(.top)
                            .font(.largeTitle)
                        Text(invalidSelectionMessage)
                            .font(.title)
                            .padding()
                    }
                    .foregroundColor(.teal)
                    .background()
                    .background()
                    .cornerRadius(16)
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                startPoint = nil
                                goalPoint = nil
                                isSelectingStartPoint = false
                                isSelectingGoalPoint = false
                            } label: {
                                Image(systemName: "xmark")
                                    .bold()
                                    .padding(.top, 10)
                            }
                            .foregroundColor(.accentColor)
                        }
                    }
                } else {
                    if isSelectingStartPoint {
                        VStack {
                            TemporaryMazeView(rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, selection: $selection) {
                                startPoint = selection
                            }
                        }
                        .navigationTitle("Start position")
                        .navigationBarTitleDisplayMode(.inline)
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
                    } else if isSelectingGoalPoint {
                        VStack {
                            TemporaryMazeView(rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, selection: $selection) {
                                goalPoint = selection
                            }
                        }
                        .navigationTitle("Goal position")
                        .navigationBarTitleDisplayMode(.inline)
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
        @State private var rows = "8"
        @State private var columns = "8"
        @State private var startPoint = Optional(CGPoint(x: 0, y: 0))
        @State private var goalPoint = Optional(CGPoint(x: 7, y: 7))
        @State private var isSelectingStartPoint = true
        @State private var isSelectingGoalPoint = true
        
        var body: some View {
            SelectCoordinatesView(rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .environmentObject(Maze(map: Map.sampleData))
    }
}
