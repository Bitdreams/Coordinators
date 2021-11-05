//
//  InternalViewModelViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

/// A view controller that is contrained to a specific view model type
/// This view controller automatically notifies its InternalCoordinator of any navigation change
open class InternalViewModelViewController<V: UIView, VM: ViewModel>: CHostingViewController<V>, ViewModelHolder {
    
    public let viewModel: VM
    
    public init(viewModel: VM = VM()) {
        self.viewModel = viewModel
        super.init()
    }
    
}
