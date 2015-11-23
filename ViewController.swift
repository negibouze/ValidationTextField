//
//  ViewController.swift
//  ValidationTextField
//
//  Created by Yoshiaki Itakura on 2015/11/06.
//  Copyright © 2015年 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: ValidationTextField!
    @IBOutlet weak var msgLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(sender: UIButton) {
        textField.validate(
            [
                ValidationTextField.Rules.Require
                , ValidationTextField.Rules.MinLength
                , ValidationTextField.Rules.MaxLength
                , ValidationTextField.Rules.Numeric
            ],
            success: {},
            error: { msg in
                self.msgLabel.text = msg
            }
        )
    }
}

