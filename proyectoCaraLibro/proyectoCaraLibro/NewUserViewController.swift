//
//  NewUserViewController.swift
//  proyectoCaraLibro
//
//  Created by user191022 on 5/15/22.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class NewUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var password2TextField: UITextField!
    
    @IBOutlet weak var photoUpButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtName: UITextField!
    private let db = Firestore.firestore()
    

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    @IBAction private func tapToCloseKeyboard(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    @IBAction private func swipeToCloseKeyboard(_ sender: UISwipeGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    @IBAction private func swipeToOpenKeyboard(_ sender: UISwipeGestureRecognizer) {
            self.txtName.becomeFirstResponder()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.HideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
           signUpButton.layer.cornerRadius = 15
        photoUpButton.layer.cornerRadius = 15
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

    @IBAction func UploadPhotoAction(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage{
            
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        print(profileImageView)
                
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print ("canceled picker")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpButtonAction(_ sender: Any) {
        if emailTextField.text?.isEmpty == true{
            let alert = UIAlertController(title: "Error", message: "Debe ingresar un correo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Enter Bales", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
            return
        }
        if passwordTextField.text?.isEmpty == true{
            let alert = UIAlertController(title: "Error", message: "Debe ingresar una contrasena", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Enter Bales", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
            return
        }
        if password2TextField.text?.isEmpty == true{
            let alert = UIAlertController(title: "Error", message: "Debe ingresar una contrasena", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Enter Bales", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
            return
        }
        if passwordTextField.text != password2TextField.text {
            let alert = UIAlertController(title: "Error", message: "Las contrasenias deben coincidir", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Enter Bales", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
            return
        }

        
        login()
    }
    func login ()
    {
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password){
                (result, error) in
                
                if let result = result, error == nil{
                    
                    self.db.collection("users").document(email).setData([
                        "nombre":self.txtName.text ?? "",
                        "apellido":self.txtLastName.text ?? "",
                        "foto":self.profileImageView.image ?? ""
                    
                    ])
                    self.navigationController? .pushViewController(MenuViewController(email:result.user.email!), animated: true)
                    
                } else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
