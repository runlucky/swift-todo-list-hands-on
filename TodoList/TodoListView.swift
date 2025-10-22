//
//  TodoListView.swift
//  TodoList
//
//  Created by kakeru on 2025/10/21.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Item.order) private var items: [Item]
    @State private var newItem: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) {
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
    }
    
    private func addItem() {
        let order = (items.map(\.order).max() ?? 0) + 1
        context.insert(Item(text: newItem, isCompleted: false, order: order))
        newItem = ""
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        indexSet.forEach {
            context.delete(items[$0])
        }
    }

    func moveItems(from: IndexSet, to: Int) {
        var reordered = items
        reordered.move(fromOffsets: from, toOffset: to)
        
        reordered.enumerated().forEach { index, item in
            item.order = index
        }
    }
}


#Preview {
    TodoListView()
}
