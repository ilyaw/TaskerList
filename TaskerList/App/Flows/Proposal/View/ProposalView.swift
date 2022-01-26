//
//  ProposalView.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

class ProposalView: UIView {
    
    // MARK: - Public properties
    
    let scrollView: UIScrollView = {
        let scoll = UIScrollView()
        return scoll
    }()
    
    // MARK: - Base labels
    
    let userNameLabel = UILabel(text: "Как вас зовут?")
    let emailLabel = UILabel(text: "Ваш email")
    let phoneNumberLabel = UILabel(text: "Ваш телефон")
    let userPriceLabel = UILabel(text: "Укажите цену (в рублях)")
    
    // MARK: - Text fields
    
    let userNameTextField = UITextField(borderStyle: .roundedRect)
    let emailTextField = UITextField(borderStyle: .roundedRect)
    let phoneNumberTextField = UITextField(borderStyle: .roundedRect)
    let userPriceTextField = UITextField(borderStyle: .roundedRect)
    
    // MARK: - Button
    
    let sendProposalButton = UIButton(type: .system)
    
    // MARK: - Validation labels
    
    let validSymbol = "\u{2713}"
    
    let userNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userPriceValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - private extension

private extension ProposalView {
    enum Constrant {
        static let indentTop: CGFloat = 10
        static let indentLeft: CGFloat = 10
        static let indentRight: CGFloat = -10
        static let indentButtom: CGFloat = -10
        
        static let spacingStackView: CGFloat = 5
    }
    
    func setupUI() {
        backgroundColor = .systemBackground
        sendProposalButton.setTitle("Отправить", for: .normal)
        
        phoneNumberTextField.keyboardType = .numberPad
        userPriceTextField.keyboardType = .numberPad
        
        addSubview(scrollView)
        setupConstraints()
    }
    
    func setupConstraints() {
        let userNameStackView = UIStackView(arrangedSubviews: [userNameLabel,
                                                               userNameTextField,
                                                               userNameValidLabel],
                                            axis: .vertical,
                                            spacing: Constrant.spacingStackView)
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel,
                                                            emailTextField,
                                                            emailValidLabel],
                                         axis: .vertical,
                                         spacing: Constrant.spacingStackView)
        
        let phoneStackView = UIStackView(arrangedSubviews: [phoneNumberLabel,
                                                            phoneNumberTextField,
                                                            phoneValidLabel],
                                         axis: .vertical,
                                         spacing: Constrant.spacingStackView)
        
        let userPriceStackView = UIStackView(arrangedSubviews: [userPriceLabel,
                                                                userPriceTextField,
                                                                userPriceValidLabel],
                                             axis: .vertical,
                                             spacing: Constrant.spacingStackView)
        
        let stackView = UIStackView(arrangedSubviews: [userNameStackView,
                                                       emailStackView,
                                                       phoneStackView,
                                                       userPriceStackView,
                                                       sendProposalButton],
                                    axis: .vertical,
                                    spacing: 20)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        let viewSafeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: viewSafeArea.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: viewSafeArea.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: viewSafeArea.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: viewSafeArea.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constrant.indentTop),
            stackView.leftAnchor.constraint(equalTo: viewSafeArea.leftAnchor, constant: Constrant.indentLeft),
            stackView.rightAnchor.constraint(equalTo: viewSafeArea.rightAnchor, constant: Constrant.indentRight),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Constrant.indentButtom)
        ])
    }
}
