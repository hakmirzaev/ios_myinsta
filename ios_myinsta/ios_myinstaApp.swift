//
//  ios_myinstaApp.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 08/02/23.
//

import SwiftUI

@main
struct ios_myinstaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            StarterScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(SessionStore())
        }
    }
}
