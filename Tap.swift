// Listen for keyboard event and eat inputs or allow input within Tap enabled or not
// NOTE : Check permission in Privacy settings
//  Tap.swift
//  KeyboardCleanerTool
//
//  Created by Luidgi Alouette on 2023-01-29.

// Source event.h for NX_xxxx : https://opensource.apple.com/source/xnu/xnu-123.5/iokit/IOKit/hidsystem/IOLLEvent.h

import Foundation
import SwiftUI


class Tap {
    var mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
        let NX_KITDEFINED: Int = 13    /* application-kit-defined event */
        let NX_SYSDEFINED: Int = 14    /* system-defined event */
        let NX_APPDEFINED: Int = 15    /* application-defined event */
        
        // Add event to listen
        let eventMask: CGEventMask = (UInt64(1 << CGEventType.keyDown.rawValue) |
                                      UInt64(1 << CGEventType.flagsChanged.rawValue) |
                                      UInt64(1 << CGEventType.tapDisabledByUserInput.rawValue) |
                                      UInt64(1 << NX_KITDEFINED) |
                                      UInt64(1 << NX_SYSDEFINED) |
                                      UInt64(1 << NX_APPDEFINED));

        // Create the tap event for the loop
        self.mode.eventTap = CGEvent.tapCreate(tap: CGEventTapLocation.cgSessionEventTap,
                                     place: CGEventTapPlacement.headInsertEventTap,
                                     options: CGEventTapOptions.defaultTap,
                                     eventsOfInterest: eventMask,
                                     callback: {(eventTapProxy, eventType, event, mutablePointer) -> Unmanaged<CGEvent>? in event
            //print(event.type.rawValue)
            return nil
        }, userInfo: nil)
        // Value can be nil when privacy settings reject tap creation
        if self.mode.eventTap == nil {
            let answer = dialogOKCancel(question: "Failed to create event tap !",
                                        text: "You need to grant access to this application in Privacy & Security settings.")
            exit(1)
            
        } else {
            let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, self.mode.eventTap, 0)
            CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        }

        
    }
    
    func enableTap() {
        CGEvent.tapEnable(tap: self.mode.eventTap, enable: true)
    }
    
    func disableTap() {
        CGEvent.tapEnable(tap: self.mode.eventTap, enable: false)
    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.icon = NSImage (named: NSImage.cautionName)
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Quit")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
}
