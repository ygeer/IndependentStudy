//
//  AddphotoViewController.swift
//  Independent
//
//  Created by Yoni Geer on 4/9/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import Parse

class AddphotoViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var imagetopost: UIImageView!
    
    @IBAction func selectimage(_ sender: Any) {let imagepicker=UIImagePickerController()
        imagepicker.delegate=self
        imagepicker.sourceType=UIImagePickerControllerSourceType.photoLibrary
        imagepicker.allowsEditing=false
        self.present(imagepicker, animated: true, completion: nil)
    }
    @IBAction func post(_ sender: Any) {
        if let image=imagetopost.image{
            let postimage=PFObject(className: "Post")
            postimage["message"]=comment.text
            postimage["userid"]=PFUser.current()?.objectId
            if let imagedata=UIImagePNGRepresentation(image){
                let imagefile=PFFile(name: "image.png", data: imagedata)
                postimage["imagefile"]=imagefile
                postimage.saveInBackground(block: { (sucess, error) in
                    if sucess{
                        print("Succesfully saved")
                    }
                })
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagetopost.image=image
        }
        self.dismiss(animated: true, completion: nil)
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
