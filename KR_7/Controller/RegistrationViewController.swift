//
//  RegistrationViewController.swift
//  KR_7
//
//  Created by Екатерина on 17.06.2018.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthYearTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var genderSC: UISegmentedControl!
    
    var arrUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        arrUsers = try! context.fetch(fetchRequest) as! [User]
        // Do any additional setup after loading the view.
    }

    
    @IBAction func registrationBT(_ sender: Any) {
        let name = nameTF.text
        let birthYear = birthYearTF.text
        let height = heightTF.text
        let weight = weightTF.text
        let login = loginTF.text
        let password = passwordTF.text
        let gender = genderSC.selectedSegmentIndex
        
        if(name! == "" || birthYear! == "" || height! == "" || weight! == "" || login! == "" || password! == "" || name == nil || birthYear == nil || height == nil || weight == nil || login == nil || password == nil){
            let alertController = UIAlertController(title: "Пустые поля!", message:
                "Проверьте введенные данные", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
      
        if(Int(birthYear!)! < 1900 || Double(height!)! < 60 || Double(weight!)! < 35){
            let alertController = UIAlertController(title: "Некорректные данные!", message:
                "Проверьте поля год рождения/ рост/ вес", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        var isAlreadyExist = false
        for user in arrUsers{
            if(login! == user.login! && password == user.password!){
                isAlreadyExist = true
                break
            }
        }
        if(isAlreadyExist){
            let alertController = UIAlertController(title: "Пользователь с таким логином и паролем уже существует!", message:
                "Измените логин и/или пароль", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newUser = User(context: context)
            newUser.name = name!
            newUser.birthyear = Int32(Int(birthYear!)!)
            newUser.height = Int32(Int(height!)!)
            newUser.weight = Double(weight!)!
            newUser.gender = Int32(gender)
            newUser.login = login!
            newUser.password = password!
            try! context.save()
            let vc = storyboard?.instantiateViewController(withIdentifier: "addTrainingID") as! AddNewTrainingViewController
            vc.currentUser = newUser
            
            nameTF.text = ""
            birthYearTF.text = ""
            heightTF.text = ""
            weightTF.text = ""
            passwordTF.text = ""
            loginTF.text = ""
            genderSC.selectedSegmentIndex = 0
            
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
