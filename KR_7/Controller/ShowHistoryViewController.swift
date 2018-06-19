//
//  ShowHistoryViewController.swift
//  KR_7
//
//  Created by Екатерина on 17.06.2018.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit
import CoreData

class ShowHistoryViewController: UIViewController, UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starDatetTF: UITextField!
    @IBOutlet weak var endDateTF: UITextField!
    let datePicker = UIDatePicker()
    var startDate:Date?
    var endDate:Date?
    
    var arrTrainings = [TrainingInfo]()
    var resultArr = [TrainingInfo]()
    let dateFormatter=DateFormatter()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "dynamic")! as UITableViewCell
        cell.textLabel?.text="\(resultArr[indexPath.row].type!) \(dateFormatter.string(from: resultArr[indexPath.row].date!))"
        cell.detailTextLabel?.text="\((resultArr[indexPath.row].distance)) км"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        createStartDataPicker()
        createEndDataPicker()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "TrainingInfo", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TrainingInfo")
        arrTrainings = try! context.fetch(fetchRequest) as! [TrainingInfo]
    }
    @objc func startPresed(tf:UITextField){
        
        startDate=datePicker.date
        starDatetTF.text = dateFormatter.string(from: startDate!)
        self.view.endEditing(true)
    }
    @objc func endPressed(tf:UITextField){
        
        endDate=datePicker.date
        endDateTF.text = dateFormatter.string(from: endDate!)
        self.view.endEditing(true)
    }
    func createStartDataPicker(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(startPresed))
        toolbar.setItems([doneButton], animated: false)
        starDatetTF.inputAccessoryView=toolbar
        starDatetTF.inputView=datePicker
    }
    func createEndDataPicker(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(endPressed))
        toolbar.setItems([doneButton], animated: false)
        endDateTF.inputAccessoryView=toolbar
        endDateTF.inputView=datePicker
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showButton(_ sender: Any) {
        resultArr.removeAll()
        if(startDate == nil || endDate == nil){
            let alertController = UIAlertController(title: "Ошибка!", message:
                "Проверьте ввели ли вы все данные", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            for train in arrTrainings{
                if(train.date! <= endDate! && train.date! >= startDate!){
                    resultArr.append(train)
                }
            }
        }
        tableView.reloadData()
    }
}
