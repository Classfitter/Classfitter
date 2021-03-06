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
import RxSwift
import PromiseKit



protocol NewUserUIViewControllerDelegate: AnyObject {
    var state: ApplicationState { get }
    func closeNewUser(_ controller: NewUserUIViewController)
    func signInAnon(firstName: String, surname: String) -> Promise<Void>
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

    @IBOutlet weak var btnNext: UIButton!
    
    @IBAction func clickedNext(_ sender: AnyObject) {
        if let firstName=txtFirstName.text, let surname = txtSurname.text, firstName != "", surname != "" {
            lblValidation.text = ""
            btnNext.isEnabled = false
            delegate?.signInAnon(firstName: firstName, surname: surname).catch{ [weak self] error in
                print(error.localizedDescription)
                self?.lblValidation.text = "Unable to setup user"
                self?.btnNext.isEnabled = true
            }.then { [weak self] in
                self?.delegate?.closeNewUser(self!)
            }
        } else {
            lblValidation.text = "Please complete all the fields"
        }
    }
}
