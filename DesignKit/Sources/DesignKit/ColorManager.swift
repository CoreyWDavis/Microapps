//
//  File.swift
//  
//
//  Created by Corey Davis on 7/22/23.
//

import UIKit
import SwiftUI

public enum ColorManager: String {
    case darkBlue = "DarkBlue"
}

// SwiftUI Colors

extension ColorManager {
    public var color: Color {
        // This should be return Color(rawValue) but stupid SPM does not
        // support color sets in xcassets yet. Or maybe xcassets at all?
        // Its all a bit confusing.
        // https://www.wwdcnotes.com/notes/wwdc20/10169/
        // https://forums.swift.org/t/does-spm-support-colors-in-asset-catalogs/54941/10
        return Color(red: 0, green: 0.160, blue: 0.344)
    }
}
