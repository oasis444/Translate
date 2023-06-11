//
//  TranslateRequest.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation

struct TranslateRequest: Codable {
    let source: String
    let target: String
    let text: String
}
