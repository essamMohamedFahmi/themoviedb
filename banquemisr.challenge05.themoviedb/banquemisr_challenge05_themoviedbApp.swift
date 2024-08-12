//
//  banquemisr_challenge05_themoviedbApp.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by Essam Fahmy on 12/08/2024.
//

import SwiftUI
import SwiftData

@main
struct banquemisr_challenge05_themoviedbApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
