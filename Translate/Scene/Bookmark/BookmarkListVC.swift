//
//  BookmarkListVC.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit
import SnapKit

final class BookmarkListVC: UIViewController {
    private var bookmarks: [Bookmark] = []
    
    private lazy var collectionView: UICollectionView = {
        let inset: CGFloat = 16
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 100)
        layout.sectionInset = .init(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookmarkCell.self, forCellWithReuseIdentifier: BookmarkCell.identifier)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Bookmark", comment: "즐겨찾기")
        navigationController?.navigationBar.prefersLargeTitles = true
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookmarks = UserDefaults.standard.bookmarks
        collectionView.reloadData()
    }
}

extension BookmarkListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookmarkCell.identifier,
            for: indexPath
        ) as? BookmarkCell else { return UICollectionViewCell() }
        let bookmark = bookmarks[indexPath.item]
        cell.configure(from: bookmark)
        return cell
    }
}

private extension BookmarkListVC {
    func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

