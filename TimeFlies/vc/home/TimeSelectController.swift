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
    func dismissViewController(_ controller: SwiftTimeSelectController)
}

class SwiftTimeSelectController: UIViewController {
    
    //MARK: property
    @IBOutlet var myDatePicker:UIDatePicker?
    var lyDelegate:SwiftModalViewControllerDelegate?
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDatePicker?.maximumDate = Date(timeIntervalSinceNow: 0)
        myDatePicker?.date = HomeModel.instance().getBirthDate()
        

        //TEST weak strong dance
        weak var weakSelf = self
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "EssayModelChange"), object: nil, queue: nil) { (note) -> Void in
            let strongSelf = weakSelf
            print("EssayModalChange is listen \(strongSelf)")

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        print("dealloc \(self)")
    }
    
    //MARK: ui
    @IBAction func onClose(_ sender: NSObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSave(_ sender: NSObject) {
        HomeModel.instance().setBirthDate(myDatePicker?.date)
        onClose(sender)
    }
    
    @IBAction func onValueChange(_ sender: NSObject) {
        print("date with \(myDatePicker?.date)")
    }
    
    
    
}
