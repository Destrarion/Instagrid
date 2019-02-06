//
//  ShowView.swift
//  Instagrid
//
//  Created by Fabien Dietrich on 06/02/2019.
//  Copyright © 2019 Fabien Dietrich. All rights reserved.
//

import UIKit

class ShowView: UIView {

    @IBOutlet private var topLeftView : UIButton!
    @IBOutlet private var topRightView : UIButton!
    @IBOutlet private var bottomLeftView : UIButton!
    @IBOutlet private var bottomRightView : UIButton!
    
    
    @IBOutlet private var selectView1 : UIButton!
    @IBOutlet private var selectView2 : UIButton!
    @IBOutlet private var selectView3 : UIButton!
    
    @IBOutlet private var selectIcon1 : UIImageView!
    @IBOutlet private var selectIcon2 : UIImageView!
    @IBOutlet private var selectIcon3 : UIImageView!
    
    enum ModeView{
        case modeView1 , modeView2 , modeView3
    }
    var modeView : ModeView = .modeView1 {
        didSet{
            setModeView(modeView)
        }
    }

    private func setModeView ( _ modeView: ModeView){
        switch modeView{
        case .modeView1:
            topLeftView.isHidden = false
            topRightView.isHidden = true
            bottomLeftView.isHidden = false
            bottomRightView.isHidden = false
            selectIcon1.isHidden = false
            selectIcon2.isHidden = true
            selectIcon3.isHidden = true
            
        case .modeView2 :
            topLeftView.isHidden = false
            topRightView.isHidden = false
            bottomLeftView.isHidden = false
            bottomRightView.isHidden = true
            selectIcon1.isHidden = true
            selectIcon2.isHidden = false
            selectIcon3.isHidden = true
        
        case .modeView3:
            topLeftView.isHidden = false
            topRightView.isHidden = false
            bottomLeftView.isHidden = false
            bottomRightView.isHidden = false
            selectIcon1.isHidden = true
            selectIcon2.isHidden = true
            selectIcon3.isHidden = false
            
        }
    }
   
    
}
