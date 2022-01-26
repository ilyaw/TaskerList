//
//  ProposalPresenter.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

protocol ProposalPresenterInput: AnyObject {
    var proposalView: ProposalView { get }
    func showMessage(message: String)
}

protocol ProposalPresenterOutput: AnyObject {
    func configureController()
    func addObserverForKeyboardNotification()
    func removeObserverForKeyboardNotification()
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
}

class ProposalPresenter {
    
    // MARK: - Public properties
    
    weak var input: (UIViewController & ProposalPresenterInput)?
    
    // MARK: - Private properties
    
    private let router: Router
    private let taskId: Int
    
    // MARK: - Inits
    
    init(router: TaskRouter, taskId: Int) {
        self.router = router
        self.taskId = taskId
    }
}

// MARK: - ProposalPresenter + ProposalPresenterOutput

extension ProposalPresenter: ProposalPresenterOutput {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField {
        case view.userNameTextField:
            setTextField(textField: view.userNameTextField,
                         label: view.userNameValidLabel,
                         validType: .name,
                         wrongMessage: "a-z, A-Z, а-я, А-Я",
                         string: string,
                         range: range)
        case view.emailTextField:
            setTextField(textField: view.emailTextField,
                         label: view.emailValidLabel,
                         validType: .email,
                         wrongMessage: "Неверный формат",
                         string: string,
                         range: range)
        case view.phoneNumberTextField:
            view.phoneNumberTextField.text = setPhoneNumberMask(textField: view.phoneNumberTextField,
                                                                label: view.phoneValidLabel,
                                                                mask: "+X (XXX) XXX-XX-XX",
                                                                string: string,
                                                                range: range)
        case view.userPriceTextField:
            setTextField(textField: view.userPriceTextField,
                         label: view.userPriceValidLabel,
                         validType: .price,
                         wrongMessage: "0-9",
                         string: string,
                         range: range)
        default: break
        }
        
        return false
    }
    
    func configureController() {
        input?.navigationItem.largeTitleDisplayMode = .never
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        view.sendProposalButton.addTarget(self,
                                          action: #selector(didTapSendProposal),
                                          for: .touchUpInside)
    }
    
    func addObserverForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserverForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}

// MARK: - private extension

private extension ProposalPresenter {
    
    // MARK: - Private properties
    
    var view: ProposalView {
        return input?.proposalView ?? ProposalView()
    }
    
    // MARK: - objc methods
    
    @objc
    func keyboardWasShown(notification: Notification) {
        
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardFrameValue = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        
        let kbSize = keyboardFrameValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        view.scrollView.contentInset = contentInsets
        view.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        view.scrollView.contentInset = contentInsets
    }
    
    @objc
    func hideKeyboard() {
        view.scrollView.endEditing(true)
    }
    
    @objc
    func didTapSendProposal() {
        guard checkValidFields() else {
            input?.showMessage(message: "Некорректно заполнены поля")
            return
        }
        
        router.popToRootScreen()
    }
    
    func setTextField(textField: UITextField,
                      label: UILabel,
                      validType: String.ValidTypes,
                      wrongMessage: String,
                      string: String,
                      range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            setValidLabel(label, isValid: true, text: view.validSymbol)
        } else {
            setValidLabel(label, isValid: false, text: wrongMessage)
        }
    }
    
    func setPhoneNumberMask(textField: UITextField,
                            label: UILabel,
                            mask: String,
                            string: String,
                            range: NSRange) -> String {
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            setValidLabel(label, isValid: true, text: view.validSymbol)
        } else {
            setValidLabel(label, isValid: false, text: "Неверный формат...")
        }
        
        return result
    }
    
    func setValidLabel(_ label: UILabel, isValid: Bool, text: String?) {
        if isValid {
            label.textColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0, alpha: 1)
        } else {
            label.textColor = #colorLiteral(red: 0.5783785502, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
        
        label.text = text
    }
    
    func checkValidFields() -> Bool {
        guard let userName = view.userNameTextField.text, userName.isValid(validType: .name),
              let email = view.emailTextField.text, email.isValid(validType: .email),
              let phone = view.phoneNumberTextField.text, phone.isValid(validType: .phone),
              let userPrice = view.userPriceTextField.text, userPrice.isValid(validType: .price) else {
                  return false
              }
        
        return true
    }
}
