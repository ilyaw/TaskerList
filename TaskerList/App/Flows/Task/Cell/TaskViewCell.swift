//
//  TaskViewCell.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

protocol RespondDelegate: AnyObject {
    func didTapRespond(id: Int)
}

class TaskViewCell: UITableViewCell {
    static let reuseId = "reuseIdentifier"

    // MARK: - Private set properties
    
    private(set) var titleLabel = UILabel()
    private(set) var respondButton = UIButton(type: .system)
    
    // MARK: - Delegate
    
    weak var delegate: RespondDelegate?
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Public methods
    
    func setupCell(with model: Task) {
        self.titleLabel.text = model.title
        self.respondButton.tag = model.id
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}

// MARK: - private extension

private extension TaskViewCell {
    enum Constrant {
        static let buttonWidth: CGFloat = 125
    }
    
    @objc
    func respondDidTap(_ sender: UIButton) {
       let id = sender.tag
        delegate?.didTapRespond(id: id)
    }
    
    func setupUI() {
        selectionStyle = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        respondButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(respondButton)
        
        respondButton.setTitle("Откликнуться", for: .normal)
        respondButton.addTarget(self, action: #selector(respondDidTap), for: .touchUpInside)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            respondButton.topAnchor.constraint(equalTo: topAnchor),
            respondButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor),
            respondButton.rightAnchor.constraint(equalTo: rightAnchor),
            respondButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            respondButton.widthAnchor.constraint(equalToConstant: Constrant.buttonWidth)
        ])
    }
}
