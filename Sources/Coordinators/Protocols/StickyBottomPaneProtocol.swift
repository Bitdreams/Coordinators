//
//  StickyBottomPaneProtocol.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

public protocol StickyBottomPaneProtocol: AnyObject {
    
    var bottomPaneView: UIView { get }
    
    func setupBottomPane()
    func setupBottomPaneInsets()
    
}

extension StickyBottomPaneProtocol where Self: UIViewController {
    
    public func setupBottomPane() {
        view.addSubview(bottomPaneView)
        bottomPaneView.translatesAutoresizingMaskIntoConstraints = false
        bottomPaneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomPaneView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomPaneView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    public func setupBottomPaneInsets() {
        // Not implemented here
    }
    
}
