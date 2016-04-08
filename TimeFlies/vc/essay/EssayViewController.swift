//
//  EssayViewController.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

class SwiftEssayViewController:UITableViewController {
    
    
    //MARK: property
    static let open_str = "open_essay_detail_board"
    
    var myDetailIndex:Int?
    var myDelete:Bool?
    
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelectionDuringEditing = false
        myDelete = false
        weak var weakSelf = self
        NSNotificationCenter.defaultCenter().addObserverForName("EssayModalChange", object: nil, queue: nil) { (note) -> Void in
            let strongSelf = weakSelf
            if (strongSelf?.myDelete)! {
                return
            }
            strongSelf?.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == SwiftEssayViewController.open_str {
            let controller:EssayDetailController? = segue.destinationViewController as? EssayDetailController
            if let con = controller {
                con.index = myDetailIndex!
            }
        }
    }
    deinit {
        print("dealloc \(self)")
    }
    //MARK: ui
    
    @IBAction func onNewEssay(sender: NSObject) {
        myDetailIndex = -1
        performSegueWithIdentifier(SwiftEssayViewController.open_str, sender: nil)
    }
    
    @IBAction func onSwipeLeft(sender: NSObject) {
        tabBarController?.selectedIndex = 3
    }
    
    @IBAction func onSwipeRight(sender: NSObject) {
        tabBarController?.selectedIndex = 1
    }
    
    //MARK: delegate
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return NSLocalizedString("删除", comment: lyCommentDefault)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            myDelete = true
            
            EssayModel.instance().deleteEssayByIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            myDelete = false
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lyShowEmptyTips()
        return EssayModel.instance().getEssaysCount()
    }
    
    
    func lyShowEmptyTips() {
        if EssayModel.instance().getEssaysCount() > 0 {
            self.tableView.backgroundView = nil
        }
        else {
            let messageLabel = UILabel()
            messageLabel.text = NSLocalizedString("没有日记，请新建", comment: lyCommentDefault)
            messageLabel.textColor = UIColor.lightGrayColor()
            messageLabel.textAlignment = .Center
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SwiftEssayTableViewCell = tableView.dequeueReusableCellWithIdentifier("detail", forIndexPath: indexPath) as! SwiftEssayTableViewCell
        
        let essay = EssayModel.instance().getEssayByIndex(indexPath.row)
        cell.viewInitWithText(essay.text, time: essay.time)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        myDetailIndex = indexPath.row
        
        performSegueWithIdentifier(SwiftEssayViewController.open_str, sender: self)
        
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}