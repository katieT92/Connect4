//
//  ContentView.swift
//  Connect4
//
//  Created by Katie Trombetta on 4/16/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        return MainMenu()
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
