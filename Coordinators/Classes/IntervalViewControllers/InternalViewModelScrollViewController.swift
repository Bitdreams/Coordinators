//
//  InternalViewModelScrollViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

/// A simple scrollable view controller that is constrained to work with a specific view model
/// This view controller automatically notifies its InternalCoordinator of any navigation change
open class InternalViewModelScrollViewController<V: UIView & ScrollViewHolder, VM: ViewModel>: InternalViewModelViewController<V, VM> {
    
    let keyboardAnimationTime: TimeInterval = 0.3
    
    private var keyboardBottomConstraint: NSLayoutConstraint?
    
    public var scrollView: UIScrollView {
        return hostedView.scrollView
    }
    
    open var scrollViewKeyboardAdjustment: ScrollViewKeyboardAdjustment {
        return .none
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBottomPaneInsets()
    }
    
    public override func keyboardWillShow(endframe: CGRect?) {
        super.keyboardWillShow(endframe: endframe)
        
        switch scrollViewKeyboardAdjustment {
        case .bottomConstraint:
            let contraint = scrollView.bottomAnchor.constraint(equalTo: hostedView.bottomAnchor, constant: (endframe?.height ?? 0) * -1)
            contraint.priority = .required
            contraint.isActive = true
            keyboardBottomConstraint = contraint
            hostedView.setNeedsLayout()
            
            UIView.animate(withDuration: keyboardAnimationTime, animations: hostedView.layoutIfNeeded)
        case .contentInset:
            UIView.animate(withDuration: keyboardAnimationTime) {
                self.scrollView.contentInset.bottom = (endframe?.height ?? 0)
            }
        default:
            break
        }
    }
    
    public override func keyboardWillHide(endframe: CGRect?) {
        super.keyboardWillHide(endframe: endframe)
        
        switch scrollViewKeyboardAdjustment {
        case .contentInset:
            UIView.animate(withDuration: keyboardAnimationTime) {
                self.scrollView.contentInset.bottom = 0
            }
        case .bottomConstraint:
            keyboardBottomConstraint?.isActive = false
            keyboardBottomConstraint = nil
        default:
            break
        }
    }
    
    public func setupBottomPaneInsets() {
        super.setupBottomPaneInsets()
        adjustScrolViewInsets(scrollView, for: bottomPaneView)
    }
    
}
