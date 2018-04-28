//
//  ViewController.swift
//  Independent
//
//  Created by Yoni Geer on 4/9/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import Parse
var count=0
var usernamesaved=[""]
class ViewController: UIViewController {
    

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    @IBAction func login(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: username.text!, password: password.text!) { (user, error) in
            if user != nil {
                print("login successfull")
                let query=PFUser.query()
                
                query?.findObjectsInBackground(block: { (objects, error) in
                    //print("step 1")
                    if error == nil {
                       // print("no error")
                        //print(objects)
                        if let users = objects {
                           // print("step 2")
                            for user in users{
                                if let user2 = user as? PFUser {
                                   // print(user2)
                                    if let username=user2.username as String?{
                                        if usernamesaved[0]==""{
                                            usernamesaved.remove(at: 0)
                                        }
                                        let cut=username.split(separator: "@")
                                        usernamesaved.append(String(cut[0]))
                                        print(usernamesaved)
                                        
                                    }
                                }
                            }
                        } else {
                            print("could not get user")
                        }
                    }
                })
                //print("Username at index 0: \(usernamesaved[0])")
                self.performSegue(withIdentifier: "showUserTable", sender: self)
                
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
          /*  if PFUser.current() != nil{
                print(PFUser.current())
                self.performSegue(withIdentifier: "showUserTable", sender: self)
            }
            self.navigationController?.navigationBar.isHidden=true
 */
        
    
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

