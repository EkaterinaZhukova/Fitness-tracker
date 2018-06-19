//
//  EnterViewController.swift
//  KR_7
//
//  Created by Екатерина on 17.06.2018.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit
import CoreData

class EnterViewController: UIViewController {

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var enterBT: UIButton!
     var arrUsers = [User]()
    var currentUser:User? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        arrUsers = try! context.fetch(fetchRequest) as! [User]
    }

    @IBAction func logIn(_ sender: Any) {
        let login:String = loginTF.text!
        let password:String = passwordTF.text!
        
        if(login == "" || password == ""){
            let alertController = UIAlertController(title: "Пустые поля!", message:
                "Проверьте введенные данные", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            var isUser = false
            for user in arrUsers{
                if(user.login! == login && user.password! == password){
                    isUser = true
                    currentUser = user
                    break
                }
            }
            if(!isUser){
                let alertController = UIAlertController(title: "Неверный логин и/или пароль", message:
                    "Проверьте введенные данные или зарегестрируйтесь", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "addTrainingID") as! AddNewTrainingViewController
                vc.currentUser = currentUser!
                loginTF.text = ""
                passwordTF.text = ""
                navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
