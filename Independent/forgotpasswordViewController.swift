//
//  forgotpasswordViewController.swift
//  Independent
//
//  Created by Yoni Geer on 4/11/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import Parse

class forgotpasswordViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var newpassword: UITextField!
    
    @IBAction func changePassword(_ sender: Any) {
         let query=PFUser.query()
         query?.findObjectsInBackground(block: { (objects, error) in
            if let users=objects{
                    for user in users{
                        if let user2=user as? PFUser{
                            if user2.username! == self.username.text{
                                let change=PFUser()
                                change.username=self.username.text
                                change.password=self.newpassword.text
                                change.signUpInBackground()
                                
                            }
                        }
                    }
            }
        })
    
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
