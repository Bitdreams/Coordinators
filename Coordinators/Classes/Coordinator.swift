//
//  Coordinator.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/11/2017.
//  Copyright © 2017 Bitdreams. All rights reserved.
//

import Foundation
import RxSwift

public class Coordinator: NSObject {
    
    public let disposeBag = DisposeBag()
    public let navigationController: UINavigationController
    public var childCoordinators = [Coordinator]()
    
    public var rootCoordinator: Coordinator {
        var coordinator: Coordinator = self
        
        while let parent = coordinator.parent {
            coordinator = parent
        }
        
        return coordinator
    }
    
    public func start(with parent: Coordinator?) {
        self.parent = parent
        parent?.childCoordinators.append(self)
    }
    
    public var hasModalViewController: Bool { return false }
    public var parent: Coordinator?
    
    fileprivate var skipPoppingNavigation = false
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    public func finish(_ animated: Bool) {
        willFinish()
        
        childCoordinators.forEach { child in
            child.finish(animated)
        }
        
        if let parent = parent {
            let index = parent.childCoordinators.index { $0 === self }!
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
    
    public func childCoordinatorDidFinish(coordinator: Coordinator) { }
    public func willFinish() { }
    
}

public class UICoordinator: Coordinator {
    public var shouldAutomaticallyManageNavigation: Bool { return true }
    public var rootViewController = UIViewController()
    
    override public func start(with parent: Coordinator?) {
        super.start(with: parent)
        
        if shouldAutomaticallyManageNavigation {
            if hasModalViewController {
                let presentingViewController = navigationController.presentedViewController ?? navigationController
                presentingViewController.present(rootViewController, animated: true, completion: nil)
            } else {
                navigationController.pushViewController(rootViewController, animated: true)
            }
        }
    }
}

public class InternalCoordinator: UICoordinator, InternalViewControllerDelegate {
    
    public func viewControllerDidDismiss() {
        skipPoppingNavigation = true
        finish(false)
    }
    
    override public func start(with parent: Coordinator?) {
        (rootViewController as? InternalViewController)?.delegate = self
        super.start(with: parent)
    }
    
}
