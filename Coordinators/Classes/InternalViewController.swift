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

open class InternalViewController: CViewController {
    public weak var delegate: InternalViewControllerDelegate?

    open var navigationBarTintColor: UIColor {
        return UINavigationBar.appearance().barTintColor ?? .white
    }

    open var isNavigationBarTransluscent: Bool {
        return false
    }

    open var navigationBarTextTintColor: UIColor {
        return UINavigationBar.appearance().tintColor ?? .white
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
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        } else {
            navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage ?? UIImage()
            navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
        }
    }

    override open func didMove(toParent parent: UIViewController?) {
        if parent == nil {
            delegate?.viewControllerDidDismiss()
        }
    }
}


