//
//  Coordinator.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/11/2017.
//  Copyright © 2017 Bitdreams. All rights reserved.
//

import Foundation

import RxSwift

open class Coordinator: NSObject {
    
    public let disposeBag = DisposeBag()
    public let navigationController: UINavigationController
    open var childCoordinators = [Coordinator]()
    
    open var rootCoordinator: Coordinator {
        var coordinator: Coordinator = self
        
        while let parent = coordinator.parent {
            coordinator = parent
        }
        
        return coordinator
    }
    
    open func start(with parent: Coordinator?) {
        self.parent = parent
        parent?.childCoordinators.append(self)
    }
    
    open var hasModalViewController: Bool { return false }
    open var parent: Coordinator?
    
    fileprivate var skipPoppingNavigation = false
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    open func finish(_ animated: Bool) {
        willFinish()
        
        childCoordinators.forEach { child in
            child.finish(animated)
        }
        
        if let parent = parent {
            let index = parent.childCoordinators.firstIndex { $0 === self }!
            parent.childCoordinators.remove(at: index)
            parent.childCoordinatorDidFinish(coordinator: self)
        }
        
        if !hasModalViewController {
            if !skipPoppingNavigation {
                navigationController.popViewController(animated: animated)
            }
            skipPoppingNavigation = false
        }
        else if let coordinator = self as? UICoordinator {
            coordinator.rootViewController.presentedViewController?.dismiss(animated: false, completion: nil)
            coordinator.rootViewController.dismiss(animated: animated, completion: nil)
        }
        
        self.parent = nil
    }
    
    open func childCoordinatorDidFinish(coordinator: Coordinator) { }
    open func willFinish() { }
    
    open func firstDescendant(where filter: (Coordinator) -> Bool) -> Coordinator? {
        if childCoordinators.count == 0 {
            return nil
        }
        if let result = childCoordinators.first(where: filter) {
            return result
        }
        return childCoordinators.map {
            return $0.firstDescendant(where: filter)
            }.first ?? nil
    }
    
}

open class UICoordinator: Coordinator {
    open var shouldAutomaticallyManageNavigation: Bool { return true }
    open var rootViewController = UIViewController()
    
    override open func start(with parent: Coordinator?) {
        super.start(with: parent)
        (rootViewController as? CNavigationController)?.cViewControllerDelegate = self
        (rootViewController as? CViewController)?.cViewControllerDelegate = self
        
        if shouldAutomaticallyManageNavigation {
            if hasModalViewController {
                let presentingViewController = navigationController.presentedViewController ?? navigationController
                presentingViewController.present(rootViewController, animated: true, completion: nil)
            } else {
                navigationController.pushViewController(rootViewController, animated: true)
            }
        }
    }
    
    open var shouldFinishOnModalDismissal: Bool {
        return true
    }
}

extension UICoordinator: CViewControllerDelegate {
    
    public func cViewControllerWillDismiss(_ viewController: UIViewController) {
        
    }
    
    public func cViewControllerDidDismiss(_ viewController: UIViewController) {
        if shouldFinishOnModalDismissal {
            finish(true)
        }
    }
    
}

open class InternalCoordinator: UICoordinator, InternalViewControllerDelegate {
    
    open func viewControllerDidDismiss() {
        skipPoppingNavigation = true
        finish(false)
    }
    
    override open func start(with parent: Coordinator?) {
        (rootViewController as? InternalViewController)?.delegate = self
        super.start(with: parent)
    }
    
}
