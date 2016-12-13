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
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "TodoModelChange"), object: nil, queue: nil) { [unowned self](note) -> Void in
            self.myTodos?.reloadData()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil, queue: nil) { [unowned self](note) -> Void in
            self.myTodos?.reloadData()
        }
        
    }
    
    
    //MARK: ui
    
    @IBAction func onSwipeLeft(_ sender: NSObject) {
        tabBarController?.selectedIndex = 2
    }
    
    @IBAction func onSwipeRight(_ sender: NSObject) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func onNewTodo(_ sender: NSObject) {
        myDetailIndex = -1
        performSegue(withIdentifier: const_todo_detail, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == const_todo_detail {
            let controller:SwiftTodoDetailController = segue.destination as! SwiftTodoDetailController
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
            messageLabel.textColor = UIColor.lightGray
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            
            myTodos?.backgroundView = messageLabel
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lyShowEmptyTips()
        return TodoModel.instance().getTodoCounts()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todo", for: indexPath) as! SwiftTodoCollectionViewCell
        let item:Thing? = TodoModel.instance().getThingBy(indexPath.row)
        
        if item != nil {
            cell.viewInitWith(item!.startTime, text: item!.text)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size:CGSize = CGSize.zero
        size.width = UIScreen.main.bounds.size.width / 3 - 1
        size.height = 100
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        myDetailIndex = indexPath.row
        performSegue(withIdentifier: const_todo_detail, sender: nil)
        
        return true
    }
    
    
    
    //MARK: other
    
}
