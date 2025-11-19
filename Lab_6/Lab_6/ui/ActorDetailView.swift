//
//  ActorDetailView.swift
//  Lab_6
//
//  Created by Jarne Adam on 19/11/2025.
//

import SwiftUI

struct ActorDetailView: View {
    var actor : Actor? = nil
    @Environment(MovieDataStore.self) private var dataStore
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
