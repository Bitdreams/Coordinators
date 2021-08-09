//
//  InternalHostingViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

/// A view controller that is contrained to a specific view model type and hosts a specifc type of view
/// This view controller automatically notifies its InternalCoordinator of any navigation change
open class InternalHostingViewController<V: UIView>: InternalViewController {
    
    open var hostedView: V {
        return view as! V
    }
    
    open override func loadView() {
        self.view = V()
    }
    
}

