//
//  RecoverPasswordViewController.swift
//  proyectoCaraLibro
//
//  Created by user191022 on 5/15/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAnalytics


class RecoverPasswordViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    
    @IBAction private func tapToCloseKeyboard(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    @IBAction private func swipeToCloseKeyboard(_ sender: UISwipeGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    @IBAction private func swipeToOpenKeyboard(_ sender: UISwipeGestureRecognizer) {
            self.txtEmail.becomeFirstResponder()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SendButton.layer.cornerRadius = 20
        
        //self.HideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
            //super.viewWillAppear(animated)
            //self.registerKeyboardNotifications()
        }

        override func viewWillDisappear(_ animated: Bool) {
            //super.viewWillDisappear(animated)
            //self.unregisterKeyboardNotifications()
        }
    
    @objc func Keyboard(notification: Notification){
        
        //let userInfo = notification.userInfo!
        
        //let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]) as! NSValue).cgRectValue
        let keyboardScreenEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }

    @IBAction func SendButton(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: txtEmail.text!) { (error) in
        if let error = error {
            let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
        return
                    }
            let alertController = UIAlertController(title:"Hurray", message:"A password reset email has been sent!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
                }
    }
    @IBAction private func clickBtnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
