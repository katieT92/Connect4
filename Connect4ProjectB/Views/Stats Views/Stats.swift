
import SwiftUI
import CoreData

struct Stats: View {
    var viewModel: ViewModel

    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    @FetchRequest(fetchRequest: Game.fetchAll()) var game: FetchedResults<Game>
    @FetchRequest(fetchRequest: Player.fetchAll()) var players: FetchedResults<Player>
    @FetchRequest(fetchRequest: Player.fetchWinsDescending()) var winsDescending: FetchedResults<Player>
    @FetchRequest(fetchRequest: Player.fetchLossesDescending()) var lossessDescending: FetchedResults<Player>
    @FetchRequest(fetchRequest: Player.fetchSecondPlayer()) var secondPlayer: FetchedResults<Player>
    
    
    var body: some View {
        GeometryReader { geometry in
            body(geometry)
        }
    }
    

    func body(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height
        
        return ZStack{
            //BackgroundImage()
            VStack(){
                Text("Stats").font(.title)
                    .padding().foregroundColor(.black)
                playerRow(width: width, height: height)
                overview(width: width, height: height)
                totals(width: width, height: height)
                playerStats(width: width, height: height)
            }
        }
        .navigationBarTitle(Text("Stats"), displayMode: .automatic)
        //.navigationBarHidden(true)
        .padding()
    }
    
    
    
    func playerRow(width: CGFloat, height: CGFloat) -> some View {
        return HStack(spacing:width*0.1){
            VStack{
                Circle()
                    .stroke(lineWidth: 1.0)
                    .background(Circle().fill(Color.green))
                    .frame(width:width*0.1)
                Text("P1")
            }

            VStack{
                Circle()
                    .stroke(lineWidth: 1.0)
                    .background(Circle().fill(Color.red))
                    .frame(width:width*0.1)
                    Text("P2")
            }

            VStack{
                Circle()
                    .stroke(lineWidth: 1.0)
                    .background(Circle().fill(Color.gray))
                    .frame(width:width*0.1)
                    Text("AI")
            }
        }.frame(height:height*0.1)

    }
    
    
    
    func overview(width: CGFloat, height: CGFloat) -> some View {
        print("in Stats -> overview()")
        let p1WinLoss = (players.first!.wins+1) / (players.first!.losses+1)
        print("p1WinLoss: \(p1WinLoss)")
        let p2WinLoss = (secondPlayer.first!.wins+1) / (secondPlayer.first!.losses+1)
        print("p2WinLoss: \(p2WinLoss)")
        let aiWinLoss = (players.last!.wins+1) / (players.last!.losses+1)
        print("aiWinLoss: \(aiWinLoss)")
        let bestWinLoss = players.first!.wins + players.first!.losses == 0 &&
            players.last!.wins + players.last!.losses == 0 &&
            secondPlayer.first!.wins + secondPlayer.first!.losses == 0 ? 0 : max(p1WinLoss, p2WinLoss, aiWinLoss);
        print("bestWinLoss: \(bestWinLoss)")
        var bestWinLossPlayerId: Int
        switch (bestWinLoss){
        case p1WinLoss:
            bestWinLossPlayerId = 0
        case p2WinLoss:
            bestWinLossPlayerId = 1
        case aiWinLoss:
            bestWinLossPlayerId = 2
        default:
            bestWinLossPlayerId = 3
        }
        print("bestwinlossPlayerId: \(bestWinLossPlayerId)")

        return VStack(alignment:.leading){
            HStack{
                Text("Overview").font(.title2)
                Spacer()
            }
            
            HStack{
                Circle()
                    .stroke(lineWidth: 1.0)
                    .background(Circle().fill(stringColorToUiColor(colorId: viewModel.getStatsColors()[winsDescending.first!.wins == 0 ? 3 : Int(winsDescending.first!.id)])))
                    .frame(width:width*0.05)
                Text("Most Wins")
                Spacer()
                Text("\(winsDescending.first!.wins_)")
                Rectangle().opacity(0.0).frame(width:width*0.2)
            }
            
            HStack{
                Circle()
                    .stroke(lineWidth: 1.0)
                    .background(Circle().fill(stringColorToUiColor(colorId: viewModel.getStatsColors()[lossessDescending.first!.losses == 0 ? 3 : Int(lossessDescending.first!.id)])))
                    .frame(width:width*0.05)
                Text("Most Losses")
                Spacer()
                Text("\(lossessDescending.first!.losses_)")
                Rectangle().opacity(0.0).frame(width:width*0.2)
            }
            
            HStack{
                Circle()
                    .stroke(lineWidth: 1.0)
                    .background(Circle().fill(stringColorToUiColor(colorId: viewModel.getStatsColors()[bestWinLossPlayerId])))
                    .frame(width:width*0.05)
                Text("Best W/L Ratio")
                Spacer()
                Text("\(bestWinLoss)")
                Rectangle().opacity(0.0).frame(width:width*0.2)
            }
        }
        .frame(height:height*0.25)
        .padding(.top)
    }
    
    
    

    func totals(width: CGFloat, height: CGFloat) -> some View{
        VStack(){
            HStack{
                Text("Totals").font(.title3).padding(.top)
                Spacer()
            }
            .frame(height:height*0.1)
            HStack(spacing:width*0.1){
                VStack{
                    Text("Games").font(.headline)
                    Text("\(game.first!.games_)")
                }
                
                VStack{
                    Text("Draws").font(.headline)
                    Text("\(game.first!.draws_)")
                }
            
                VStack{
                    Text("Moves").font(.headline)
                    Text("\(players.first!.moves_ + secondPlayer.first!.moves_ + players.last!.moves_)")
                }
            }
            .frame(height:height*0.1)
        }
        .frame(height:height*0.2)
    }
    
    
    
    func playerStats(width: CGFloat, height: CGFloat) -> some View {
        VStack(){
            HStack{
                Text("Player Stats").font(.title2).padding(.top)
                Spacer()
            }
            HStack(spacing:width*0.1){
                NavigationLink(destination: DetailedStats(viewModel: viewModel, playerId: players.first!.id, player: "Player 1"/*, context: context*/)){
                    Circle()
                        .stroke(lineWidth: 1.0)
                        .background(Circle().fill(Color.green))
                        .overlay(Text("...").foregroundColor(.black))
                        .frame(width:width*0.1)
                }
                NavigationLink(destination: DetailedStats(viewModel: viewModel, playerId: secondPlayer.first!.id, player: "Player 2"/*, context: context*/)){
                    Circle()
                        .stroke(lineWidth: 1.0)
                        .background(Circle().fill(Color.red))
                        .overlay(Text("...").foregroundColor(.black))
                        .frame(width:width*0.1)
                }
                NavigationLink(destination: DetailedStats(viewModel: viewModel, playerId: players.last!.id, player: "AI"/*, context: context*/)){
                    Circle()
                        .stroke(lineWidth: 1.0)
                        .background(Circle().fill(Color.gray))
                        .overlay(Text("...").foregroundColor(.black))
                        .frame(width:width*0.1)
                }
            }
        }
        .frame(height:height*0.2)
    }
    
    
    
    // Converts a String representation of a color to type Color
    func stringColorToUiColor(colorId: String) -> Color {
        switch (colorId){
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        case "purple": return .purple
        case "white": return .white
        case "black": return .black
        case "gray": return .gray
        case "pink": return .pink
        default: return .white
        }
    }
}


struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats(viewModel: ViewModel())
    }
}
