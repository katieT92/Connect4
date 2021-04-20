//
//  MainMenu.swift
//  Connect4
//
//  Created by Katie Trombetta on 4/16/21.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        GeometryReader { geometry in
            body(geometry)
        }
    }
    
    func body(_ geometry: GeometryProxy) -> some View {
            
        return NavigationView {        // Makes everything in this view navigatable and
                                // adds navigation elements like back arrows and such
            ZStack{             // Used to layer our background color and main elements
                  // First stack in ZStack
                
                VStack{         // Second stack in ZStack
                    Text("Connect 4").font(.title).padding()
                    NavigationLink(destination: OpponentSelection()){   // Links the following Circle as a clickable item
                                                                        // to the destination View, "Opponent Selection"
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 150)
                            .overlay(Text("Start Game").foregroundColor(.black))
                    }
                    
                    NavigationLink(destination: OpponentSelection()){   // Links the following Circle as a clickable item
                                                                        // to the destination View, "Opponent Selection"
                        Circle()
                            .fill(Color.red)
                            .frame(width: 150)
                            .overlay(Text("Stats").foregroundColor(.black))
                    }
                }
            //.navigationBarTitle(Text("Connect 4"), displayMode: .automatic) Counldt figure out how to align this to center, so commented out and added back in the "Connect 4" Text element as the first stack in our VStack above (Line26)
                .navigationBarHidden(true)
            }
        }
    }
}


struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
