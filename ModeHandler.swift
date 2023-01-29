//
//  ModeHandler.swift
//  KeyboardCleanerTool
//
//  Created by Luidgi Alouette on 2023-01-29.
//

import Foundation
import SwiftUI


struct Mode {
    var isLocked: Bool // State of button
    var Text: String // Actual button text
    var imgLockState: Image
    
    
    static let textLocked:  String = "Click to lock keyboard" // Text when keyboard locked
    static let textUnlocked: String = "Click to unlock keyboard" // Text when keyboard not locked
    
    
    static let imgUnlocked = Image(systemName: "lock.open.fill")
    static let imgLocked =  Image(systemName: "lock.fill")
    
    var eventTap: CFMachPort!
}
