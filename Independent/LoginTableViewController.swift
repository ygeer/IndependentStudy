//
//  LoginTableViewController.swift
//  Independent
//
//  Created by Yoni Geer on 4/9/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import Parse

class LoginTableViewController: UITableViewController {

    var refresher:UIRefreshControl=UIRefreshControl()
    var userarr=[""]
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "logout", sender: self)
        
        
    }
    
    override func viewDidLoad() {
       
        /*let query=PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            print("step 1")
            if error == nil {
                print("no error")
                print(objects)
                if let users = objects {
                    print("step 2")
                    for user in users{
                        if let user2 = user as? PFUser {
                            print(user2)
                            if let username=user2.username as NSString?{
                                if let usercut=username as? String {
                                    let cut=usercut.split(separator: "@")
                                    //print(cut[0])
                                    let firstindex=cut[0]
                                    print(type(of: firstindex))
                                    
                                }
                            }
                        }
                    }
                } else {
                    print("could not get user")
                }
            } else {
                print("ERROR: \(error?.localizedDescription )")
            }
        })
 */
        
       
        super.viewDidLoad()
        //print(PFUser.current()?.username!)
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text=PFUser.current()?.username
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
