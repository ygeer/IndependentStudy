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
var userspeeds=[0]
var topscores=[0]
class ViewController: UIViewController, UITextFieldDelegate {
    
    var view1=UIView()
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBAction func login(_ sender: Any) {
        
        
        PFUser.logInWithUsername(inBackground: username.text!, password: password.text!) { (user, error) in
            if user != nil {
                print("login successfull")
                let query=PFUser.query()
                
                query?.findObjectsInBackground(block: { (objects, error) in
                    if error == nil {
        
                        if let users = objects {
                        
                            for user in users{
                                count=count+1
                                //print(count)
                                if let user2 = user as? PFUser {

                                    if let username=user2.username as String?{
                                        if usernamesaved[0]==""{
                                            usernamesaved.remove(at: 0)
                                            userspeeds.remove(at: 0)
                                            topscores.remove(at: 0)
                                        }
                                        let cut=username.split(separator: "@")
                                        usernamesaved.append(String(cut[0]))
                                        //print(usernamesaved)
                                    }
                                    if (user2["TopSpeed"]) != nil{
                                        let userspeed=user2["TopSpeed"] as? Int
                                        userspeeds.append(userspeed!)
                                        //print(userspeeds)
                                    }
                                    if(user2["TopScore"] != nil){
                                        let topscore=user2["TopScore"] as? Int
                                        topscores.append(topscore!)
                                        print(topscores)
                                    }
                                }
                            }
                        } else {
                            print("could not get user")
                        }
                    }
                })
                
                self.startspinner()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    print(count)
                    //print("Username at index 0: \(usernamesaved[0])")
                    self.stopspinner()
                    self.performSegue(withIdentifier: "showUserTable", sender: self)
                }
                
                
            }
        }
    }
    func startspinner(){
        self.view.addSubview(view1)
    }
    func stopspinner(){
        let subviews=self.view.subviews
        for subview in subviews{
            if subview.tag==1000{
                subview.removeFromSuperview()
            }
        }
    
    }
    func initializespinner(){
        self.view1=UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        self.view1.backgroundColor=UIColor.green
        self.view1.layer.cornerRadius = 10
        let wait = UIActivityIndicatorView(frame: CGRect(x:80, y:0, width: 250, height:50))
        wait.color=UIColor.black
        wait.hidesWhenStopped=false
        wait.startAnimating()
        let text=UILabel(frame: CGRect(x: 60, y: 0, width: 150, height: 50))
        text.text="Loggin in..."
        self.view1.addSubview(wait)
        self.view1.addSubview(text)
        self.view1.center=self.view.center
        self.view1.tag=1000
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.password.delegate=self
        initializespinner()
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password.resignFirstResponder()
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
          /*  if PFUser.current() != nil{
                print(PFUser.current())
                self.performSegue(withIdentifier: "showUserTable", sender: self)
            }
 */
            self.navigationController?.navigationBar.isHidden=true
 
        
    
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

