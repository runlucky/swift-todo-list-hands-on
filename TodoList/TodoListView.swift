//
//  TodoListView.swift
//  TodoList
//
//  Created by kakeru on 2025/10/21.
//

import SwiftUI

struct TodoListView: View {
    @State private var items: [String] = []
    @State private var newItem: String = ""
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
            
            TextField("新しい項目を追加", text: $newItem)
                .textFieldStyle(.roundedBorder)
            
                .onSubmit {
                    items.append(newItem)
                    
                }
        }
    }
}


#Preview {
    TodoListView()
}
