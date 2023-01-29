// Very very simple UI program to activate or desactivate the keyboard inputs
// That help for cleaning keyboard and avoid keyboard inputs in any way.
// NOTE : Check permission in Privacy settings and tuchbar not supported for now

//  ContentView.swift
//  KeyboardCleanerTool
//
//  Created by Luidgi Alouette on 2023-01-28.
//

import SwiftUI
import Foundation


struct ContentView: View {
    @State private var mode: Mode
    @State private var tap: Tap
    
    init(mode: Mode, tap: Tap) {
        self.mode = mode
        self.tap = tap
    }
    
    var body: some View {
        
        VStack {
            HStack {
                self.mode.imgLockState
                    .font(.system(size: 24))
            }
            .padding()
            
            HStack {
                VStack {
                    Text("Keyboard Cleaner Tool")
                    Button(self.mode.Text,action: {
                        tapHandler()
                    }) 
                }
            }
        }
        .padding()
        
    }
    
     func tapHandler() {
        self.mode.isLocked.toggle()

        if(self.mode.isLocked) {
            self.mode.Text = Mode.textUnlocked
            self.mode.imgLockState = Mode.imgLocked
            self.tap.enableTap() // Block keyboard input

        } else {
            self.mode.Text = Mode.textLocked
            self.mode.imgLockState = Mode.imgUnlocked
            self.tap.disableTap() // Pass keyboard input for action
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mode = Mode.init(isLocked: false, Text: Mode.textLocked,imgLockState: Mode.imgUnlocked)
        let tap = Tap(mode:mode) // Init CGEventTap
        ContentView(mode: mode, tap: tap)
    }

}
