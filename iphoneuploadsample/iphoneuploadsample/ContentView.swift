//
//  ContentView.swift
//  iphoneuploadsample
//
//  Created by 宮内耕介 on 2025/08/03.
//

import SwiftUI
import SwiftData

enum Hand: String, CaseIterable {
    case rock = "グー"
    case paper = "パー"
    case scissors = "チョキ"
    
    var emoji: String {
        switch self {
        case .rock:
            return "✊"
        case .paper:
            return "✋"
        case .scissors:
            return "✌️"
        }
    }
    
    static func random() -> Hand {
        return Hand.allCases.randomElement()!
    }
}

enum GameResult: String {
    case win = "あなたの勝ち！"
    case lose = "あなたの負け..."
    case draw = "あいこ"
}

struct RockPaperScissorsGame {
    static func play(playerHand: Hand, computerHand: Hand) -> GameResult {
        if playerHand == computerHand {
            return .draw
        }
        
        switch (playerHand, computerHand) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return .win
        default:
            return .lose
        }
    }
}

struct RockPaperScissorsView: View {
    @State private var playerHand: Hand?
    @State private var computerHand: Hand?
    @State private var gameResult: GameResult?
    @State private var showResult = false
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("じゃんけんゲーム")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                VStack {
                    Text("あなた")
                        .font(.headline)
                    Text("\(playerScore)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text("VS")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                VStack {
                    Text("コンピューター")
                        .font(.headline)
                    Text("\(computerScore)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 40)
            
            HStack {
                VStack {
                    Text("あなた")
                        .font(.headline)
                    Text(playerHand?.emoji ?? "?")
                        .font(.system(size: 80))
                    Text(playerHand?.rawValue ?? "")
                        .font(.caption)
                }
                
                Spacer()
                
                VStack {
                    Text("コンピューター")
                        .font(.headline)
                    Text(computerHand?.emoji ?? "?")
                        .font(.system(size: 80))
                    Text(computerHand?.rawValue ?? "")
                        .font(.caption)
                }
            }
            .padding(.horizontal, 40)
            
            if showResult, let result = gameResult {
                Text(result.rawValue)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorForResult(result))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorForResult(result).opacity(0.1))
                    )
            }
            
            VStack(spacing: 15) {
                Text("手を選んでください")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    ForEach(Hand.allCases, id: \.self) { hand in
                        Button(action: {
                            playGame(with: hand)
                        }) {
                            VStack {
                                Text(hand.emoji)
                                    .font(.system(size: 50))
                                Text(hand.rawValue)
                                    .font(.caption)
                            }
                            .frame(width: 80, height: 80)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(15)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            Button("リセット") {
                resetGame()
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
    
    private func playGame(with playerChoice: Hand) {
        playerHand = playerChoice
        computerHand = Hand.random()
        
        if let computer = computerHand {
            gameResult = RockPaperScissorsGame.play(playerHand: playerChoice, computerHand: computer)
            
            switch gameResult {
            case .win:
                playerScore += 1
            case .lose:
                computerScore += 1
            case .draw, .none:
                break
            }
        }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            showResult = true
        }
    }
    
    private func resetGame() {
        playerHand = nil
        computerHand = nil
        gameResult = nil
        showResult = false
        playerScore = 0
        computerScore = 0
    }
    
    private func colorForResult(_ result: GameResult) -> Color {
        switch result {
        case .win:
            return .green
        case .lose:
            return .red
        case .draw:
            return .orange
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            RockPaperScissorsView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("じゃんけん")
                }
            
            ItemListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("アイテム")
                }
        }
    }
}

struct ItemListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
