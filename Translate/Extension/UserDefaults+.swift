//
//  UserDefaults+.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case bookmarks
    }
    
    var bookmarks: [Bookmark] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.bookmarks.rawValue) else { return [] }
            return (try? PropertyListDecoder().decode([Bookmark].self, from: data)) ?? []
        }
        set {
            let value = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(value, forKey: Key.bookmarks.rawValue)
        }
    }
}
