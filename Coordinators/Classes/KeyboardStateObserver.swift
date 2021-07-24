//
//  KeyboardStateObserver.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

public protocol KeyboardStateObserverDelegate: AnyObject {
    func keyboardWillShow(endframe: CGRect?)
    func keyboardDidShow(endframe: CGRect?)
    func keyboardWillHide(endframe: CGRect?)
    func keyboardDidHide(endframe: CGRect?)
}

open class KeyboardStateObserver: NSObject {
    
    public weak var delegate: KeyboardStateObserverDelegate?
    
    // MARK: Add / Remove

    public func startObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    public func stopObserving() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    // MARK: Show

    @objc public func keyboardWillShow(notification: Notification) {
        let keyboardSize = keyboardSizeFrom(userInfo: notification.userInfo)
        delegate?.keyBoardWillShow(endframe: keyboardSize)
    }

    @objc public func keyboardDidShow(notification: Notification) {
        let keyboardSize = keyboardSizeFrom(userInfo: notification.userInfo)
        delegate?.keyboardDidShow(endframe: keyboardSize)
    }

    // MARK: Hide

    @objc public func keyboardWillHide(notification: Notification) {
        let keyboardSize = keyboardSizeFrom(userInfo: notification.userInfo)
        delegate?.keyboardWillHide(endframe: keyboardSize)
    }

    @objc public func keyboardDidHide(notification: Notification) {
        let keyboardSize = keyboardSizeFrom(userInfo: notification.userInfo)
        delegate?.keyboardDidHide(endframe: keyboardSize)
    }
    
    private func keyboardSizeFrom(userInfo: [AnyHashable : Any]?) -> CGRect? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
}
