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
    
    func viewInitWithText(text:String, time:NSDate) {
        myText?.text = text
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSLocalizedString("yyyy年MM月dd日 HH:mm:ss", comment: lyCommentDefault)
        
        myTime?.text = dateFormatter.stringFromDate(time)
    }
    
    
    deinit {
        print("dealloc \(self)")
    }
}