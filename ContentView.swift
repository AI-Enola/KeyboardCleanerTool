// Very very simple UI program to activate or desactivate the keyboard inputs
// That help for cleaning keyboard and avoid keyboard inputs in any way.
// NOTE : Check permission in Privacy settings and tuchbar not supported for now

//  ContentView.swift
//  KeyboardCleanerTool
//
//  Created by Luidgi Alouette on 2023-01-28.
//

import SwiftUI


struct Mode {
    var isLocked: Bool // State of button
    var Text: String // Actual button text
    static let textLock:  String = "Click to stop cleaning mode" // Text when keyboard locked
    static let textNotLock: String = "Click to start cleaning mode" // Text when keyboard not locked
    var eventTap: CFMachPort! //
}

struct ContentView: View {
    
    @State private var _mode = mode
    
    var body: some View {
        VStack {
            Text("Keyboard cleaner tool")
            Button(_mode.Text,action: {
                tapHandler()
            })
        }
        .padding()
    }
    
    func tapHandler() {
        mode.isLocked.toggle()
        if(mode.isLocked) {
            _mode.Text = Mode.textLock
            tap.enableTap() // Block keyboard input

        } else {
            _mode.Text = Mode.textNotLock
            tap.disableTap() // Pass keyboard input for action
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var mode = Mode.init(isLocked: false, Text: Mode.textNotLock) //
var tap = Tap() // Init CGEventTap
