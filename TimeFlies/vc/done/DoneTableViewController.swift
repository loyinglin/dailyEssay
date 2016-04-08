//
//  DoneTableViewController.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/8.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

class SwiftDoneTableViewController: UITableViewController {
    
    //MARK: property
    let const_open_done_detail = "open_done_detail_board"
    var myIndex:Int = 0
    
    
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName("DoneModelchange", object: nil, queue: nil) { [unowned self](note) -> Void in
            self.tableView.reloadData()
        }
        
        if !WXApi.isWXAppInstalled() {
            navigationItem.rightBarButtonItem = nil
        }

        NSNotificationCenter.defaultCenter().addObserverForName("FavoriteSuccess", object: nil, queue: nil) { (note) -> Void in
            DoneModel.instance().clearCache()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == const_open_done_detail {
            let controller = segue.destinationViewController as! SwiftDoneDetailController
            controller.myIndex = myIndex
        }
    }
    //MARK: ui
    @IBAction func onSave(sender: NSObject) {
        let alertController = UIAlertController(title: NSLocalizedString("分享到微信收藏", comment: lyCommentDefault), message: NSLocalizedString("把时间轴所有的信息收藏到微信，同时清除时间轴的信息", comment: lyCommentDefault), preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("否", comment: lyCommentDefault), style: .Default, handler: nil)
        let okAction = UIAlertAction(title: NSLocalizedString("是", comment: lyCommentDefault), style: .Default) { (action) -> Void in
            var str:String = ""
            
            for var i = 0; i < DoneModel.instance().getDoneCounts(); ++i {
                let item = DoneModel.instance().getThingByIndex(i)
                let dateformatter = NSDateFormatter()
                dateformatter.dateFormat = NSLocalizedString("yyyy年MM月dd日", comment: lyCommentDefault)
                
                str = String(format: "%@%@ -- %@\n%@\n", str, dateformatter.stringFromDate(item.startTime), dateformatter.stringFromDate(item.endTime), item.text)
            }
            
            WeixinShare.instance().sendTextContent(str, scene: WXSceneFavorite)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onSwipeRight(sender: NSObject) {
        tabBarController?.selectedIndex = 2
    }
    
    @IBAction func onSwipeLeft(sender: NSObject) {
        
    }
    //MARK: delegate
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DoneModel.instance().getDoneCounts()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("done", forIndexPath: indexPath) as! SwiftDoneTableViewCell
        
        let item = DoneModel.instance().getThingByIndex(indexPath.row)
        if item != nil {
            cell.viewInitWithTime(item.endTime, text: item.text)
        }
        else {
            cell.clear()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        myIndex = indexPath.row
        performSegueWithIdentifier(const_open_done_detail, sender: nil)
        
        return nil
    }
    
    //MARK: other
    
}