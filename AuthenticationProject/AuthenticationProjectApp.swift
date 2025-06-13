//
//  AuthenticationProjectApp.swift
//  AuthenticationProject
//
//  Created by Maahin Beri on 6/13/25.
//

import SwiftUI

@main
struct AuthenticationProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
