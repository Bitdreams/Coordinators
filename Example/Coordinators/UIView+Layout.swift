//
//  UIView+Layout.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

public extension UIView {
    
    enum LayoutMarginType {
        case none
        case layoutMargins
        case safeArea
    }
    
    func fillSuperview(margingType: LayoutMarginType = .none) {
        guard let superview = superview else {
            preconditionFailure("Superview cannor be nil")
        }
        
        let _topAnchor: NSLayoutYAxisAnchor
        let _bottomAnchor: NSLayoutYAxisAnchor
        let _leftAnchor: NSLayoutXAxisAnchor
        let _rightAnchor: NSLayoutXAxisAnchor
        
        switch margingType {
        case .none:
            _topAnchor = superview.topAnchor
            _bottomAnchor = superview.bottomAnchor
            _leftAnchor = superview.leftAnchor
            _rightAnchor = superview.rightAnchor
        case .layoutMargins:
            _topAnchor = superview.layoutMarginsGuide.topAnchor
            _bottomAnchor = superview.layoutMarginsGuide.bottomAnchor
            _leftAnchor = superview.layoutMarginsGuide.leftAnchor
            _rightAnchor = superview.layoutMarginsGuide.rightAnchor
        case .safeArea:
            _topAnchor = superview.safeAreaLayoutGuide.topAnchor
            _bottomAnchor = superview.safeAreaLayoutGuide.bottomAnchor
            _leftAnchor = superview.safeAreaLayoutGuide.leftAnchor
            _rightAnchor = superview.safeAreaLayoutGuide.rightAnchor
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: _topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: _bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: _leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: _rightAnchor).isActive = true
    }
    
}
