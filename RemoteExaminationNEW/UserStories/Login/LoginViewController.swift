//
//  LoginViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 25.04.2022.
//

import Moya
import UIKit

final class LoginViewConroller: UIViewController {
    
    // Outlets
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var tap: UITapGestureRecognizer!
    
    // Actions
    @IBAction func noAccountButtonDidTap(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    @IBAction func logInButtonDidTap(_ sender: Any) {
        performLoginRequest { [weak self] result in
            switch result {
            case let .success(token):
                XAccessTokenService.shared.token = token
                let mainScreenViewController = MainScreenViewController()
                self?.navigationController?.pushViewController(mainScreenViewController, animated: true)
                
            case let .failure(error):
                self?.showOKAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextfields()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.contentInset.bottom = 0
    }
}

// MARK: - View configuration

private extension LoginViewConroller {
    
    func configureNavigationBar() {
        title = "Авторизация"
    }
    
    func configureTextfields() {
        initializeHideKeyboardLogic()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // TODO: for testign purposes
        emailTextField.text = "studentKolya@stud.nstu.ru"
        passwordTextField.text = "password"
        
        emailTextField.tag = 1
        passwordTextField.tag = 2
    }
}

// MARK: - Keyboard hiding behavior

private extension LoginViewConroller {
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
    
    func initializeHideKeyboardLogic() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissMyKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewConroller: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

// MARK: - Network

private extension LoginViewConroller {
    
    func encodeCredentials() -> String? {
        guard let encodedLoginCredentials = "\(emailTextField.text ?? ""):\(passwordTextField.text ?? "")".base64Encoded else {
            return nil
        }
        
        return encodedLoginCredentials
    }
    
    func performLoginRequest(completion: @escaping (Result<String, Error>) -> Void) {
        guard let encodedCredentials = encodeCredentials() else {
            completion(.failure(ExamsAPIError.credentialsEncodeError))
            return
        }
        
        let target = ExamsAPITarget(
            endpoint: .production,
            route: .login(encodedCredentials)
        )
        let provider = MoyaProvider<ExamsAPITarget>()
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                guard let loginResponse = try? response.map(LoginResponse.self) else {
                    completion(.failure(ExamsAPIError.wrongLogin))
                    return
                }
                completion(.success(loginResponse.token))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
