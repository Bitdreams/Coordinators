//
//  StackViewController.swift
//  Coordinators_Example
//
//  Created by Raphael Cruzeiro on 19/07/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Coordinators

final class StackViewController: CScrollViewController<ScrollableVStack> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (0..<30).forEach { _ in
            let title = UUID().uuidString
            let v = UILabel()
            v.backgroundColor = .red
            v.textColor = .white
            v.text = title
            
            v.translatesAutoresizingMaskIntoConstraints = false
            v.heightAnchor.constraint(equalToConstant: 45).isActive = true
            v.setContentCompressionResistancePriority(.required, for: .vertical)
            
            hostedView.stackView.addArrangedSubview(v)
        }
        
    }
    
}
