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
        viewControllerToPresent.presentationController?.delegate = self
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}

extension CNavigationController: UIAdaptivePresentationControllerDelegate {
    
    public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        cViewControllerDelegate?.cViewControllerWillDismiss(presentationController.presentedViewController)
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        cViewControllerDelegate?.cViewControllerDidDismiss(presentationController.presentedViewController)
    }
    
}
