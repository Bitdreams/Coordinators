//
//  StickBottomPaneHelper.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 03/08/2021.
//

import UIKit

func adjustScrolViewInsets(_ scrollView: UIScrollView, for bottomPane: UIView) {
    scrollView.contentInset.bottom = bottomPane.frame.height
}
