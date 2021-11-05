//
//  StickBottomPaneHelper.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 03/08/2021.
//

import UIKit


/// This method is called to adjust the scroll view insets when a sticky bottom pane is present
///
/// Parameters:
/// - scrollView the UIScrollView whose insets will be adjusted
/// - bottomPane the frame of this UIView will be used to adjust the scrollView insets
func adjustScrolViewInsets(_ scrollView: UIScrollView, for bottomPane: UIView) {
    scrollView.contentInset.bottom = bottomPane.frame.height
}
