//
//  TodoListApp.swift
//  TodoList
//
//  Created by kakeru on 2025/10/05.
//

import SwiftUI
import SwiftData

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView()
        }
        .modelContainer(for: Item.self)
    }
}
