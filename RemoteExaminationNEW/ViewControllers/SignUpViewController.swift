//
//  SignUpViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 26.04.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHideKeyboard()
        
        configureNavigationBar()
        title = "Регистрация"
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
    
    private func configureNavigationBar() {
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
    
    
}

extension SignUpViewController: UITextFieldDelegate {

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

