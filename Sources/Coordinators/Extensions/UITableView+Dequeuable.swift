//
//  UITableView+Dequeuable.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

extension UITableViewCell: Dequeuable {
    public var reuseIdentifier: String? {
        return type(of: self).reuseIndentifier
    }
}

extension UITableView {
    public func register<T: UITableViewCell>(_: T.Type) {
        register(T.classForCoder(), forCellReuseIdentifier: T.reuseIndentifier)
    }
    
    public func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIndentifier, for: indexPath) as! T
    }
}
