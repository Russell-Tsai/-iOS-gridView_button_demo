//
//  MissionViewModel.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/24.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import UIKit

class MissionViewModel: NSObject {
    
    var sizeModel : SizeModel!
    var randTimer : Timer!
    
    @objc dynamic var targetIndexPath : IndexPath!

    
    init(sizeModel : SizeModel) {
        super.init()
        self.sizeModel = sizeModel
        self.randTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(triggerRamdom), userInfo: nil, repeats: true)
    }
    
    
    /// 產生限定範圍內的隨機數
    ///
    /// - Returns: IndexPath
    func getRandomPosition() -> IndexPath {
        let ranRow = Int.random(in: 0 ... sizeModel.row - 1)
        let ranColumn = Int.random(in: 0 ... sizeModel.column - 1)
        
        return IndexPath(row: ranColumn, section: ranRow)
    }
    
    
    /// 由 Timer 定時觸發索呼叫隨機數的方法
    @objc func triggerRamdom(){
        targetIndexPath = getRandomPosition()
    }
    
    
    
    /// 釋放 Timer 的方法
    func endRandom(){
        if randTimer != nil {
            randTimer.invalidate()
            randTimer = nil
        }
    }
}
