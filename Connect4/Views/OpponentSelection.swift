//
//  OpponentSelection.swift
//  Connect4
//
//  Created by Katie Trombetta on 4/16/21.
//

import SwiftUI

struct OpponentSelection: View {

    var body: some View {
        ZStack{
            VStack{
                NavigationLink(destination: Game()){   // Links the following Circle as a clickable item
                                                                    // to the destination View, "Opponent Selection"
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 150.0)
                        .overlay(Text("Pass & Play").foregroundColor(.black))
                }
                
                NavigationLink(destination: Game()){   // Links the following Circle as a clickable item
                                                                    // to the destination View, "Opponent Selection"
                    Circle()
                        .fill(Color.red)
                        .frame(width: 150.0)
                        .overlay(Text("AI").foregroundColor(.black))
                }
            }.navigationBarTitle(Text("Opponent"), displayMode: .automatic) //Counldt figure out how to align this to center, so commented out and added back in the "Connect 4" Text element as the first stack in our VStack above (Line26)
        }
    }
}

struct OpponentSelection_Previews: PreviewProvider {
    static var previews: some View {
        OpponentSelection()
    }
}
