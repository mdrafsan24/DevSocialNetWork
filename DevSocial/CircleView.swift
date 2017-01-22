//
//  CircleView.swift
//  DevSocial
//
//  Created by Rafsan Chowdhury on 1/21/17.
//  Copyright © 2017 Mcraf. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
       
    }
    
    
    
    
}
