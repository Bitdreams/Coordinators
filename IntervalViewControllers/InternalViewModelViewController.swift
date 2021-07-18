//
//  InternalViewModelViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

open class InternalViewModelViewController<V: UIView, VM: ViewModel>: CHostingViewController<V>, ViewModelHolder {
    
    public let viewModel: VM
    
    public init(viewModel: VM = VM()) {
        self.viewModel = viewModel
        super.init()
    }
    
}
