//
//  CNavigationController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 30/09/2019.
//

import UIKit

open class CNavigationController: UINavigationController, CViewControllerProtocol {
    
    weak public var cViewControllerDelegate: CViewControllerDelegate?
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        setPresentationControllerDelegate(viewControllerToPresent: viewControllerToPresent)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}

extension CNavigationController: UIAdaptivePresentationControllerDelegate {
    
    open func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? CViewControllerProtocol)?.cViewControllerDelegate?.cViewControllerWillDismiss(presentationController.presentedViewController)
    }
    
    open func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? CViewControllerProtocol)?.cViewControllerDelegate?.cViewControllerDidDismiss(presentationController.presentedViewController)
    }
    
}
