//
//  RxTableViewModel.swift
//  Coordinators
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//

import UIKit
import RxSwift

public protocol RxListViewModel: ViewModel where Item == Section.Item {
    
    associatedtype Section: Coordinators.Section
    
    var sections: BehaviorSubject<[Section]> { get }
    var numberOfSections: Int { get }
    var isEmpty: Bool { get }
    
    init(sections: [Section])
    
    func section(for index: Int) -> Section?
    func item(for indexPath: IndexPath) -> Item?
    
}

public extension RxListViewModel {
    
    var isEmpty: Bool {
        return (try? sections.value().isEmpty) ?? true
    }
    
    var numberOfSections: Int {
        (try? sections.value().count) ?? 0
    }
    
    func section(for index: Int) -> Section? {
        guard let sections = try? sections.value(),
            index < sections.count else { return nil }
        return sections[index]
    }
    
    func item(for indexPath: IndexPath) -> Item? {
        guard let section = section(for: indexPath.section),
              indexPath.row < section.items.count else { return nil }
        
        return section.items[indexPath.row]
    }
    
}
