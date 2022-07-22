//
//  ContactsViewController.swift
//  proyectoCaraLibro
//
//  Created by user190993 on 7/20/22.
//

import UIKit

class ContactsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpButton: UIButton!

    @IBAction private func tapToCloseKeyboard(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    @IBAction private func swipeToCloseKeyboard(_ sender: UISwipeGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    @IBAction private func swipeToOpenKeyboard(_ sender: UISwipeGestureRecognizer) {
            self.signUpButton.becomeFirstResponder()
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.HideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    @IBAction private func clickBtnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
