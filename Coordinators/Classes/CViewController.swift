//
//  CViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 30/09/2019.
//

import UIKit

public protocol CViewControllerDelegate: AnyObject {
    func cViewControllerWillDismiss(_ viewController: UIViewController)
    func cViewControllerDidDismiss(_ viewController: UIViewController)
}

public protocol CViewControllerProtocol: AnyObject {
    var cViewControllerDelegate: CViewControllerDelegate? { get set }
    func setPresentationControllerDelegate(viewControllerToPresent: UIViewController)
}

extension CViewControllerProtocol where Self : UIAdaptivePresentationControllerDelegate {
    
    public func setPresentationControllerDelegate(viewControllerToPresent: UIViewController) {
        if viewControllerToPresent is CViewControllerProtocol {
            viewControllerToPresent.presentationController?.delegate = self
        }
    }
    
}

open class CViewController: UIViewController, CViewControllerProtocol, ViewAware, KeyboardStateObserverDelegate {

    weak public var cViewControllerDelegate: CViewControllerDelegate?
    
    public let keyboardStateObserver = KeyboardStateObserver()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        setPresentationControllerDelegate(viewControllerToPresent: viewControllerToPresent)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        keyboardStateObserver.delegate = self
        setup()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        c_viewWillAppear(animated)
        
        keyboardStateObserver.startObserving()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        keyboardStateObserver.stopObserving()
    }

    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        c_didMove(toParent: parent)
    }
    
    // MARK: ViewAware
    open func setup() {
        setupStyle()
        setupStrings()
        setupLayout()
    }
    
    open func setupStyle() {
        view.backgroundColor = .white
    }
    
    open func setupStrings() {
        // To be overriden
    }
    
    open func setupLayout() {
        // To be overriden
    }
    
    // MARK: Keyboard
    
    open func keyboardWillShow(endframe: CGRect?) {
        // Not implemented here
    }
    
    open func keyboardDidShow(endframe: CGRect?) {
        // Not implemented here
    }
    
    open func keyboardWillHide(endframe: CGRect?) {
        // Not implemented here
    }
    
    open func keyboardDidHide(endframe: CGRect?) {
        // Not implemented here
    }
    
    // MARK Internal
    
    func c_viewWillAppear(_ animated: Bool) {}
    func c_didMove(toParent parent: UIViewController?) {}
    
}

extension CViewController: UIAdaptivePresentationControllerDelegate {
    
    open func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? CViewControllerProtocol)?.cViewControllerDelegate?.cViewControllerWillDismiss(presentationController.presentedViewController)
    }
    
    open func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? CViewControllerProtocol)?.cViewControllerDelegate?.cViewControllerDidDismiss(presentationController.presentedViewController)
    }
    
}
