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
    @EnvironmentObject var viewModel: Maze
    @StateObject var mapService = MapService()
    @State private var isNotSolvable = false
    @State private var showDescription = false
    @State private var isCustomizingMaze = false
    @State private var isLoadingMaze = false
    @State private var showAlert = false
    
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
                            HStack {
                                ButtonView(text: "Load", image: "folder.badge.gearshape", orientation: .vertical) {
                                    viewModel.reset()
                                    isLoadingMaze = true
                                }
                                .tint(.indigo)
                                .disabled(viewModel.isSolving)
                                .sheet(isPresented: $isLoadingMaze) {
                                    MapListView(isLoadingMaze: $isLoadingMaze)
                                }
                                
                                ButtonView(text: "Save", image: "externaldrive.badge.checkmark", orientation: .vertical) {
                                    showAlert = true
                                    viewModel.reset()
                                    mapService.save(map: viewModel.map)
                                    UserDefaults.standard.setValue("map_\(viewModel.map.id)", forKey: "fileSystem")
                                }
                                .tint(.indigo)
                                .disabled(viewModel.isSolving)
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("This maze has been saved in your App !"), message: Text("Click the \"Load\" button to browse the list of all saved mazes."), dismissButton: .default(Text("Ok")))
                                }
                                
                            }
                            .padding()
                            Spacer()
                            MazeView()
                            Spacer()
                            HStack {
                                ButtonView(text: "Solve", image: "gear", orientation: .vertical) {
                                    Task {
                                        await viewModel.getSolution()
                                        if let _ = viewModel.solution {
                                            isNotSolvable = false
                                        } else {
                                            isNotSolvable = true
                                        }
                                    }
                                }
                                .disabled(viewModel.isSolved || viewModel.isSolving)
                                .sheet(isPresented: $isNotSolvable) {
                                    NoSolutionModalView()
                                        .presentationDetents([.medium])
                                }
                                
                                ButtonView(text: "Reset", image: "arrow.counterclockwise", orientation: .vertical) {
                                    viewModel.reset()
                                }
                                .disabled(viewModel.isSolving)
                            }
                            .padding(.top, 10)
                        }
                     } else {
                         //-------------------LANDSCAPE LAYOUT------------------//
                         HStack {
                             VStack {
                                 ButtonView(text: "Load", image: "folder.badge.gearshape", orientation: .horizontal) {
                                     viewModel.reset()
                                     isLoadingMaze = true
                                 }
                                 .tint(.indigo)
                                 .disabled(viewModel.isSolving)
                                 .sheet(isPresented: $isLoadingMaze) {
                                     MapListView(isLoadingMaze: $isLoadingMaze)
                                 }
                                 
                                 ButtonView(text: "Save", image: "externaldrive.badge.checkmark", orientation: .horizontal) {
                                     showAlert = true
                                     viewModel.reset()
                                     mapService.save(map: viewModel.map)
                                     UserDefaults.standard.setValue("map_\(viewModel.map.id)", forKey: "fileSystem")
                                 }
                                 .tint(.indigo)
                                 .disabled(viewModel.isSolving)
                                 .alert(isPresented: $showAlert) {
                                     Alert(title: Text("This maze has been saved in your App !"), message: Text("Click the \"Load\" button to browse the list of all saved mazes."), dismissButton: .default(Text("Ok")))
                                 }
                             }
                             Spacer()
                             MazeView()
                             Spacer()
                             VStack {
                                 ButtonView(text: "Solve", image: "gear", orientation: .horizontal) {
                                     Task {
                                         await viewModel.getSolution()
                                         if let _ = viewModel.solution {
                                             isNotSolvable = false
                                         } else {
                                             isNotSolvable = true
                                         }
                                     }
                                 }
                                 .disabled(viewModel.isSolved || viewModel.isSolving)
                                 .sheet(isPresented: $isNotSolvable) {
                                     NoSolutionModalView()
                                         .presentationDetents([.medium])
                                 }
                                 
                                 ButtonView(text: "Reset", image: "arrow.counterclockwise", orientation: .horizontal) {
                                     viewModel.reset()
                                 }
                                 .disabled(viewModel.isSolving)
                             }
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
                        viewModel.reset()
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
                .environmentObject(Maze(map: Map.sampleData))
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
