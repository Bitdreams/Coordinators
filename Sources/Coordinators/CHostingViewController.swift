//
//  CHostingViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

open class CHostingViewController<V: UIView>: CViewController {
    
    open var hostedView: V {
        return view as! V
    }
    
    open override func loadView() {
        self.view = V()
    }
    
}
