//
//  CTableViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

open class CTableViewController<V: UIView & TableViewHolder, VM: ListViewModel, C: CTableViewCell<VM.Item>>: CViewModelViewController<V, VM>, TableViewHolder, UITableViewDataSource {
    
    open override func setup() {
        super.setup()
          
        tableView.register(C.self)
        tableView.dataSource = self
    }
    
    open var tableView: UITableView {
        return hostedView.tableView
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBottomPaneInsets()
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel.section(for: section) else { return 0 }
        return section.items.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: C = tableView.dequeue(for: indexPath)
        cell.item = viewModel.item(for: indexPath)
        
        return cell
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.section(for: section)?.title
    }
    
    public func setupBottomPaneInsets() {
        super.setupBottomPaneInsets()
        adjustScrolViewInsets(scrollView, for: bottomPaneView)
    }
    
}
