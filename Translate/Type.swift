//
//  Type.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit

enum buttonType {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}
