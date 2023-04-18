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
                    if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                        VStack {
                            MazeView()
                            
                            HStack {
                                SolveButtonView(orientation: .vertical, action: {
                                    Task {
                                        await maze.getSolution()
                                    }
                                })
                                .padding(.horizontal)
                                .disabled(isSolved)
                                
                                ResetButtonView(orientation: .vertical, action: {
                                    maze.reset()
                                })
                                .padding(.horizontal)
                                .disabled(isSolving)
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            
                            LoadMazeButtonView(orientation: .vertical, action: {
                                // Missing logic for maze uploading
                            })
                        }
                     } else {
                         HStack {
                             LoadMazeButtonView(orientation: .horizontal, action: {
                                 // Missing logic for maze uploading
                             })
                             .padding(.bottom, 8)
                             
                             MazeView()
                                 .rotationEffect(.degrees(-90))
                                 .padding(.leading, 120) // to adjust the misbehavior of HStack on rotation - to be checked
                             
                             VStack {
                                 SolveButtonView(orientation: .horizontal, action: {
                                     Task {
                                         await maze.getSolution()
                                     }
                                 })
                                 .padding(.vertical)
                                 .disabled(isSolved)
                                 
                                 ResetButtonView(orientation: .horizontal, action: {
                                     maze.reset()
                                 })
                                 .padding(.vertical)
                                 .disabled(isSolving)
                             }
                             .padding(.leading, 120) // to adjust the misbehavior of HStack on rotation - to be checked
                             .padding(.trailing, 50)
                         }
                     }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // Missing logic for maze description
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .bold()
                            .padding(.top, 25)
                    }
                }
                ToolbarItem {
                    Button {
                        // Missing logic for maze creation
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .bold()
                            .padding(.top, 25)
                    }
                }
            }
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(Maze.createSampleData())
    }
}
