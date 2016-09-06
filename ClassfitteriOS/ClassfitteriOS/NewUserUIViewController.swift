//
//  WorkingUIViewController.swift
//  ClassfitteriOS
//
//  Created by James Wood on 24/08/2016.
//  Copyright © 2016 James Wood. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import RxCocoa
import RxSwift



protocol NewUserUIViewControllerDelegate: AnyObject {
    var state: ApplicationState { get }
    func closeNewUser(_ controller: NewUserUIViewController)
    
    
    func signInAnon(firstName: String, surname: String) -> Variable<String>
}

class NewUserUIViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    internal weak var delegate: NewUserUIViewControllerDelegate?
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var lblValidation: UILabel!

    @IBAction func clickedNext(_ sender: AnyObject) {
        if let firstName=txtFirstName.text, let surname = txtSurname.text {
            lblValidation.text = "Please complete all the fields"
            
            let signInStatus = delegate?.signInAnon(firstName: firstName, surname: surname)
            
            signInStatus?.asObservable().retry(5).
            
            self!.delegate!.closeNewUser(self!)
            
            
        }
    }
}
