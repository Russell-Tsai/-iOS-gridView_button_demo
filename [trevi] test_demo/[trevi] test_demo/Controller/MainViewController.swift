//
//  ViewController.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/23.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import UIKit

let MISSION_SEGUE = "segueMission"

class MainViewController: UIViewController {
    
    @IBOutlet weak var textFieldRow: UITextField!
    @IBOutlet weak var textFieldColumn: UITextField!
    
    private var mainViewModel = MainViewModel()
    private var activeTextField = UITextField()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeTextField = textFieldRow
        
        textFieldRow.keyboardType = .numberPad
        textFieldColumn.keyboardType = .numberPad
        
        textFieldRow.delegate = self
        textFieldColumn.delegate = self
        
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        activeTextField.resignFirstResponder()
        performSegue(withIdentifier: MISSION_SEGUE, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == MISSION_SEGUE) {
            let controller = segue.destination as! MissionViewController
            guard let rowStr = textFieldRow?.text, let columnStr = textFieldColumn.text else {return}
            controller.sizeModel = mainViewModel.getSizeModel(row: rowStr, column: columnStr)
        }
    }
    
}

//MARK: - UITextFieldDelegate Methods
extension MainViewController : UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        mainViewModel.checkInputContent(textField, text: text)
        return true
    }
}
