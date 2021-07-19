//
//  CScrollViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

open class CScrollViewController<V: UIView & ScrollViewHolder>: CHostingViewController<V> {
    
    public var scrollView: UIScrollView {
        return hostedView.scrollView
    }
    
}
