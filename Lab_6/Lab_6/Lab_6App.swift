//
//  Lab_6App.swift
//  Lab_6
//
//  Created by Jarne Adam on 19/11/2025.
//

import SwiftUI

@main
struct Lab_6App: App {
    @State var dataStore = MovieDataStore()
    @State var pathStore = PathStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(dataStore).environment(pathStore)
        }
    }
}
