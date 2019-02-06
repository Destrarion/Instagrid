//
//  ViewController.swift
//  Instagrid
//
//  Created by Fabien Dietrich on 08/01/2019.
//  Copyright © 2019 Fabien Dietrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var ButtonTopLeft: UIButton!
    
    @IBOutlet weak var ButtonTopRight: UIButton!
    
    
   
    @IBOutlet weak var ButtonBottomLeft: UIButton!
    
    @IBOutlet weak var ButtonBottomRight: UIButton!
    
    
    @IBOutlet weak var SelectedView1: UIImageView!
    
    @IBOutlet weak var SelectedView2: UIImageView!
    
    @IBOutlet weak var SelectedView3: UIImageView!
    
    
    @IBAction func TapViewMode1(_ sender: UIButton) {
        ButtonTopLeft.isHidden = false
        ButtonTopRight.isHidden = true
        ButtonBottomLeft.isHidden = false
        ButtonBottomRight.isHidden = false
        SelectedView1.isHidden = false
        SelectedView2.isHidden = true
        SelectedView3.isHidden = true
    }
    
    
    
    
    @IBAction func TapViewMode2(_ sender: UIButton) {
        ButtonTopLeft.isHidden = false
        ButtonTopRight.isHidden = false
        ButtonBottomLeft.isHidden = false
        ButtonBottomRight.isHidden = true
        SelectedView1.isHidden = true
        SelectedView2.isHidden = false
        SelectedView3.isHidden = true
    }
    
    @IBAction func TapViewMode3(_ sender: UIButton) {
        ButtonTopLeft.isHidden = false
        ButtonTopRight.isHidden = false
        ButtonBottomLeft.isHidden = false
        ButtonBottomRight.isHidden = false
        SelectedView1.isHidden = true
        SelectedView2.isHidden = true
        SelectedView3.isHidden = false
    }
    
    
    
    @IBAction func ButtonTopLeft(_ sender: UIButton) {
        chooseImage((Any).self)
    }
    
    @IBAction func ButtonTopRight(_ sender: UIButton) {
        chooseImage((Any).self)
    }
    
    @IBAction func ButtonBottomLeft(_ sender: UIButton) {
        chooseImage((Any).self)
    }
    
    @IBAction func ButtonBottomRight(_ sender: UIButton) {
        chooseImage((Any).self)
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
            ButtonTopLeft.setImage(image, for: .normal) 
            
        } else {
            print("Not able to get an image")
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}


