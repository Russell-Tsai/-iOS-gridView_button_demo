//
//  DataModel.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/25.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import Foundation

class SizeModel : NSObject{
    
    var row : Int
    var column : Int
    
    init(row : Int, column : Int) {
        self.row = row
        self.column = column
    }
}
