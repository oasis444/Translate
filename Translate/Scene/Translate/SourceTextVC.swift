//
//  SourceTextVC.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit
import SnapKit
import Combine

protocol SourceTextVCDelegate: AnyObject {
    func didEnterText(_ sourceText: String)
}

final class SourceTextVC: UIViewController {
    var subject: CurrentValueSubject<String?, Never>?
    private let placeholderText = "텍스트 입력"
    var textData: ((String?) -> Void)?
    weak var delegate: SourceTextVCDelegate?
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = placeholderText
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    deinit {
        print("deinit")
    }
}

private extension SourceTextVC {
    func setupViews() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

extension SourceTextVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
//        subject?.send(textView.text)            // 1. Combine을 사용하는 방법
        
//        textData?(textView.text)                // 2. Closure을 사용하는 방법
        
        delegate?.didEnterText(textView.text)   // 3. delegate를 사용하는 방법
        
        dismiss(animated: true)
        return true
    }
}
