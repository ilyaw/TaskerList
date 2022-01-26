//
//  ProposalViewController.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

class ProposalViewController: UIViewController {
     
    // MARK: - Private properties
    
    private let presenter: ProposalPresenterOutput
    
    // MARK: - Inits
    
    init(presenter: ProposalPresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = ProposalView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.configureController()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        presenter.addObserverForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.removeObserverForKeyboardNotification()
    }
    
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        proposalView.userNameTextField.delegate = self
        proposalView.emailTextField.delegate = self
        proposalView.phoneNumberTextField.delegate = self
        proposalView.userPriceTextField.delegate = self
    }
}

// MARK: - ProposalViewController + ProposalPresenterInput

extension ProposalViewController: ProposalPresenterInput {
    
    // MARK: - Public properties
    
    var proposalView: ProposalView {
        return (view as? ProposalView) ?? ProposalView()
    }
    
    // MARK: - Public methods
    
    func showMessage(message: String) {
        presentAlert(message: message)
    }
}

// MARK: - SignUpViewController + UITextFieldDelegate

extension ProposalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let result = presenter.textField(textField,
                                         shouldChangeCharactersIn: range,
                                         replacementString: string)
        
        return result
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        proposalView.userNameTextField.resignFirstResponder()
        proposalView.emailTextField.resignFirstResponder()
        proposalView.phoneNumberTextField.resignFirstResponder()
        proposalView.userPriceTextField.resignFirstResponder()
        return true
    }
}
