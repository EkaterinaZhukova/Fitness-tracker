//
//  AddTrainingVC.swift
//  KR_7
//
//  Created by Екатерина on 16.06.2018.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit
import CoreData


class AddTrainingVC: UIViewController {

    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet weak var trainingTypeTF: UITextField!
    
    @IBOutlet weak var durationTF: UITextField!
    
    @IBOutlet weak var distanceTF: UITextField!
    let datePicker = UIDatePicker()
    
    @objc func donePressed(){
        let dateFormatter=DateFormatter()
        //dateFormatter.dateFormat = "YYYY-MM-dd"
        var orderDate=datePicker.date
        dateTF.text = "\(orderDate)"
        self.view.endEditing(true)
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .dateAndTime
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateTF.inputView = datePicker
        dateTF.inputAccessoryView = toolbar
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
