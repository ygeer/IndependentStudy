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
    var view2=UIView()
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "logout", sender: self)
        
        
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        initializespinner()
        
      
        
    }
    func startspinner(){
        self.view.addSubview(view2)
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
        self.view2=UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        self.view2.backgroundColor=UIColor.lightGray
        self.view2.layer.cornerRadius = 10
        let wait = UIActivityIndicatorView(frame: CGRect(x:80, y:0, width: 250, height:50))
        wait.color=UIColor.black
        wait.hidesWhenStopped=false
        wait.startAnimating()
        let text=UILabel(frame: CGRect(x: 60, y: 0, width: 150, height: 50))
        text.text="Loading Table..."
        self.view2.addSubview(wait)
        self.view2.addSubview(text)
        self.view2.center=self.view.center
        self.view2.tag=1000
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count2=count
        //print(count2)
        return count2
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        self.startspinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopspinner()
            
            cell.textLabel?.text=usernamesaved[indexPath.row] + " - Speed : \(userspeeds[indexPath.row]) MPH; Score: \(topscores[indexPath.row])"
            //cell.textLabel?.text="sup"
            //print(usernamesaved[indexPath.row])
        }
        


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
