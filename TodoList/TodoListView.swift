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
        NavigationStack {
            List {
                ForEach($items) {
                    ItemView(item: $0)
                }
                .onMove { from, to in
                    moveItems(from: from, to: to)
                }
                .onDelete {
                    deleteItems($0)
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
        .task {
            loadItems()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .background {
                saveItems()
            }
        }
    }
    
    private func addItem() {
        items.append(Item(text: newItem, isCompleted: false))
        newItem = ""
    }
    
    private func saveItems() {
        if let data = try? JSONEncoder().encode(items) {
            itemsData = data
        }
    }
    
    private func loadItems() {
        let decoded = try? JSONDecoder().decode([Item].self, from: itemsData)
        items = decoded ?? []
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    func moveItems(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }

}


#Preview {
    TodoListView()
}
