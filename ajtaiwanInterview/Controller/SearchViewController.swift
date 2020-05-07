//
//  SearchViewController.swift
//  ajtaiwanInterview
//
//  Created by HSU, Hong-Wei on 2020/5/4.
//  Copyright © 2020 HSU, Hong-Wei. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchText: UITextField!
    @IBAction func searchText(_ sender: Any) {
    }
    @IBOutlet weak var perPageText: UITextField!
    @IBAction func perPageText(_ sender: Any) {
    }
    @IBOutlet weak var requestButton: UIButton!
    @IBAction func requestButton(_ sender: UIButton) {
        performSegue(withIdentifier: "resultAPI", sender: UIButton.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let resultPage = nav.topViewController as! MainViewController
        resultPage.request = searchText.text!
        resultPage.perPage = perPageText.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
        MyFavorite.shared.getStringForKey()
    }

    func setupAddTargetIsNotEmptyTextFields() {
        requestButton.isUserInteractionEnabled = false
        requestButton.backgroundColor = UIColor.systemGray
        searchText.addTarget(self, action: #selector(textFieldsIsNotEmpty),for: .editingChanged)
        perPageText.addTarget(self, action: #selector(textFieldsIsNotEmpty),for: .editingChanged)
 
    }
    
    
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {

        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)

        guard
            let search = searchText.text, !search.isEmpty,
            let perPage = perPageText.text, !perPage.isEmpty
            else {
                self.requestButton.isUserInteractionEnabled = false
                self.requestButton.backgroundColor = UIColor.systemGray
                return
            }
     
        requestButton.isUserInteractionEnabled = true
        requestButton.backgroundColor = UIColor.systemBlue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}//class

