//
//  TableViewHolder.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

public protocol TableViewHolder: ScrolViewHolder {
    var tableView: UITableView { get }
    
    func add(tableHeaderView view: UIView)
}

public extension TableViewHolder {
    
    var scrollView: UIScrollView {
        return tableView
    }
    
    func add(tableHeaderView view: UIView) {}
    
}

public extension TableViewHolder where Self: Layoutable {
    
    func add(tableHeaderView view: UIView) {
        if tableView.tableHeaderView == nil {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = Self.layout.spacing.medium
            stackView.addArrangedSubview(UIView())
            stackView.addArrangedSubview(view)
            stackView.addArrangedSubview(UIView())
            
            let width = tableView.bounds.width - Self.layout.insets.left - Self.layout.insets.right
            
            stackView.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
            
            NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width).isActive = true
            
            var frame = stackView.frame
            stackView.setNeedsLayout()
            stackView.layoutIfNeeded()
            
            let size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            frame.size.height = size.height
            stackView.frame = frame
            
            let headerContainer = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: tableView.bounds.width,
                    height: stackView.frame.height
                )
            )
            
            headerContainer.addSubview(stackView)
            
            NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: headerContainer, attribute: .left, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: headerContainer, attribute: .right, multiplier: 1, constant: 0).isActive = true
            
            tableView.tableHeaderView = headerContainer
        }
    }
    

}
