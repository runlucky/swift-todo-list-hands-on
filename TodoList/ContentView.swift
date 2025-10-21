//
//  ContentView.swift
//  TodoList
//
//  Created by kakeru on 2025/10/05.
//

import SwiftUI

struct ContentView: View {
    @State private var text = "Swift"
    @AppStorage("count") private var count = 0
    
    var body: some View {
        List {
            Section {
                Text("Hello, \(text)!")
                
                TextField("input me", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
            }
            
            Section {
                logSection
            }
            
            Section {
                counterSection()
            }
        }
    }
    
    private var logSection: some View {
        Button("ログ出力") {
            print("pushed: \(text)")
        }
    }
    
    @ViewBuilder
    private func counterSection() -> some View {
        CounterView(count: $count)
        Text("カウント: \(count)")
        
        if (count != 0) {
            Button("リセット") {
                withAnimation {
                    count = 0
                }
            }
        }
    }
}

struct CounterView: View {
    @Binding var count: Int
    
    var body: some View {
        Stepper("カウンター", value: $count, in: 0...10)
    }
}

#Preview {
    ContentView()
}
