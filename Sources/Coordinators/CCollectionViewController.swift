//
//  CCollectionViewController.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 11/08/2021.
//

import UIKit

open class CCollectionViewController<V: UIView & CollectionViewHolder, VM: ListViewModel, C: CCollectionViewCell<VM.Item>>: CViewModelViewController<V, VM>, CollectionViewHolder, UICollectionViewDataSource {
    
    open override func setup() {
        super.setup()
          
        collectionView.register(C.self)
        collectionView.dataSource = self
    }
    
    open var collectionView: UICollectionView {
        return hostedView.collectionView
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBottomPaneInsets()
    }
    
    open  func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = viewModel.section(for: section) else { return 0 }
        return section.items.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: C = collectionView.dequeue(for: indexPath)
        cell.item = viewModel.item(for: indexPath)
        
        return cell
    }
    
    open func collectionView(_ collectionView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.section(for: section)?.title
    }
    
    public func setupBottomPaneInsets() {
        super.setupBottomPaneInsets()
        adjustScrolViewInsets(scrollView, for: bottomPaneView)
    }
    
}

