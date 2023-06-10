//
//  TranslateVC.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit
import SnapKit
import Combine

final class TranslateVC: UIViewController {
    private let subject = CurrentValueSubject<String?, Never>(nil)
    private var cancelables = Set<AnyCancellable>()
    private var sourceLanguage: Language = .ko
    private var targetLanguage: Language = .en
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        [sourceLanguageButton, targetLanguageButton].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = UIColor.mainTintColor
        label.text = "Hello Swift"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSourceLabelBaseButton))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트 입력"
        label.textColor = .tertiaryLabel // TODO: 입력값 추가되면 색상 변경
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .mainTintColor
        setupViews()
//        bind()
    }
}

private extension TranslateVC {
    func setupViews() {
        let defaultSpacing: CGFloat = 16
        
        view.backgroundColor = .secondarySystemBackground
        
        [
            buttonStackView,
            resultBaseView,
            resultLabel,
            bookmarkButton,
            copyButton,
            sourceLabelBaseButton,
            sourceLabel
        ].forEach {
            view.addSubview($0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing) // 텍스트 길이에 따라 변하는 높이를 위해 맞춤
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultBaseView.snp.top).inset(24)
            $0.leading.equalTo(resultBaseView.snp.leading).inset(24)
            $0.trailing.equalTo(resultBaseView.snp.trailing).inset(24)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLabel.snp.leading)
            $0.top.equalTo(resultLabel.snp.bottom).offset(24)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        copyButton.snp.makeConstraints {
            $0.leading.equalTo(bookmarkButton.snp.trailing).inset(8.0)
            $0.top.equalTo(bookmarkButton.snp.top)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        sourceLabelBaseButton.snp.makeConstraints {
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.leading.equalTo(sourceLabelBaseButton.snp.leading).inset(24)
            $0.trailing.equalTo(sourceLabelBaseButton.snp.trailing).inset(24)
            $0.top.equalTo(sourceLabelBaseButton.snp.top).inset(24)
        }
    }
    
    // Combine을 사용하는 경우
    func bind() {
        subject.receive(on: DispatchQueue.main)
            .sink { text in
                guard let text = text else { return }
                guard !text.isEmpty else { return }
                self.sourceLabel.textColor = .label
                self.sourceLabel.text = text
            }.store(in: &cancelables)
    }
}

private extension TranslateVC {
    @objc func didTapSourceLabelBaseButton() {
        let vc = SourceTextVC()
//        vc.subject = self.subject                   // 1. Combine을 사용하는 방법
        
//        vc.textData = { [weak self] text in         // 2. Closures을 사용하는 방법
//            guard let self = self else { return }
//            guard !(text?.isEmpty ?? true) else { return }
//            sourceLabel.textColor = .label
//            sourceLabel.text = text
//        }
        
        vc.delegate = self      // 3. delegate를 사용하는 방법
        present(vc , animated: true)
    }
    
    @objc func didTapSourceLanguageButton() {
        didLanguageButton(type: .source)
    }
    
    @objc func didTapTargetLanguageButton() {
        didLanguageButton(type: .target)
    }
    
    func didLanguageButton(type: buttonType) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        Language.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default) { _ in
                switch type {
                case .source:
                    self.sourceLanguage = language
                    self.sourceLanguageButton.setTitle(language.title, for: .normal)
                case .target:
                    self.targetLanguage = language
                    self.targetLanguageButton.setTitle(language.title, for: .normal)
                }
            }
            alertController.addAction(action)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @objc func didTapBookmarkButton() {
        guard let sourceText = sourceLabel.text,
              let translatedText = resultLabel.text,
              bookmarkButton.imageView?.image == UIImage(systemName: "bookmark") else { return }
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        let currentBookmarks = UserDefaults.standard.bookmarks
        let newBookmark = Bookmark(
            sourceLanguage: sourceLanguage,
            translatedLanguage: targetLanguage,
            sourceText: sourceText,
            translatedText: translatedText
        )
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
        print("Bookmark: \(UserDefaults.standard.bookmarks)")
    }
    
    @objc func didTapCopyButton() {
        UIPasteboard.general.string = resultLabel.text  // 클립보드 복사
    }
}

extension TranslateVC: SourceTextVCDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        sourceLabel.textColor = .label
        sourceLabel.text = sourceText
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
}
