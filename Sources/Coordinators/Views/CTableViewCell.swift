//
//  CTableViewCell.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

open class CTableViewCell<Item>: UITableViewCell, ViewAware {
    
    open var item: Item?
    
    open unowned var view: UIView!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        view = self
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        setupStyle()
        setupStrings()
        setupLayout()
    }
 
    open func setupStyle() {}
    open func setupStrings() {}
    open func setupLayout() {}
    
}
