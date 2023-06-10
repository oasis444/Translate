//
//  BookmarkTextStack.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit
import SnapKit

final class BookmarkTextStack: UIStackView {
    private let type: buttonType
    private let language: Language
    private let text: String
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = type.color
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = type.color
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    init(language: Language, text: String, type: buttonType) {
        self.language = language
        self.text = text
        self.type = type
        
//        super.init()
        super.init(frame: .zero)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        distribution = .equalSpacing
        spacing = 4
        [languageLabel, textLabel].forEach {
            self.addArrangedSubview($0)
        }
    }
}
