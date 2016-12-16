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
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "DoneModelChange"), object: nil, queue: nil) { [unowned self](note) -> Void in
            self.tableView.reloadData()
        }
        
        if !WXApi.isWXAppInstalled() {
            navigationItem.rightBarButtonItem = nil
        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "FavoriteSuccess"), object: nil, queue: nil) { (note) -> Void in
            DoneModel.instance().clearCache()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == const_open_done_detail {
            let controller = segue.destination as! SwiftDoneDetailController
            controller.myIndex = myIndex
        }
    }
    //MARK: ui
    @IBAction func onSave(_ sender: NSObject) {
        let alertController = UIAlertController(title: NSLocalizedString("分享到微信收藏", comment: lyCommentDefault), message: NSLocalizedString("把时间轴所有的信息收藏到微信，同时清除时间轴的信息", comment: lyCommentDefault), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("否", comment: lyCommentDefault), style: .default, handler: nil)
        let okAction = UIAlertAction(title: NSLocalizedString("是", comment: lyCommentDefault), style: .default) { (action) -> Void in
            var str:String = ""
            
            for i in 0 ..< DoneModel.instance().getDoneCounts() {
                let item = DoneModel.instance().getThingBy(i)
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = NSLocalizedString("yyyy年MM月dd日", comment: lyCommentDefault)
                
                str = String(format: "%@%@ -- %@\n%@\n", str, dateformatter.string(from: (item?.startTime)!), dateformatter.string(from: (item?.endTime)!), (item?.text)!)
            }
            
            WeixinShare.instance().sendTextContent(str, scene: WXSceneFavorite)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onSwipeRight(_ sender: NSObject) {
        tabBarController?.selectedIndex = 2
    }
    
    @IBAction func onSwipeLeft(_ sender: NSObject) {
        
    }
    //MARK: delegate
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DoneModel.instance().getDoneCounts()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "done", for: indexPath) as! SwiftDoneTableViewCell
        
        let item = DoneModel.instance().getThingBy(indexPath.row)
        if item != nil {
            cell.viewInitWithTime((item?.endTime)!, text: (item?.text)!)
        }
        else {
            cell.clear()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        myIndex = indexPath.row
        performSegue(withIdentifier: const_open_done_detail, sender: nil)
        
        return nil
    }
    
    //MARK: other
    
}
