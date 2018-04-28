//
//  FeedTableViewController.swift
//  Independent
//
//  Created by Yoni Geer on 4/9/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    var users=[String: String]()
    var comments=[String]()
    var username=[String]()
    var imagefiles=[PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query=PFUser.query()
        query?.whereKey("username", notEqualTo: PFUser.current()?.username)
        query?.findObjectsInBackground(block: { (objects, error) in
            if let users=objects{
                for object in objects!{
                    if let user = object as? PFUser{
                        self.users[user.objectId!]=user.username!
                    }
                }
            }
            let getfollowedquery=PFQuery(className: "Following")
            getfollowedquery.whereKey("follower", equalTo: PFUser.current()?.objectId)
            getfollowedquery.findObjectsInBackground(block: { (objects, error) in
                if let followers=objects{
                    for follower in followers{
                        if let followeduser=follower["following"]{
                            let query = PFQuery(className: "Post")
                            query.whereKey("userid", equalTo: followeduser)
                            query.findObjectsInBackground(block: { (objects, error) in
                                if let posts=objects{
                                    for post in posts{
                                        self.comments.append(post["message"] as! String)
                                        self.username.append(self.users[post["userid"] as! String]!)
                                        self.imagefiles.append(post["imagefile"] as! PFFile)
                                        self.tableView.reloadData()
                                    }
                                }
                            })
                        }
                    }
                }
            })
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell

        cell.postedimage.image=UIImage(named: "space.jpg")
        cell.comment.text="Nice Picture"
        cell.userinfo.text=(PFUser.current()?["username"] as! String)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44  
        
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
