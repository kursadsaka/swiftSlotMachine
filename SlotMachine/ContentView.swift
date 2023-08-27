//
//  ContentView.swift
//  SlotMachine
//
//  Created by Kürşad Saka on 27.08.2023.
//

import SwiftUI

enum Choice: Int, Identifiable {
    var id: Int {
        rawValue
    }
    case success, failure
}

struct ContentView: View {
    @State public var symbols = ["eating", "happy", "love"]
    @State public var numbers = [0, 0, 0]
//    @State public var numbers = [0, 0, 0, 0, 0]
    @State public var counter = 0
    @State private var showingAlert: Choice?
    
    var body: some View {
        ZStack {
            Image("sunshine")
                .resizable()
                .ignoresSafeArea(.all)
            VStack(alignment: .center, spacing: 80) {
                HStack {
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                    Text("Slot Machine")
                        .font(.system(.title))
                        .fontWeight(.black)
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                }
                .frame(height: 50)
                .shadow(color: .orange, radius: 1, y: 3)
                VStack(spacing: 15) {
                    HStack(spacing: 35) {
                        hexagonalWithImage(symbols[numbers[0]])
                        hexagonalWithImage(symbols[numbers[1]])
                    }
                    hexagonalWithImage(symbols[numbers[2]])
//                    HStack(spacing: 35) {
//                        hexagonalWithImage(symbols[numbers[3]])
//                        hexagonalWithImage(symbols[numbers[4]])
//                    }
                }
                Text("Kalan hak: \(6 - counter)")
                    .font(.largeTitle)
                Button {
                    for i in 0...self.numbers.count - 1 {
                        self.numbers[i] = Int.random(in: 0...self.symbols.count - 1)
                    }
                    counter += 1
                    
                    if self.numbers.allSatisfy({ $0 == self.numbers[0] }) {
                        self.showingAlert = .success
                        counter = 0
                    } else if counter > 5 {
                        self.showingAlert = .failure
                        counter = 0
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("color"))
                        .overlay {
                            Text("Spin")
                                .fontWeight(.black)
                                .font(.title3)
                        }
                        .foregroundColor(.black)
                        .frame(width: 200, height: 40, alignment: .center)
                        .shadow(color: .gray, radius: 1, y: 4)
                }
            }
            .alert(item: $showingAlert) {alert -> Alert in
                switch alert {
                case .success:
                    return Alert(title: Text("Yahh!"), message: Text("You won!"), dismissButton: .cancel())
                case .failure:
                    return Alert(title: Text("Opppss!"), message: Text("Better luck next time :("), dismissButton: .cancel())
                }
            }
        }
    }
}

func hexagonalWithImage(_ name: String) -> some View {
    Hexagonal()
        .fill(Color.white.opacity(0.8))
        .frame(width: 100, height: 120)
        .overlay {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 70, alignment: .center)
                .shadow(color: .gray, radius: 4, x: 4, y: 5)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
