//
//  TodoListView.swift
//  TodoList
//
//  Created by kakeru on 2025/10/21.
//

import SwiftUI

struct TodoListView: View {
    @AppStorage("items") var itemsData = Data()
    @State private var items: [Item] = []
    @State private var newItem: String = ""
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        List {
            ForEach($items) {
                ItemView(item: $0)
            }
            .onMove { from, to in
                items.move(fromOffsets: from, toOffset: to)
            }
            .onDelete {
                items.remove(atOffsets: $0)
            }
            
            
            HStack {
                TextField("新しい項目を追加", text: $newItem)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        addItem()
                    }
                
                Button("追加") {
                    addItem()
                }
                .disabled(newItem.isEmpty)
            }
        }
        .task {
            let decoded = try? JSONDecoder().decode([Item].self, from: itemsData)
            items = decoded ?? []
        }
        .onChange(of: scenePhase) {
            if scenePhase == .background,
               let data = try? JSONEncoder().encode(items) {
                itemsData = data
            }
        }
    }
    
    private func addItem() {
        items.append(Item(text: newItem, isCompleted: false))
        newItem = ""
    }
}


#Preview {
    TodoListView()
}
