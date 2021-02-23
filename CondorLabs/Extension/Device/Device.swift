//
//  Device.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import Foundation

import UIKit

public extension UIDevice {
    var hasNotch: Bool {
        let initialWindow = 0
        let bottom = UIApplication.shared.windows[initialWindow].safeAreaInsets.bottom
        
        return bottom > 0
    }
    
    var notchSize: CGFloat {
        if UIApplication.shared.windows.count == .zero {
            return .zero
        }
        let initialWindow = 0
        let bottom = UIApplication.shared.windows[initialWindow].safeAreaInsets.bottom
        return bottom
    }
}
