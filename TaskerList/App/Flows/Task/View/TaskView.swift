//
//  TaskView.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

class TaskView: UIView {

    // MARK: - Private set properties
    
    let tableView = UITableView()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        tableView.frame = bounds
    }
}

// MARK: - Private extension

private extension TaskView {
    func setupView() {
        backgroundColor = .systemBackground
        
        addSubview(tableView)
    }
}
