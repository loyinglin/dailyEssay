//
//  TodoDetailController.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

class SwiftTodoDetailController: UIViewController {
    
    
    //MARK: property
    @IBOutlet var myText:UITextView?
    var myIndex:Int = 0
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if myIndex >= 0 {
            let item:Thing? = TodoModel.instance().getThingByIndex(myIndex)
            if (item != nil) {
                myText?.text = item?.text
            }
        }
        
        customView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("dealloc \(self)")
    }
    
    //MARK: ui
    
    func customView() {
        
    }
    
    @IBAction func onSave(sender: NSObject) {
        if myIndex != -1 {
            TodoModel.instance().modifyTodoByIndex(myIndex, text: myText?.text)
        }
        else {
            TodoModel.instance().addNewTodo(myText?.text)
        }
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onDone(sender: NSObject) {
        if DoneModel.instance().getDoneCounts() > 0 {
            let controller = UIAlertController(title: NSLocalizedString("固定到时间轴", comment: lyCommentDefault), message: NSLocalizedString("固定后可在时间轴查看，同时不再可修改", comment: lyCommentDefault), preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("否", comment: lyCommentDefault), style: .Default, handler: nil)
            let okAction = UIAlertAction(title: NSLocalizedString("是", comment: lyCommentDefault), style: .Default, handler: { [unowned self](action) -> Void in
                self.onSure()
            })
            
            controller.addAction(okAction)
            controller.addAction(cancelAction)
            
            presentViewController(controller, animated: true, completion: nil)
        }
        else {
            onSure()
        }
    }
    
    func onSure() {
        if myIndex != -1 {
            TodoModel.instance().deleteTodoByIndex(myIndex)
        }
        DoneModel.instance().addNewPassByText(myText?.text, type: .pass_type_thing)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onDelete(sender: NSObject) {
        if myIndex != -1 {
            TodoModel.instance().deleteTodoByIndex(myIndex)
        }
        
        navigationController?.popViewControllerAnimated(true)
    }
    //MARK: delegate
    
    
}