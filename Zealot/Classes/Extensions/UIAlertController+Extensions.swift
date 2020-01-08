//
//  UIAlertController+Extensions.swift
//  Zealot
//
//  Created by icyleaf on 2020/1/8.
//

import UIKit

extension UIAlertController {
    public func show(animated: Bool = true, style: UIBlurEffectStyle? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let rootVC = UIApplication.shared.keyWindow?.rootViewController
            rootVC?.present(self, animated: animated, completion: completion)
        }
    }

    public func addTextView(text: String) {
        let textViewer = TextViewController(text: text)
        set(vc: textViewer)
    }
    
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    func setMaxHeight(_ height: CGFloat) {
        let height = NSLayoutConstraint(item: view,
                                        attribute: .height,
                                        relatedBy: .lessThanOrEqual,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: height)
        view.addConstraint(height)
    }
}

final class TextViewController: UIViewController {
    fileprivate lazy var textView: UITextView = {
        $0.isEditable = false
        $0.isSelectable = true
        $0.backgroundColor = nil
        $0.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UITextView())
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        
        textView.text = text
        textView.textContainerInset = UIEdgeInsetsMake(0, 16, 16, 16)
        textView.flashScrollIndicators()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = textView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            preferredContentSize.width = UIScreen.main.bounds.width * 0.618
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.scrollRangeToVisible(NSMakeRange(0, 1))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize.height = textView.contentSize.height
    }
}
