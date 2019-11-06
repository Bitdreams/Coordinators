//
//  CViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 30/09/2019.
//

import UIKit

public protocol CViewControllerDelegate: class {
    func cViewControllerWillDismiss(_ viewController: UIViewController)
    func cViewControllerDidDismiss(_ viewController: UIViewController)
}

public protocol CViewControllerProtocol: class {
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

open class CViewController: UIViewController, CViewControllerProtocol {
    
    weak public var cViewControllerDelegate: CViewControllerDelegate?
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        setPresentationControllerDelegate(viewControllerToPresent: viewControllerToPresent)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}

extension CViewController: UIAdaptivePresentationControllerDelegate {
    
    public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? CViewControllerProtocol)?.cViewControllerDelegate?.cViewControllerWillDismiss(presentationController.presentedViewController)
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? CViewControllerProtocol)?.cViewControllerDelegate?.cViewControllerDidDismiss(presentationController.presentedViewController)
    }
    
}
