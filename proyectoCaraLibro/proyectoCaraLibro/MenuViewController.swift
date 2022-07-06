//
//  MenuViewController.swift
//  proyectoCaraLibro
//
//  Created by user191222 on 6/8/22.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore

class MenuViewController: UIViewController{
    
    
    @IBOutlet weak var LogOutButton: UIButton!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    private let email: String
    lazy var userCollection = Firestore.firestore().collection("users").document(email)
    init(email: String){
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        LogOutButton.layer.cornerRadius = 10
        emailLabel.text = email
        getUsers()
        
    }
    func getUsers(){
        userCollection.getDocument{ (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    @IBAction func closeSessionButtonAction(_ sender: Any) {
        do{
        try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch{
            
        }
    }
}
