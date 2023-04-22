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
    @State private var rows = ""
    @State private var columns = ""
    @State private var startPoint: CGPoint?
    @State private var goalPoint: CGPoint?
    @State private var isSelectingStartPoint = false
    @State private var isSelectingGoalPoint = false
    @State private var showAlert = false
    
    
    var invalidNumberOfRowsOrColumns: Bool {
        Int(rows) ?? 0 > 16 || Int(rows) ?? 0 <= 0 || Int(columns) ?? 0 > 9 || Int(columns) ?? 0 <= 0
    }
    
    var missingInfo: Bool {
        Int(rows) == nil || Int(columns) == nil || startPoint == nil || goalPoint == nil
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                Color.indigo
                ScrollView {
                    Section(header: Text("CUSTOMIZE YOUR OWN MAZE").font(.title2).bold()) {
                        InputNumberView(property: $rows, headline: "Number of rows", subHeadline: "(between 1 & 16)")
                            .onChange(of: rows) { _ in
                                startPoint = nil
                                goalPoint = nil
                            }
                        InputNumberView(property: $columns, headline: "Number of columns", subHeadline: "(between 1 & 9)")
                            .onChange(of: columns) { _ in
                                startPoint = nil
                                goalPoint = nil
                            }
                            . padding(.bottom)
                        
                        HStack {
                            VStack {
                                StartGoalButtonView(isCustomizingMaze: $isCustomizingMaze, rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint, label: "Select Start") {
                                    isSelectingStartPoint = true
                                }
                                .padding(.top, startPoint == nil ? 0 : 28)
                                
                                if let startPoint = startPoint {
                                    Text("(\(Int(startPoint.x) + 1), \(Int(startPoint.y) + 1))")
                                }
                            }
                            VStack {
                                StartGoalButtonView(isCustomizingMaze: $isCustomizingMaze, rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint, label: "Select Goal") {
                                    isSelectingGoalPoint = true
                                }
                                .padding(.top, goalPoint == nil ? 0 : 28)
                                
                                if let goalPoint = goalPoint {
                                    Text("(\(Int(goalPoint.x) + 1), \(Int(goalPoint.y) + 1))")
                                }
                            }
                        } 
                        Button {
                            if invalidNumberOfRowsOrColumns {
                                showAlert = true
                                startPoint = nil
                                goalPoint = nil
                            } else {
                                maze.customizeMazeWith(rows: Int(rows) ?? 0, columns: Int(columns) ?? 0, startPoint: startPoint ?? CGPoint(), goalPoint: goalPoint ?? CGPoint())
                                isCustomizingMaze = false
                            }
                        } label: {
                            Text("Create")
                                .font(.title)
                                .bold()
                        }
                        .buttonStyle(.borderedProminent)
                        .cornerRadius(16)
                        .padding(.top, 50)
                        .disabled(missingInfo)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Invalid number of rows or columns"), message: Text("For display convenience, please select a number of rows between 1 & 16 and a number of columns between 1 & 9."), dismissButton: .default(Text("Ok")))
                        }
                    }
                }
                .padding(.top)
            }
            .foregroundColor(.white)
            .ignoresSafeArea(.container, edges: .bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCustomizingMaze = false
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .padding(.top, 10)
                    }
                }
            }
        }
    }
}

struct CustomizedMazeView_Previews: PreviewProvider {
    @State static var maze = Maze.createSampleData()
    static var previews: some View {
        CustomizedMazeView(isCustomizingMaze: .constant(true))
            .environmentObject(Maze.createSampleData())
    }
}
