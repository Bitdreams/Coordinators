//
//  TableViewModel.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit

public protocol Section {
    
    associatedtype Item
    
    var title: String { get }
    var items: [Item] { get }
    
}

public protocol ListViewModel: ViewModel where Item == Section.Item {
    
    associatedtype Section: Coordinators.Section
    
    var sections: [Section] { get }
    var numberOfSections: Int { get }
    var isEmpty: Bool { get }
    
    init(sections: [Section])
    
    func section(for index: Int) -> Section?
    func item(for indexPath: IndexPath) -> Item?
    
}

public extension ListViewModel {
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func section(for index: Int) -> Section? {
        guard index < sections.count else { return nil }
        return sections[index]
    }
    
    func item(for indexPath: IndexPath) -> Item? {
        guard let section = section(for: indexPath.section),
              indexPath.row < section.items.count else { return nil }
        
        return section.items[indexPath.row]
    }
    
}
