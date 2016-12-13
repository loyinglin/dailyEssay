//
//  TodoCollectionViewCell.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

class SwiftTodoCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: property
    @IBOutlet var myStartTime:UILabel?
    @IBOutlet var myDetail:UITextView?
    
    //MARK: init
    
    func viewInitWith(_ startTime: Date, text: String) {
        myDetail?.text = text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        myStartTime?.text = dateFormatter.string(from: startTime)
    }
    
    
    //MARK: ui
    
    
    //MARK: delegate
    
    
    //MARK: other
    
}
