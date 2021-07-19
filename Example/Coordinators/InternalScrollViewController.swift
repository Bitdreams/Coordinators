//
//  InternalScrollViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

open class InternalScrollViewController<V: UIView & ScrollViewHolder>: InternalHostingViewController<V> {
    
    public var scrollView: UIScrollView {
        return hostedView.scrollView
    }
    
}
