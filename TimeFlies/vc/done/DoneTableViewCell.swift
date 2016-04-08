//
//  DoneTableViewCell.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

class SwiftDoneTableViewCell: UITableViewCell {
    
    
    //MARK: property
    @IBOutlet var myLeftText:UILabel?
    @IBOutlet var myRightText:UILabel?
    
    
    //MARK: init
    func viewInitWithTime(endTime:NSDate, text:String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSLocalizedString("yyyy年M月dd日", comment: lyCommentDefault)
        myLeftText?.text = dateFormatter.stringFromDate(endTime)
        myRightText?.text = text
    }
    
    
    //MARK: ui
    func clear() {
        myLeftText?.text = ""
        myRightText?.text = ""
    }
    
    //MARK: delegate
    
    
    //MARK: other
    
}