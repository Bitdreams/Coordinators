//
//  ViewController.swift
//  Coordinators
//
//  Created by raphaelcruzeiro on 11/18/2017.
//  Copyright (c) 2017 raphaelcruzeiro. All rights reserved.
//

import UIKit
import Coordinators

fileprivate func makeFruits() -> [Fruit] {
    return [
        "Avocado",
        "Apple",
        "Bananas",
        "Pears",
        "Kiwis",
        "Mangoes"
    ]
    .map(Fruit.init(name:))
}

struct Fruit {
    var name: String
}

class FruitListViewModel: ListViewModel {
    
    required init() {
        sections = [
            FruitSection(title: "These are fruits", items: makeFruits())
        ]
    }
    
    required init(sections: [FruitSection]) {
        self.sections = sections
    }
    
    var sections: [FruitSection]
    
    typealias Item = Fruit
    typealias Section = FruitSection

    struct FruitSection: Coordinators.Section {
        var title: String
        var items: [Fruit]
    }
    
}

struct HeaderDistances: LayoutDistances {
    static var small: CGFloat = 4
    
    static var medium: CGFloat = 8
    
    static var large: CGFloat = 16
    
    static var xlarge: CGFloat = 32
}

struct HeaderLayout: Layout {
    
    var insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var margin: LayoutDistances.Type = HeaderDistances.self
    var spacing: LayoutDistances.Type = HeaderDistances.self
    
    init() {
        
    }

}

class View: UIView, TableViewHolder, Layoutable {

    typealias Layout = HeaderLayout
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        
        tableView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Cell: CTableViewCell<Fruit> {
    
    override var item: Fruit? {
        didSet {
            textLabel?.text = item?.name ?? ""
        }
    }
    
}

class ViewController: CTableViewController<View, FruitListViewModel, Cell>, Layoutable {
    
    typealias Layout = HeaderLayout
    
    override init(viewModel: FruitListViewModel = FruitListViewModel()) {
        super.init(viewModel: viewModel)
        title = "Fruit list"
    }
    
    override func setup() {
        super.setup()
        
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let header = UILabel()
        header.textColor = .red
        header.text = "I really like big headers for no reason at all"
        header.font = .systemFont(ofSize: 24)
        header.numberOfLines = 0
        header.setContentCompressionResistancePriority(.required, for: .vertical)
        add(tableHeaderView: header)
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(TextViewController(), animated: true)
    }
    
    
}
