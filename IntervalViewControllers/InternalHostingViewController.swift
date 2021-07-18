//
//  InternalHostingViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

open class InternalHostingViewController<V: UIView>: InternalViewController {
    
    open var hostedView: V {
        return view as! V
    }
    
    open override func loadView() {
        self.view = V()
    }
    
}

