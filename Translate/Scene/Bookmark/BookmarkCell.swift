//
//  BookmarkCell.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit
import SnapKit

final class BookmarkCell: UICollectionViewCell {
    static let identifier: String = "BookmarkCell"
    private var sourceBookmarkTextStackView: BookmarkTextStackView!
    private var targetBookmarkTextStackView: BookmarkTextStackView!
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    func configure(from bookmark: Bookmark) {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        sourceBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.sourceLanguage,
            text: bookmark.sourceText,
            type: .source
        )
        
        targetBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.translatedLanguage,
            text: bookmark.translatedText,
            type: .target
        )
        
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        layoutIfNeeded()
    }
}
