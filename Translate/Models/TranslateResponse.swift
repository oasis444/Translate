//
//  TranslateResponse.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation

struct TranslateResponse: Decodable {
    private let message: Message
    
    var translatedText: String { message.result.translatedText }
    
    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String
    }
}
