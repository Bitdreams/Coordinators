//
//  Layout.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

public protocol Layout: Initializable {
    var insets: UIEdgeInsets { get }
    var margin: LayoutDistances.Type { get }
    var spacing: LayoutDistances.Type { get }
}
