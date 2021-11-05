//
//  TextViewController.swift
//  Coordinators_Example
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Coordinators

class TextView: UIView, ScrollViewHolder {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    var scrollView: UIScrollView {
        return textView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TextViewController: CScrollViewController<TextView> {
    
    override var scrollViewKeyboardAdjustment: ScrollViewKeyboardAdjustment {
        return .bottomConstraint
    }
    
}
