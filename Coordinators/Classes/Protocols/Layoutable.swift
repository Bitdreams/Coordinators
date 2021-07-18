//
//  Layoutable.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import Foundation

public protocol Layoutable {
    
    associatedtype Layout: Coordinators.Layout
    
    static var layout: Layout { get }
    
}

public extension Layoutable {
    
    static var layout: Layout {
        return Layout()
    }
    
}
