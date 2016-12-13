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
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "EssayModalChange"), object: nil, queue: nil) { (note) -> Void in
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == SwiftEssayViewController.open_str {
            let controller:EssayDetailController? = segue.destination as? EssayDetailController
            if let con = controller {
                con.index = myDetailIndex!
            }
        }
    }
    deinit {
        print("dealloc \(self)")
    }
    //MARK: ui
    
    @IBAction func onNewEssay(_ sender: NSObject) {
        myDetailIndex = -1
        performSegue(withIdentifier: SwiftEssayViewController.open_str, sender: nil)
    }
    
    @IBAction func onSwipeLeft(_ sender: NSObject) {
        tabBarController?.selectedIndex = 3
    }
    
    @IBAction func onSwipeRight(_ sender: NSObject) {
        tabBarController?.selectedIndex = 1
    }
    
    //MARK: delegate
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return NSLocalizedString("删除", comment: lyCommentDefault)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myDelete = true
            
            EssayModel.instance().deleteEssay(by: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            myDelete = false
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            messageLabel.textColor = UIColor.lightGray
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SwiftEssayTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! SwiftEssayTableViewCell
        
        let essay = EssayModel.instance().getEssayBy(indexPath.row)
        cell.viewInitWithText(essay.text, time: essay.time)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        myDetailIndex = indexPath.row
        
        performSegue(withIdentifier: SwiftEssayViewController.open_str, sender: self)
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
