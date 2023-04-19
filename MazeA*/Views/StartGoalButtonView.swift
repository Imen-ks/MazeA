//
//  StartGoalButtonView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 19/04/2023.
//

import SwiftUI

struct StartGoalButtonView: View {
    @Binding var isCustomizingMaze: Bool
    @Binding var rows: String
    @Binding var columns: String
    @Binding var startPoint: CGPoint?
    @Binding var goalPoint: CGPoint?
    @Binding var isSelectingStartPoint: Bool
    @Binding var isSelectingGoalPoint: Bool
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.title2)
                .bold()
            }
            .tint(.teal)
            .buttonStyle(.borderedProminent)
            .cornerRadius(16)
            .padding(.horizontal)
            .sheet(isPresented: $isSelectingStartPoint) {
                SelectCoordinatesView(isCustomizingMaze: $isCustomizingMaze, rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint)
            }
            .sheet(isPresented: $isSelectingGoalPoint) {
                SelectCoordinatesView(isCustomizingMaze: $isCustomizingMaze, rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint)
            }
    }
}

struct StartGoalButtonView_Previews: PreviewProvider {
    struct PreviewWrapper1: View {
        @State private var isCustomizingMaze = false
        @State private var rows = "8"
        @State private var columns = "8"
        @State private var startPoint = Optional(CGPoint(x: 0, y: 0))
        @State private var goalPoint = Optional(CGPoint(x: 7, y: 7))
        @State private var isSelectingStartPoint = false
        @State private var isSelectingGoalPoint = false
        var label = "Select Start"
        var action: () -> Void = {}
        
        var body: some View {
            StartGoalButtonView(isCustomizingMaze: $isCustomizingMaze, rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint, label: label, action: action)
        }
    }
    
    struct PreviewWrapper2: View {
        @State private var isCustomizingMaze = false
        @State private var rows = "8"
        @State private var columns = "8"
        @State private var startPoint = Optional(CGPoint(x: 0, y: 0))
        @State private var goalPoint = Optional(CGPoint(x: 7, y: 7))
        @State private var isSelectingStartPoint = false
        @State private var isSelectingGoalPoint = false
        var label = "Select Goal"
        var action: () -> Void = {}
        
        var body: some View {
            StartGoalButtonView(isCustomizingMaze: $isCustomizingMaze, rows: $rows, columns: $columns, startPoint: $startPoint, goalPoint: $goalPoint, isSelectingStartPoint: $isSelectingStartPoint, isSelectingGoalPoint: $isSelectingGoalPoint, label: label, action: action)
        }
    }
    
    static var previews: some View {
        VStack {
            PreviewWrapper1()
            PreviewWrapper2()
        }
        .environmentObject(Maze.createSampleData())
        .foregroundColor(.white)
    }
}
