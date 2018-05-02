//
//  InternalViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/11/2017.
//  Copyright © 2017 Bitdreams. All rights reserved.
//

import UIKit

public protocol InternalViewControllerDelegate: class {
    func viewControllerDidDismiss()
}

open class InternalViewController: UIViewController {
    public weak var delegate: InternalViewControllerDelegate?

    private let dummy = UINavigationController()

    open var navigationBarTintColor: UIColor {
        return dummy.navigationBar.barTintColor ?? .white
    }

    open var isNavigationBarTransluscent: Bool {
        return false
    }

    open var navigationBarTextTintColor: UIColor {
        return dummy.navigationBar.tintColor ?? .black
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = navigationBarTintColor
        navigationController?.navigationBar.tintColor = navigationBarTextTintColor
        navigationController?.navigationBar.isTranslucent = isNavigationBarTransluscent
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: navigationBarTextTintColor]
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: navigationBarTextTintColor]
        }

        if isNavigationBarTransluscent {
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        } else {
            navigationController?.navigationBar.backgroundColor = dummy.navigationBar.backgroundColor
            navigationController?.navigationBar.shadowImage = dummy.navigationBar.shadowImage
            navigationController?.navigationBar.setBackgroundImage(dummy.navigationBar.backgroundImage(for: .default), for: .default)
        }
    }

    override open func didMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            delegate?.viewControllerDidDismiss()
        }
    }
}


