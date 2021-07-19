//
//  CommonLayout.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

public struct CommonDistances: LayoutDistances {
    public static let none: CGFloat = 0
    public static let small: CGFloat = 4
    public static let medium: CGFloat = 8
    public static let normal: CGFloat = 12
    public static let large: CGFloat = 16
    public static let xlarge: CGFloat = 32
    public static let xxlarge: CGFloat = 64
}

open class CommonLayout: Layout {
    
    public var insets: UIEdgeInsets = .zero
    
    public var margin: LayoutDistances.Type = CommonDistances.self
    
    public var spacing: LayoutDistances.Type = CommonDistances.self
    
    
    required public init() {}
    
}
