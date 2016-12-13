//
//  DoneDetailController.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

class SwiftDoneDetailController: UIViewController {
    
    
    //MARK: property
    @IBOutlet var myDoneDetail:UITextView?
    var myIndex:Int = 0
    
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item:PassThing? = DoneModel.instance().getThingBy(myIndex)
        if item != nil {
            myDoneDetail?.text = item!.text
        }
    }
    
    
    //MARK: ui
    
    
    //MARK: delegate
    
    
    //MARK: other
    
}
