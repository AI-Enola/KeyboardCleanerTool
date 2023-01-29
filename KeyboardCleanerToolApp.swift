//
//  KeyboardCleanerToolApp.swift
//  KeyboardCleanerTool
//
//  Created by Luidgi Alouette on 2023-01-28.
//

import SwiftUI

@main
struct KeyboardCleanerToolApp: App {
    var mode: Mode
    var tap: Tap
    
    init() {
        self.mode = Mode.init(isLocked: false, Text: Mode.textLocked,imgLockState: Mode.imgUnlocked)
        self.tap = Tap(mode:self.mode) // Init CGEventTap
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(mode:self.mode, tap:self.tap)
                .fixedSize()
                .frame(width: 400, height: 200)
        }
        .windowResizability(.contentSize)
        
    }
}

