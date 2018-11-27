//
//  MainViewModel.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/23.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import UIKit

class MainViewModel: NSObject {
    
    
    
    /// 確認 TextField 輸入內容，若小於 1 或是非正整數類型，都讓 textField 顯示 1
    ///
    /// - Parameters:
    ///   - sender: 當前編輯結束的 textField
    ///   - text: 當前 textField 的內容
    func checkInputContent(_ sender : UITextField, text : String) {
        let invalidStr = CharacterSet(charactersIn: "0123456789").inverted
        if text.rangeOfCharacter(from: invalidStr) == nil {
            let cleanString = text.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
            sender.text = cleanString == "0" || cleanString.isEmpty ? "1" : cleanString
        }
        else {
           sender.text = "1"
        }
    }
    
    
    
    /// 建立尺寸資料模組
    ///
    /// - Parameters:
    ///   - row: input
    ///   - column: input
    /// - Returns: SizeModel return
    func getSizeModel(row : String, column : String) -> SizeModel{
        return SizeModel(row: Int(row)!, column: Int(column)!)
    }
    
}
