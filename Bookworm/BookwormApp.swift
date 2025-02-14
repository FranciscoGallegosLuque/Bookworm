//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Francisco Manuel Gallegos Luque on 11/02/2025.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(for: Student.)
        .modelContainer(for: Book.self)
    }
}
