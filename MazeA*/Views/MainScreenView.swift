//
//  MainScreenView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 14/04/2023.
//

import SwiftUI

struct MainScreenView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var maze: Maze
    @State private var isNotSolvable = false
    @State private var showDescription = false
    @State private var isCustomizingMaze = false
    
    var isSolving: Bool {
        maze.isSolving
    }
    var isSolved: Bool {
        maze.isSolved
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                Color.teal
                    .opacity(0.7)
                    .ignoresSafeArea()
                Group {
                    //--------------------PORTRAIT LAYOUT--------------------//
                    if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                        VStack {
                            MazeView()
                            
                            HStack {
                                SolveButtonView(orientation: .vertical) {
                                    Task {
                                        await maze.getSolution()
                                        if let _ = maze.solution {
                                            isNotSolvable = false
                                        } else {
                                            isNotSolvable = true
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .disabled(isSolved)
                                .sheet(isPresented: $isNotSolvable) {
                                    NoSolutionModalView()
                                        .presentationDetents([.medium])
                                }
                                
                                ResetButtonView(orientation: .vertical) {
                                    maze.reset()
                                }
                                .padding(.horizontal)
                                .disabled(isSolving)
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            
                            LoadMazeButtonView(orientation: .vertical) {
                                maze.reset()
                                maze.loadMaze()
                            }
                        }
                     } else {
                         //-------------------LANDSCAPE LAYOUT------------------//
                         HStack {
                             LoadMazeButtonView(orientation: .horizontal) {
                                 maze.reset()
                                 maze.loadMaze()
                             }
                             .padding(.bottom, 8)
                             
                             MazeView()
                                 .rotationEffect(.degrees(-90))
                                 .padding(.leading, 120) // for adjusting the misbehavior of HStack on rotation - to be checked
                             
                             VStack {
                                 SolveButtonView(orientation: .horizontal) {
                                     Task {
                                         await maze.getSolution()
                                         if let _ = maze.solution {
                                             isNotSolvable = false
                                         } else {
                                             isNotSolvable = true
                                         }
                                     }
                                 }
                                 .padding(.vertical)
                                 .disabled(isSolved)
                                 .sheet(isPresented: $isNotSolvable) {
                                     NoSolutionModalView()
                                         .presentationDetents([.medium])
                                 }
                                 
                                 ResetButtonView(orientation: .horizontal) {
                                     maze.reset()
                                 }
                                 .padding(.vertical)
                                 .disabled(isSolving)
                             }
                             .padding(.leading, 120) // for adjusting the misbehavior of HStack on rotation - to be checked
                             .padding(.trailing, 50)
                         }
                     }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showDescription = true
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .bold()
                            .padding(.top, 25)
                    }
                    .sheet(isPresented: $showDescription) {
                        MazeDescriptionView(showDescription: $showDescription)
                    }
                }
                ToolbarItem {
                    Button {
                        maze.reset()
                        isCustomizingMaze = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .bold()
                            .padding(.top, 25)
                    }
                    .sheet(isPresented: $isCustomizingMaze) {
                        CustomizedMazeView(isCustomizingMaze: $isCustomizingMaze)
                    }
                }
            }
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var isNotSolvable = false
        @State private var showDescription = false
        @State private var isCustomizingMaze = false
        
        var body: some View {
            MainScreenView()
                .environmentObject(Maze.createSampleData())
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
