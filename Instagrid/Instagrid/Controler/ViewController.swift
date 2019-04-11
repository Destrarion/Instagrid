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
    

    @IBOutlet weak var selectView1: UIImageView!
    
    @IBOutlet weak var selectView2: UIImageView!
    
    @IBOutlet weak var selectView3: UIImageView!
    
    @IBOutlet var swipeGestureOverall: UISwipeGestureRecognizer!
    
    @IBOutlet weak var showView: ShowView!
    
    override func viewDidLoad() {
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation == .portrait || orientation == .portraitUpsideDown{
            swipeGestureOverall.direction = .up
        }
        else{
            swipeGestureOverall.direction = .left
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation == .portrait || fromInterfaceOrientation == .portraitUpsideDown{
            swipeGestureOverall.direction = .left
        }else{
            swipeGestureOverall.direction = .up
        }
    }
    
    @IBAction func touchModeview(_ sender: UIButton){
        switch sender.tag {
        case 1:
            showView.modeView = .modeView1
            selectView1.isHidden = false
            selectView2.isHidden = true
            selectView3.isHidden = true
        case 2:
            showView.modeView = .modeView2
            selectView1.isHidden = true
            selectView2.isHidden = false
            selectView3.isHidden = true
        case 3:
            showView.modeView = .modeView3
            selectView1.isHidden = true
            selectView2.isHidden = true
            selectView3.isHidden = false
        default:
            print("errorModeView on the Switch")
        }
    }
    
    @IBAction func buttonShowView(_ sender: UIButton){
        self.currentButton = sender
        chooseImage((Any).self)
    }
    
    @IBAction func shareSwipeOverall(_ sender : UISwipeGestureRecognizer){
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isPortrait{
            
            swipeGestureOverall.direction = .up
            
            animateWhenSharing()
            
            let image = imageConversion(with: showView)
            
            
            if let imageToShare = image {
                let activityViewController = UIActivityViewController(activityItems: [imageToShare] as [Any], applicationActivities: nil)
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
        }else {
            swipeGestureOverall.direction = .left
            
            animateWhenSharingLandscape()
            
            let image = imageConversion(with: showView)
            
            if let imageToShare = image {
                let activityViewController = UIActivityViewController(activityItems: [imageToShare] as [Any], applicationActivities: nil)
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
        }
    }
    
    func chooseImage ( _ sender: Any){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.modalPresentationStyle = .overCurrentContext
        
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "choose a source", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        
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
        
        
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.showView.transform = translationTransformUp } , completion: nil)
        
    }
    
    func renitialisePositionShowView (){
        var translationTransformdown : CGAffineTransform
        translationTransformdown = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.showView.transform = translationTransformdown } , completion: nil)
        
    }
    
    func animateWhenSharingLandscape() {
        let screenWidth = UIScreen.main.bounds.width
        var translationTransformUp : CGAffineTransform
        translationTransformUp = CGAffineTransform(translationX: -screenWidth, y: 0)
        
        
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.showView.transform = translationTransformUp } , completion: nil)
        
    }
    
    
}
