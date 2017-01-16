//
//  FancyView.swift
//  DevSocial
//
//  Created by Rafsan Chowdhury on 1/14/17.
//  Copyright © 2017 Mcraf. All rights reserved.
//

import UIKit

class FancyView: UIView {
    
    override func awakeFromNib() { // awakeFromNib gets called after the view and its subviews were allocated and initialized. It is guaranteed that the view will have all its outlet instance variables set.
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor // To Put some depth
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0) // This is all designing stuff
    }

}
