//
//  LoginViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 25.04.2022.
//

import UIKit

final class LoginViewConroller: UIViewController {
    
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    @IBAction func noAccountButtonDidTap(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @IBAction func logInButtonDidTap(_ sender: Any) {
        let mainScreenViewController = MainScreenViewController()
        navigationController?.pushViewController(mainScreenViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  emailTextField.becomeFirstResponder()
        initializeHideKeyboard()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.tag = 1
        passwordTextField.tag = 2

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

    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }

    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
    
    func initializeHideKeyboard(){
           //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(
               target: self,
               action: #selector(dismissMyKeyboard))
           
           //Add this tap gesture recognizer to the parent view
           view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
           //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
           //In short- Dismiss the active keyboard.
           view.endEditing(true)
       }
    
    //FIXME: There is some text in the emailTextField, if you remove the keyboard by tapping on some area of the screen, then when you tap on the emailTextField, the previous text disappears
    
    
    private func configureNavigationBar() {
        // TODO: Change BACK BUTTON color depending on theme color
        // navigationController?.navigationBar.tintColor = .black
        
        let label = UILabel()
        label.text = "Авторизация"
        label.font = UIFont.boldSystemFont(ofSize: 20)

        navigationItem.titleView = label
        
    }
}

extension LoginViewConroller: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
       if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
           nextField.becomeFirstResponder()
       } else {
           textField.resignFirstResponder()
       }
       return false
   }
}
