//
//  ViewController.swift
//  Instagrid
//
//  Created by Fabien Dietrich on 08/01/2019.
//  Copyright © 2019 Fabien Dietrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentButton : UIButton?
    
    @IBOutlet weak var SelectView1: UIImageView!
    
    @IBOutlet weak var SelectView2: UIImageView!
    
    @IBOutlet weak var SelectView3: UIImageView!
    
    @IBOutlet var SwipeUpOutlet: UISwipeGestureRecognizer!
    
    @IBOutlet var SwipeLeftOutlet: UISwipeGestureRecognizer!
    
    @IBOutlet weak var ShowView: ShowView!
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation == .portrait || fromInterfaceOrientation == .portraitUpsideDown{
            SwipeUpOutlet.isEnabled = false
            SwipeLeftOutlet.isEnabled = true
        }
        else{
            SwipeUpOutlet.isEnabled = true
            SwipeLeftOutlet.isEnabled = false
        }
    }
    
    @IBAction func TapViewMode1(_ sender: UIButton) {
        ShowView.modeView = .modeView1
        SelectView1.isHidden = false
        SelectView2.isHidden = true
        SelectView3.isHidden = true
    }
    
    @IBAction func TapViewMode2(_ sender: UIButton) {
        ShowView.modeView = .modeView2
        SelectView1.isHidden = true
        SelectView2.isHidden = false
        SelectView3.isHidden = true
    }
    
    @IBAction func TapViewMode3(_ sender: UIButton) {
        ShowView.modeView = .modeView3
        SelectView1.isHidden = true
        SelectView2.isHidden = true
        SelectView3.isHidden = false
    }
    
    
    
    @IBAction func ButtonTopLeft(_ sender: UIButton) {
        self.currentButton = sender
        chooseImage((Any).self)
    }
    
    @IBAction func ButtonTopRight(_ sender: UIButton) {
        self.currentButton = sender
        chooseImage((Any).self)
    }
    
    @IBAction func ButtonBottomLeft(_ sender: UIButton) {
        self.currentButton = sender
        chooseImage((Any).self)
    }
    
    @IBAction func ButtonBottomRight(_ sender: UIButton) {
        self.currentButton = sender
        chooseImage((Any).self)
    }
    
    
    
    //Sharing when in portrait
    @IBAction func ShareSwipePortrait(_ sender: UISwipeGestureRecognizer) {

    
            animateWhenSharing()
        
            let image = imageConversion(with: ShowView)
        
            let imageToShare = [ image! ]
            let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
            activityViewController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
                    print("Completed!")
                    self.renitialisePositionShowView()
                } else {
                    print("Canceled!!")
                    self.renitialisePositionShowView()
                }
            }
            present(activityViewController , animated: true) {
                print("Image Presented!")
            }
        
    }
    
    //Sharing when oriented in landscape
    @IBAction func ShareSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        animateWhenSharingLandscape()
        
        let image = imageConversion(with: ShowView)
        
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        activityViewController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("Completed!")
                self.renitialisePositionShowView()
            } else {
                print("Canceled!!")
                self.renitialisePositionShowView()
            }
        }
        present(activityViewController , animated: true) {
            print("Image Presented!")
        }
        
    }
    
    
    func chooseImage ( _ sender: Any){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
         actionSheet.addAction(UIAlertAction(title: "Photos Library", style: .default, handler: { (action: UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
         }))
        
         actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey  : Any]) {
    
        if let image = info[.originalImage] as? UIImage {
            
            print("image found")
            //do something with an image
            
           self.currentButton!.setImage(image, for: .normal)
            self.currentButton!.imageView?.contentMode = .scaleAspectFill
            
            
            
        }else {
            print("Not able to get an image")
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imageConversion(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func animateWhenSharing() {
        let screenHeight = UIScreen.main.bounds.height
        var translationTransformUp : CGAffineTransform
        translationTransformUp = CGAffineTransform(translationX: 0, y: -screenHeight)
        
        
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.ShowView.transform = translationTransformUp } , completion: nil)
        
    }
 
    func renitialisePositionShowView (){
        var translationTransformdown : CGAffineTransform
        translationTransformdown = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.ShowView.transform = translationTransformdown } , completion: nil)
        
    }
    
    func animateWhenSharingLandscape() {
        let screenWidth = UIScreen.main.bounds.width
        var translationTransformUp : CGAffineTransform
        translationTransformUp = CGAffineTransform(translationX: -screenWidth, y: 0)
        
        
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.ShowView.transform = translationTransformUp } , completion: nil)
        
    }
    
    
    
    
    
    
    
}
