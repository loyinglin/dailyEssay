//
//  TodoViewController.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

class SwiftTodoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    
    //MARK: property
    @IBOutlet var myTodos:UICollectionView?
    let const_todo_detail = "open_todo_detail_board"
    var myDetailIndex:Int = 0
    
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.myTodos?.collectionViewLayout
        NSNotificationCenter.defaultCenter().addObserverForName("TodoModelChange", object: nil, queue: nil) { [unowned self](note) -> Void in
            self.myTodos?.reloadData()
        }
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidChangeStatusBarOrientationNotification, object: nil, queue: nil) { [unowned self](note) -> Void in
            self.myTodos?.reloadData()
        }
        
    }
    
    
    //MARK: ui
    
    @IBAction func onSwipeLeft(sender: NSObject) {
        tabBarController?.selectedIndex = 2
    }
    
    @IBAction func onSwipeRight(sender: NSObject) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func onNewTodo(sender: NSObject) {
        myDetailIndex = -1
        performSegueWithIdentifier(const_todo_detail, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == const_todo_detail {
            let controller:SwiftTodoDetailController = segue.destinationViewController as! SwiftTodoDetailController
            controller.myIndex = myDetailIndex
        }
        
    }
    
    //MARK: delegate
    
    func lyShowEmptyTips() {
        if TodoModel.instance().getTodoCounts() > 0 {
            self.myTodos?.backgroundView = nil
        }
        else {
            let messageLabel = UILabel()
            messageLabel.text = NSLocalizedString("没有待办事件，请新建", comment: lyCommentDefault)
            messageLabel.textColor = UIColor.lightGrayColor()
            messageLabel.textAlignment = .Center
            messageLabel.sizeToFit()
            
            myTodos?.backgroundView = messageLabel
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lyShowEmptyTips()
        return TodoModel.instance().getTodoCounts()
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("todo", forIndexPath: indexPath) as! SwiftTodoCollectionViewCell
        let item:Thing? = TodoModel.instance().getThingByIndex(indexPath.row)
        
        if item != nil {
            cell.viewInitWith(item!.startTime, text: item!.text)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var size:CGSize = CGSizeZero
        size.width = UIScreen.mainScreen().bounds.size.width / 3 - 1
        size.height = 100
        
        return size
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        myDetailIndex = indexPath.row
        performSegueWithIdentifier(const_todo_detail, sender: nil)
        
        return true
    }
    
    
    
    //MARK: other
    
}