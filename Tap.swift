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
    init() {
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
        mode.eventTap = CGEvent.tapCreate(tap: CGEventTapLocation.cgSessionEventTap,
                                     place: CGEventTapPlacement.headInsertEventTap,
                                     options: CGEventTapOptions.defaultTap,
                                     eventsOfInterest: eventMask,
                                     callback: {(eventTapProxy, eventType, event, mutablePointer) -> Unmanaged<CGEvent>? in event
            //print(event.type.rawValue)
            return nil
        }, userInfo: nil)
        // Value can be nil when privacy settings reject tap creation
        if mode.eventTap == nil {
            print("Failed to create event tap ! See Privacy settings !")
            exit(1)
        }

        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, mode.eventTap, 0)

        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        CFRunLoopRun()
    }
    
    func enableTap() {
        CGEvent.tapEnable(tap: mode.eventTap, enable: true)
    }
    
    func disableTap() {
        CGEvent.tapEnable(tap: mode.eventTap, enable: false)
    }
    
}
