//
//  Bookmark.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    let sourceText: String
    let translatedText: String
}
