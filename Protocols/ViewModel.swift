//
//  ViewModel.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import Foundation

public protocol ViewModel: Initializable, AnyObject {
    associatedtype Item
}
