//
//  TranslatorManager.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation
import Alamofire

struct TranslatorManager {
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(
        from text: String,
        completion: @escaping (String) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        let requestModel = TranslateRequest(
            source: sourceLanguage.languageCode,
            target: targetLanguage.languageCode,
            text: text
        )
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": Data.id,
            "X-Naver-Client-Secret": Data.pw
        ]
        
        AF.request(url, method: .post, parameters: requestModel, headers: headers)
            .responseDecodable(of: TranslateResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result.translatedText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
