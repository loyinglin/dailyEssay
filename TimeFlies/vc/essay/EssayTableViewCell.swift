//
//  EssayTableViewCell.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation


class SwiftEssayTableViewCell: UITableViewCell {
    
    @IBOutlet var myText:UILabel?
    @IBOutlet var myTime:UILabel?
    
    func viewInitWithText(_ text:String, time:Date) {
        myText?.text = text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = NSLocalizedString("yyyy年MM月dd日 HH:mm:ss", comment: lyCommentDefault)
        
        myTime?.text = dateFormatter.string(from: time)
    }
    
    
    deinit {
        print("dealloc \(self)")
    }
}
