//
//  HighLightView.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/26.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import UIKit

class HighLightView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.TreviColor.hightLightColor.cgColor
        self.backgroundColor = UIColor.TreviColor.gridTransparent
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
