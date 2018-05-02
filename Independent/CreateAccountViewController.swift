//
//  CreateAccountViewController.swift
//  Independent
//
//  Created by Yoni Geer on 4/9/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import Parse

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    @IBAction func Create(_ sender: Any) {
        let user=PFUser()
        
        
        
        user.email = username.text;
        user.password = password.text;
        if let cut=(username.text)?.split(separator: "@"){
            user.username=String(cut[0])
        }
        else{
            print("Error converting email to username")
            user.username=username.text
        }
        
            
        user["TopSpeed"]=0;
        user["TopScore"]=0;
        user.acl?.hasPublicReadAccess = true
        // other fields can be set just like with PFObject
        user.signUpInBackground { (success, error) in
            if (error==nil) {
                print("Signed up")
                self.performSegue(withIdentifier: "tutorial", sender: self)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
