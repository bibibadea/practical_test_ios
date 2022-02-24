//
//  UITableView.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import UIKit

extension UITableView {
    
    // MARK: - Set Cell & Setup Table
    func set(cell: UITableViewCell.Type) {
        tableFooterView = UIView()
        tableHeaderView = UIView()
        separatorStyle = .none
        backgroundColor = .clear
        
        register(cell: cell)
    }
    
    func set(cells: [UITableViewCell.Type]) {
        tableFooterView = UIView()
        tableHeaderView = UIView()
        separatorStyle = .none
        backgroundColor = .clear
        
        register(cells: cells)
    }
    
    // MARK: - Register Cell
    func register(cell: UITableViewCell.Type) {
        let nib = UINib(nibName: cell.name, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.name)
    }
       
    func register(cells: [UITableViewCell.Type]) {
        cells.forEach {
            let nib = UINib(nibName: $0.name, bundle: nil)
            register(nib, forCellReuseIdentifier: $0.name)
        }
    }
    
    func register(header: UITableViewHeaderFooterView.Type) {
        let nib = UINib(nibName: header.name, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: header.name)
    }
    
    func register(headers: [UITableViewHeaderFooterView.Type]) {
        headers.forEach {
            let nib = UINib(nibName: $0.name, bundle: nil)
            register(nib, forHeaderFooterViewReuseIdentifier: $0.name)
        }
    }
    
    // MARK: - Dequeue Cell
    func dequeue<CellType: UITableViewCell>(withCell cell: CellType.Type, at indexPath: IndexPath) -> CellType {
        dequeueReusableCell(withIdentifier: cell.name, for: indexPath) as! CellType
    }
    
    func dequeue<CellType: UITableViewCell>(withCell cell: CellType.Type) -> CellType {
        dequeueReusableCell(withIdentifier: cell.name) as! CellType
    }
    
    func dequeue<HeaderType: UITableViewHeaderFooterView>(withHeader header: HeaderType.Type, at section: Int) -> HeaderType {
        dequeueReusableHeaderFooterView(withIdentifier: header.name) as! HeaderType
    }
}
