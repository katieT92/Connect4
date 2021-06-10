
import SwiftUI

struct OpponentSelection: View {
    var viewModel: ViewModel

    var body: some View {
        GeometryReader { geometry in
            body(geometry)
        }
    }
    
    
    func body(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height
        
        return ZStack{
                VStack{
    //                Text("Choose Your Opponent").font(.title).frame(height:height*0.2)
    //                .padding().foregroundColor(.white)
                    NavigationLink(destination: GameArea(opponent: viewModel.playerNames()[1])){
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 5.0).opacity(0.3)
                            .background(Circle().fill(Color.green))
                            .frame(width: width * 0.5)
                            .overlay(Text("Pass & Play").font(.title2).foregroundColor(.black))
                    }
                    
                    NavigationLink(destination: GameArea(opponent: viewModel.playerNames()[2])){
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 5.0).opacity(0.3)
                            .background(Circle().fill(Color.red))
                            .frame(width: width * 0.5)
                            .overlay(Text(viewModel.playerNames()[2]).font(.title2).foregroundColor(.black))
                    }
                }.navigationBarTitle(Text("Opponent"), displayMode: .automatic)
                    //.navigationBarHidden(true)
                .frame(width: width)
        }
    }
}



struct OpponentSelection_Previews: PreviewProvider {
    static var previews: some View {
        OpponentSelection(viewModel: ViewModel())
    }
}
