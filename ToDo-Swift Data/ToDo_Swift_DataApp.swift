//
//  ToDo_Swift_DataApp.swift
//  ToDo-Swift Data
//
//  Created by Shariful Islam on 12/2/25.
//

import SwiftUI
import SwiftData

@main
struct ToDo_Swift_DataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskItemModel.self)
    }
}
