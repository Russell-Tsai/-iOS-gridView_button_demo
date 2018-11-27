//
//  GrideCollectionViewCell.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/25.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gridBackgroundView: UIView!
    @IBOutlet weak var gridSubView: UIView!
    @IBOutlet weak var gridLabel: UILabel!
    
    func cellHandler(indexPath : IndexPath){
        if indexPath.section % 2 == 0 {
            gridBackgroundView.backgroundColor = UIColor.TreviColor.gridPink
            gridSubView.backgroundColor = UIColor.TreviColor.gridRed
        }
        else {
            gridBackgroundView.backgroundColor = UIColor.TreviColor.gridGreen
            gridSubView.backgroundColor = UIColor.TreviColor.gridDeepGreen
        }
    }
}
