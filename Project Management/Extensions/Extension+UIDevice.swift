//
//  Extension+UIDevice.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import Foundation
import SwiftUI

public extension UIDevice {
    
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
