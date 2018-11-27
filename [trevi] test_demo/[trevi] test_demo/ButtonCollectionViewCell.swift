//
//  ButtonCollectionViewCell.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/25.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import UIKit

protocol ButtonCollectionViewCellDelegate : class{
    func cleanBtnPressed(index : Int)
}

class ButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var checkBtn: UIButton!
    weak var delegate : ButtonCollectionViewCellDelegate?
    
    func cellHandler(indexPath: IndexPath, clean : Bool){
        checkBtn.layer.cornerRadius = 5
        checkBtn.layer.borderWidth = 1
        checkBtn.tag = indexPath.row
        checkBtn.layer.borderColor = UIColor.gray.cgColor
        checkBtn.backgroundColor = clean ? UIColor.TreviColor.buttonColor : UIColor.TreviColor.hightLightColor
        
        checkBtn.addTarget(self, action: #selector(randReset(sender :)), for: .touchUpInside)
    }
    
    @objc
    private func randReset(sender : UIButton) {
        delegate?.cleanBtnPressed(index: sender.tag)
    }
}
