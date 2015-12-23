//
//  SetProfilePictureViewController.swift
//  Route
//
//  Created by Michael Williams on 12/22/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import Firebase

class SetProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Create a reference to a Firebase location
    var myFirebase = Firebase(url:"https://routeapp.firebaseio.com")
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var useCameraRollButton: UIButton!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var looksGoodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useCameraRoll(sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func setProfilePhoto(sender: AnyObject) {
        self.performSegueWithIdentifier("AccessContactsView", sender: sender)
    }
    
    func showDecisionButtons(show: Bool) {
        if(show == true) {
            useCameraRollButton.hidden = true
            useCameraRollButton.enabled = false
            
            changeButton.hidden = false
            changeButton.enabled = true
            
            looksGoodButton.hidden = false
            looksGoodButton.enabled = true
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        profilePicImageView.contentMode = .ScaleAspectFill
        
        //let radius: Float = Float(60);
        //let roundedImage = maskRoundedImage(image, radius: radius)
        profilePicImageView.layer.cornerRadius = 10;
        profilePicImageView.clipsToBounds = true
        profilePicImageView.image = image
        
        showDecisionButtons(true)
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func maskRoundedImage(image: UIImage, radius: Float) -> UIImage {
        let imageView: UIImageView = UIImageView(image: image)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(radius)
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
