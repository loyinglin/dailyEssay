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
    func viewInitWithTime(_ endTime:Date, text:String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = NSLocalizedString("yyyy年M月dd日", comment: lyCommentDefault)
        myLeftText?.text = dateFormatter.string(from: endTime)
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
