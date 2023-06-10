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
    
    func configure() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
    }
}
