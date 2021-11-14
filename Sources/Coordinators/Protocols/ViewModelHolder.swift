//
//  ViewModelHolder.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import Foundation

public protocol ViewModelHolder {
    associatedtype VM: ViewModel
    var viewModel: VM { get }
}
