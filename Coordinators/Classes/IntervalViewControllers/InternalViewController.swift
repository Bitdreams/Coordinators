//
//  InternalViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/11/2017.
//  Copyright © 2017 Bitdreams. All rights reserved.
//

import UIKit

/// This protocol is responsible for propagating the view controller dismissal back to the delagate
public protocol InternalViewControllerDelegate: AnyObject {
    func viewControllerDidDismiss()
}

/// This view controller automatically notifies its InternalCoordinator of any navigation change
open class InternalViewController: CViewController {
    public weak var delegate: InternalViewControllerDelegate?
    
    // Determines if this view controller will automatically manage the navigation bar style
    open var shouldManageNavigationBarStyle: Bool {
        return false
    }
    
    /// Controls whether the navigation bar is hidden
    open var isNavigationBarHidden: Bool {
        return false
    }

    /// The tint colour to be applied to the navihation bar when this controller is pushed into the stack
    open var navigationBarTintColor: UIColor {
        return UINavigationBar.appearance().barTintColor ?? .white
    }

    /// Determined wheter the navigation bar is translucent
    open var isNavigationBarTransluscent: Bool {
        return false
    }

    /// The text tint colour to be applied to the navihation bar when this controller is pushed into the stack
    open var navigationBarTextTintColor: UIColor {
        return UINavigationBar.appearance().tintColor ?? .white
    }

    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init()
        view.backgroundColor = .white
    }
    
    public override init() {
        super.init()
        view.backgroundColor = .white
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func c_viewWillAppear(_ animated: Bool) {
        if shouldManageNavigationBarStyle {
            navigationController?.isNavigationBarHidden = isNavigationBarHidden
            navigationController?.navigationBar.barTintColor = navigationBarTintColor
            navigationController?.navigationBar.tintColor = navigationBarTextTintColor
            navigationController?.navigationBar.isTranslucent = isNavigationBarTransluscent
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: navigationBarTextTintColor]
            if #available(iOS 11.0, *) {
                navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: navigationBarTextTintColor]
            }

            if isNavigationBarTransluscent {
                navigationController?.navigationBar.shadowImage = UIImage()
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            } else {
                navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage ?? UIImage()
                navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
            }
        }
    }
    
    override func c_didMove(toParent parent: UIViewController?) {
        if parent == nil {
            delegate?.viewControllerDidDismiss()
        }
    }

}


