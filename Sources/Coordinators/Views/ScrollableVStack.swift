//
//  ScrollableVStack.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//

import UIKit

open class ScrollableVStack: UIView, ScrollViewHolder, Layoutable, Setupable {

    public var scrollView = UIScrollView()
    
    public lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    public let contentView = UIView()
    
    public typealias Layout = CommonLayout
    
    open var layout: Layout {
        return Layout()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        setupStyle()
        setupStrings()
        setupLayout()
    }
    
    open func setupStyle() {
        stackView.spacing = layout.spacing.normal
    }
    
    open func setupStrings() {
    
    }
    
    open func setupLayout() {
        scrollView.fillSuperview()
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.fillSuperview(margingType: .safeArea, insets: layout.insets)
    }
    
}
