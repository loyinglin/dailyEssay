//
//  SwiftTimeSelectController.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

/**
 
*/
protocol SwiftModalViewControllerDelegate {
    func dismissViewController(controller: SwiftTimeSelectController)
}

class SwiftTimeSelectController: UIViewController {
    
    //MARK: property
    @IBOutlet var myDatePicker:UIDatePicker?
    var lyDelegate:SwiftModalViewControllerDelegate?
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDatePicker?.maximumDate = NSDate(timeIntervalSinceNow: 0)
        myDatePicker?.date = HomeModel.instance().getBirthDate()
        

        //TEST weak strong dance
        weak var weakSelf = self
        NSNotificationCenter.defaultCenter().addObserverForName("EssayModelChange", object: nil, queue: nil) { (note) -> Void in
            let strongSelf = weakSelf
            print("EssayModalChange is listen \(strongSelf)")

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        print("dealloc \(self)")
    }
    
    //MARK: ui
    @IBAction func onClose(sender: NSObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSave(sender: NSObject) {
        HomeModel.instance().setBirthDate(myDatePicker?.date)
        onClose(sender)
    }
    
    @IBAction func onValueChange(sender: NSObject) {
        print("date with \(myDatePicker?.date)")
    }
    
    
    
}