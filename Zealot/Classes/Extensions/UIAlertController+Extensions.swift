//
//  UIAlertController+Extensions.swift
//  Zealot
//
//  Created by icyleaf on 2020/1/8.
//

import UIKit

extension UIAlertController {
    @objc public func addTextView(text: String) {
        var changelog = text
        if text.isEmpty {
            changelog = Bundle.localizedString(forKey: "Changelog is empty")
        }

        let textViewer = TextViewController(text: changelog)
        set(vc: textViewer)
    }
    
    @objc func setMaxHeight(_ height: CGFloat) {
        guard let view = view else { return }
        
        let height = NSLayoutConstraint(item: view,
                                        attribute: .height,
                                        relatedBy: .lessThanOrEqual,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: height)
        view.addConstraint(height)
    }
    
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
}

@objcMembers
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
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
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

class WindowHandler: NSObject {
    static let shared = WindowHandler()
    var window: UIWindow?
    var mainWindow: UIWindow!

    @objc func present(viewController: UIViewController) {
        if self.window != nil {
            return
        }

        mainWindow = UIApplication.shared.windows[0]

        let aWindow = UIWindow(frame: UIScreen.main.bounds)
        aWindow.backgroundColor = UIColor.clear
        aWindow.rootViewController = UIViewController()
        self.window = aWindow

        window?.windowLevel = UIWindow.Level.alert
        window?.makeKeyAndVisible()
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }

    @objc func dismiss() {
        window?.isHidden = true
        window?.removeFromSuperview()
        window = nil
        mainWindow.makeKeyAndVisible()
        mainWindow = nil
    }
}
