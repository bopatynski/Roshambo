//
//  ContentView.swift
//  Roshambo
//
//  Created by Bogdan Patynski on 2022-04-26.
//

import SwiftUI
// Adding stuff so I can push to remote
extension Image {
    
    func choiceImage() -> some View{
        self
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
    
}

struct ScoreTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
    }
}
extension View {
    func scoreModifier() -> some View{
        self.modifier(ScoreTitle())
    }
}

struct ContentView: View {
    @State private var user1 = "Rock"
    @State private var user2 = "Paper"
    @State private var moves = ["Rock", "Paper", "Scissors"]
    @State private var yourScore = 0
    @State private var oppScore = 0
    @State private var round = 1
    @State private var won = false
    @State private var showScore = false
    @State private var whoWon = ""
    enum winOrLose{
        case win
        case lose
        case draw
        case none
    }
    
    func user2Move() {
        user2 = moves[Int.random(in: 0...2)]
    }
    
    func nextRound() {
        showScore = false
        round = round + 1
    }
    
    func choiceTapped(_ number:Int){
        user2Move()
        if user1 == "Rock"{
            if user2 == "Scissors" {
                yourScore = yourScore + 1
                won = true
                showScore = true
                whoWon = "You Win"
            } else if user2 == "Paper" {
                oppScore = oppScore + 1
                won = false
                showScore = true
                whoWon = "You Lost"
            } else {
                won = false
                showScore = true
                whoWon = "It's a draw"
            }
        }
        if user1 == "Paper"{
            if user2 == "Rock" {
                yourScore = yourScore + 1
                won = true
                showScore = true
                whoWon = "You Win"
            } else if user2 == "Scissors" {
                oppScore = oppScore + 1
                won = false
                showScore = true
                whoWon = "You Lost"
            } else {
                won = false
                showScore = true
                whoWon = "It's a draw"
            }
        }
        else {
            if user2 == "Paper" {
                yourScore = yourScore + 1
                won = true
                showScore = true
                whoWon = "You Win"
            } else if user2 == "Rock" {
                oppScore = oppScore + 1
                won = false
                showScore = true
                whoWon = "You Lost"
            } else {
                won = false
                showScore = true
                whoWon = "It's a draw"
            }
        }
    }
    
    
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Your score: \(yourScore)").scoreModifier()
                Spacer()
                Text("Your opponent's score : \(oppScore)").scoreModifier()
                VStack{
                    ForEach(0..<3){number in
                        Button{
                            choiceTapped(number)
                        }label: {
                            Image(moves[number]).choiceImage().padding()
                        }
                        .alert("Round Score", isPresented: $showScore) {
                            Button("Restart", action: nextRound)
                        } message: {
                            Text("You chose \(user1) and AI chose \(user2). \n \(whoWon)")
                        }
                    }
                }
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
