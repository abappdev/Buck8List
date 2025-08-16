//
//  Buck8ListApp.swift
//  Buck8List
//
//  Created by Abhishek Bhalerao on 16/08/25.
//

import SwiftData
import SwiftUI

@main
struct Buck8ListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
