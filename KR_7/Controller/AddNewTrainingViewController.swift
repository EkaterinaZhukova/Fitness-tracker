//
//  AddNewTrainingViewController.swift
//  KR_7
//
//  Created by Екатерина on 17.06.2018.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit
import CoreData

class AddNewTrainingViewController: UIViewController {
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var trainingTypeTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    @IBOutlet weak var distanceTF: UITextField!
    let datePicker = UIDatePicker()
    var trainingDate:Date? = nil
    var currentUser = User()
    @objc func donePressed(){
        let dateFormatter=DateFormatter()
        trainingDate=datePicker.date
        dateTF.text = "\(trainingDate!)"
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
    @IBAction func addTraining(_ sender: Any) {
        let trainingType = trainingTypeTF.text
        let distance = Double(distanceTF.text!)
        let duration = Int(durationTF.text!)
        
        if(trainingType == "" || distance == nil || duration == nil || trainingDate == nil){
                let alertController = UIAlertController(title: "Некорректные данные", message:
                    "Проверьте введенные данные", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "TrainingInfo", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TrainingInfo")
        
        let newTraining = TrainingInfo(context: context)
        
        newTraining.date = trainingDate
        newTraining.distance = distance!
        newTraining.duration = Int32(duration!)
        newTraining.type = trainingType
        newTraining.user = currentUser
        if(newTraining.user == nil){
            print("Nil")
            
        }
        else{
            try! context.save()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
           print(currentUser.login)
    
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
