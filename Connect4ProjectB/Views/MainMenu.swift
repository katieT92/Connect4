
import SwiftUI

struct MainMenu: View {
    var viewModel: ViewModel

    var body: some View {
        GeometryReader { geometry in
            body(geometry)
        }
    }
    
    func body(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height
        return NavigationView {
            ZStack{
                BackgroundImage()
                VStack{
                    Text("Connect 4").font(.largeTitle).padding().frame(height:height*0.2).foregroundColor(.white)
                    NavigationLink(destination: OpponentSelection(viewModel: viewModel)){
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 5.0).opacity(0.3)
                            .background(Circle().fill(Color.green))
                            .frame(width: width * 0.5)
                            .overlay(Text("Start Game").font(.title2).foregroundColor(.black))
                    }
                    NavigationLink(destination: Stats(viewModel: viewModel)){
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 5.0).opacity(0.3)
                            .background(Circle().fill(Color.red))
                            .frame(width: width * 0.5)
                            .overlay(Text("Stats").font(.title2).foregroundColor(.black))
                    }
                }
            }
            .navigationBarTitle(Text("Menu"), displayMode: .automatic)
                .navigationBarHidden(true)
        }
    }
}


struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(viewModel: ViewModel())
    }
}
